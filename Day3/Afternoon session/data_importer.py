from audioop import avg
from unicodedata import name
from pip import main
import requests
import urllib.parse
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import plotly.express as px
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import pvlib
import pvlib.solarposition as solpos
import pvlib.irradiance as irradiance
import os
from scipy.interpolate import interp1d


def create_filter(start_day, end_day, id):
    if end_day == None:
        filter_params = {
            "$filter":f"RowKey gt '{start_day}' and PartitionKey eq '{id}'"
            }
    else:
        filter_params = {
            "$filter":f"RowKey gt '{start_day}' and RowKey lt '{end_day}' and PartitionKey eq '{id}'"
            }
    return filter_params

def import_sensor(filter_params: dict):
    url = "https://elforsktablestorage.table.core.windows.net/dataexport"

    headers = {
        'Accept':'application/json;odata=nometadata'
    }

    auth_params = {
    "sv":"2020-08-04",
    "ss":"t",
    "srt":"sco",
    "sp":"r",
    "se":"2050-03-29T21:23:30Z",
    "st":"2022-03-29T13:23:30Z",
    "spr":"https,http",
    "sig":"wc%2FAUgl8qKYhRMLES2n2lZiBW8fZ%2FAjbawAXFIaxJjs%3D"
    }

    payload = {**filter_params,**auth_params}

    params = urllib.parse.urlencode(payload, quote_via=urllib.parse.quote,safe='/$:,%')


    r = requests.get(url,params=params,headers=headers)

    if r.status_code != 200:
        print(f"{r.status_code} {r.reason}:")
        print(r.text)
        exit()

    response_headers = list(r.headers.keys())

    result = r.json()['value']

    df = pd.DataFrame(result)
    i=1
    while "x-ms-continuation-NextPartitionKey" in response_headers:
        continuation_params = {
            "NextPartitionKey":r.headers["x-ms-continuation-NextPartitionKey"],
            "NextRowKey":r.headers["x-ms-continuation-NextRowKey"]
        }

        payload = {**filter_params,**auth_params,**continuation_params}

        params = urllib.parse.urlencode(payload, quote_via=urllib.parse.quote,safe='/$:,%!')


        r = requests.get(url,params=params,headers=headers)

        response_headers = list(r.headers.keys())
        
        result = pd.DataFrame(r.json()['value'])

        df = pd.concat([df,result])
        i+=1

    # print(f"Imported data in {i} iterations of 1000 rows")



    df["RowKey"] = pd.to_datetime(df["RowKey"])

    df = df.set_index("RowKey")

    return df

def import_multiple_sensors(start_day: str, end_day: str, ids: dict):
        
    dfs = {}

    for key in ids.keys():
        if type(ids[key]) == str:
            df = pd.DataFrame()
            filter_params = create_filter(start_day,end_day,ids[key])
            df = import_sensor(filter_params)
        elif type(ids[key]) == list:
            df = pd.DataFrame()
            
            for id in ids[key]:
                filter_params = create_filter(start_day, end_day, id)
                df = pd.concat([df, import_sensor(filter_params)])

        dfs[key] = df
    
    return dfs

def resample_with_interpolation(df,freq):
    t = df.index

    r = pd.date_range(t.min().round('H'), t.max(), freq=freq)

    df = df.reindex(t.union(r)).interpolate('index').loc[r]
    
    return df

def split_solar_radiation(ghi: pd.DataFrame, lat = 55.69904154295242, lon =  12.59298016695754, G_sc = 1366.1, ):
    """
    Split global horizontal irradiance (GHI) into direct normal irradiance (DNI) and the diffuse horizontal irradiation (DHI) using the DTU Model

    Arguments:
        ghi: dataframe with datetime index and GHI
    Returns:
        dni: dataframe with DNI
        dhi: datagrame with DHI
    """
    sol = solpos.get_solarposition(ghi.index,lat,lon)

    irr = pd.DataFrame(index=ghi.index)
    
    irr["ghi"] = ghi

    irr["dayofyear"] = irr.index.dayofyear
    
    irr["B"] = (irr["dayofyear"]-1)*2*np.pi/365

    # Calculate extraterrestrial radiation (G_0)
    irr["G_0n"] = irradiance.get_extra_radiation(ghi.index,G_sc) # Normal to solar pos

    irr["G_0"] = irr["G_0n"]*np.cos(np.radians(sol["zenith"])) # On horizontal surface
    
    irr["kT"] = irr["ghi"] / irr["G_0"]
    
    # # Calculate DHI for different kT-values
    irr.loc[(irr["kT"] < 0.29), "dhi"]                       = irr["ghi"]*(- 0.60921 * irr.kT**3 + 1.9982 * irr.kT**2 - 0.2787 * irr.kT + 1)
    irr.loc[(irr["kT"] >= 0.29) & (irr["kT"] < 0.72), "dhi"] = irr["ghi"]*(+ 3.99 * irr.kT**3 - 7.1469 * irr.kT**2 + 2.3996 * irr.kT + 0.746)
    irr.loc[(irr["kT"] >= 0.72) & (irr["kT"] < 0.8), "dhi"]  = irr["ghi"]*(+ 288.63 * irr.kT**4 - 625.26 * irr.kT**3 + 448.06 * irr.kT**2 - 105.84 * irr.kT)
    irr.loc[(irr["kT"] >= 0.80) & (irr["kT"] <= 1.2), "dhi"] = irr["ghi"]*(+ 65.89 * irr.kT**4 - 210.69 * irr.kT**3 + 222.91 * irr.kT**2 - 77.203 * irr.kT)
    irr.loc[(irr["kT"] >= 1.2), "dhi"]                       = None
    
    irr.loc[(irr["dhi"] > irr["ghi"]), "dhi"] = irr.loc[(irr["dhi"] > irr["ghi"]), "ghi"]
    
    
    irr["dhi"] = irr["dhi"].interpolate() # Interpolate NaN values
    
    # Calculate DNI
    irr["dni"] = irr["ghi"] - irr["dhi"]


    return irr, sol

def import_save_data(start_day = "2022-01-01T00:00:00Z", end_day = "2022-01-31T00:00:00Z", save_folder = "Resources/Data/Raw"):

    ids = {
        "primary":"1D5C0E",
        "secondary":"3C6173",
        "riser_CE":"3D84B4",
        "hc_C":"3D8570",
        "IC_AE":['BED234','34AFB8','34AD61'], # A east
        "IC_AW":['34AD81','34AF5D','34AE64'], # A west
        "IC_BE":['34AFCB','34ADED','BEE5D0'], # B east
        "IC_CE":['34BF4A','BEE3C3','BE7E82','C2F38D','34AE46'], # C east
        "IC_CW":['34ADD5','BE9F67','BE9F64'], # C west
        "IC_CX":['BEE5BD','34AD62','C2FA1D','34B05B','BE9677'], # C atrium
        "occupants_AP15": ['721','766','2931','765','2930'],
        "weather": "Weatherlink-AP15"
    }

    dfs = import_multiple_sensors(start_day, end_day,ids)

    isExist = os.path.exists(save_folder)

    if not isExist:
        # Create a new directory because it does not exist 
        os.makedirs(save_folder)
        print("The new directory is created!")

    for key in dfs.keys():
        dfs[key].to_csv(f"{save_folder}/{key}.csv")

def resample_temperatures(dfs, key = "IC_CE", freq = pd.Timedelta("5min")):
    
    # Resample temperatures
    temps = dfs[key].pivot(columns="PartitionKey", values="temperature")
    
    temps = resample_with_interpolation(temps,freq).round(1)

    # Find the zone avg temperature
    temps["avg"] = temps.mean(axis=1).round(1)
    temps["avg"] = temps["avg"].fillna(method="bfill")

    return temps

def resample_CO2(dfs,keys = ["IC_AE", "IC_AW", "IC_BE", "IC_CE", "IC_CW", "IC_CX"], freq = pd.Timedelta("5min")):
    co2 = dict()
    for i, key in enumerate(keys):
        co2[key] = dfs[key].pivot(columns="PartitionKey", values="CO2")
        
        co2[key] = resample_with_interpolation(co2[key],freq).round(1)
        co2[key]["avg"] = co2[key].mean(axis=1).round(1)
        # print(co2[key].head())
        if i == 0:
            avg_co2 = pd.DataFrame()
        avg_co2[key] = co2[key]["avg"]

    avg_co2["building"] = avg_co2.mean(axis=1).round(1)
    avg_co2 = avg_co2.fillna(method="bfill")

    return avg_co2

def resample_heating(dfs, key = "riser_CE", freq = pd.Timedelta("5min")):
    # Resample primary heating data
    heat_primary = dfs["primary"].drop(["PartitionKey","Timestamp",  "delta_MWh", "deviceType", "name", "delta_m3"],axis=1)

    heat_primary = resample_with_interpolation(heat_primary,freq).round(2)

    # Round
    heat_primary["MWh"] = heat_primary["MWh"].round(4)
    heat_primary["m3"] = heat_primary["m3"].round(2)
    heat_primary["temp_to"] = heat_primary["temp_to"].round(1)
    heat_primary["temp_return"] = heat_primary["temp_return"].round(1)

    # Calculate deltas
    heat_primary[["delta_MWh","delta_m3"]] = heat_primary[["MWh","m3"]].diff()

    # Resample secondary side of heat exchanger
    heat_secondary = dfs["secondary"].resample(freq)
    heat_secondary = heat_secondary.agg({"external_temperature_left":"mean","external_temperature_right":"mean"})
    heat_secondary.index = heat_secondary.index + freq

    # Get heat flow from primary side
    heat_secondary["delta_MWh"]=heat_primary["delta_MWh"]

    # Calculate average water flow in period:

    rho = 1000 # kg/m3
    c = 4.184 # kJ/(kg K)
    heat_secondary["delta_m3"] = (heat_primary["delta_MWh"]/(freq/pd.Timedelta(hours=1))*1000)/(rho*c*heat_secondary["external_temperature_left"]-heat_secondary["external_temperature_right"])*(freq/pd.Timedelta(seconds=1))


    heat_secondary["delta_m3"] = heat_secondary["delta_m3"].round(2)
    heat_secondary["external_temperature_left"] = heat_secondary["external_temperature_left"].round(1)
    heat_secondary["external_temperature_right"] = heat_secondary["external_temperature_right"].round(1)
    

        
    riser = dfs[key].drop(["PartitionKey", "Timestamp", "deviceType","name"],axis=1)

    riser = resample_with_interpolation(riser,freq).round(1)

    riser = riser.ewm(span=5).mean()

    return heat_primary, heat_secondary, riser

def resample_occupants(dfs, key = "occupants_AP15", freq = pd.Timedelta("5min")):
    occupants = dfs[key].pivot(columns="PartitionKey", values=["entered","exited"]).fillna(0)

    occupants = occupants.groupby(level=0, axis=1).sum()

    occupants["delta"] = occupants["entered"] - occupants["exited"]

    occupants = occupants.resample(freq,convention="end").mean() # Resample

    occupants = occupants.fillna(0)

    leave_time = 15.5

    lastvalue = 0
    lastvalue_bad = 0
    newcum = []
    badcumsum = []
    for idx, row in occupants.iterrows():
        thisvalue =  row['delta'] + lastvalue
        thisvalue_bad =  row['delta'] + lastvalue_bad
        if thisvalue < 0:
            thisvalue = 0
        if idx.hour + idx.minute/60 <= 15.5:
            value_at_15 = thisvalue
            idx_at_15 = idx
        if idx.hour + idx.minute/60 > leave_time and idx.hour + idx.minute/60 < leave_time+1:
            thisvalue = value_at_15*(1-pd.Timedelta(idx-idx_at_15)/pd.Timedelta(f'1h'))
        if idx.hour == 17:
            thisvalue = 0
            # print(f"Reset value on date: {idx}")
        newcum.append( thisvalue )
        badcumsum.append(thisvalue_bad)
        lastvalue = thisvalue
        lastvalue_bad = thisvalue_bad
    occupants['inhouse'] = newcum
    occupants['inhouse_bad'] = badcumsum


    occupants = occupants.ewm(span = 3).mean() # Smoothen curve
    
    occupants.index = occupants.index-freq # Reset index - overwrite might be necessary

    return occupants

def resample_weather(dfs, key = "weather", freq = pd.Timedelta("5min")):
    weather = dfs[key][["hum","solar_rad","temp","wind_dir_last","wind_speed_last"]]
    weather["temp"] = (weather["temp"]-32)*5/9 # Convert to celsius
    weather = resample_with_interpolation(weather,freq).round(1)

    # fig = px.line(weather["solar_rad"])
    # fig.show()

    weather = weather.ewm(span=10).mean()

    irr, sol = split_solar_radiation(weather["solar_rad"])

    weather[["ghi","dhi","dni"]] = irr[["ghi","dhi","dni"]]

    weather[["zenith","azimuth"]] = sol[["zenith","azimuth"]]

    solar_rad = pd.DataFrame(index=weather.index)

    solar_rad["north"] = pvlib.irradiance.get_total_irradiance(90,
                                                        0,
                                                        weather["zenith"],
                                                        weather["azimuth"],
                                                        weather["dni"],
                                                        weather["ghi"],
                                                        weather["dhi"]
                                                        )["poa_global"]

    solar_rad["east"] = pvlib.irradiance.get_total_irradiance(90,
                                                        90,
                                                        weather["zenith"],
                                                        weather["azimuth"],
                                                        weather["dni"],
                                                        weather["ghi"],
                                                        weather["dhi"]
                                                        )["poa_global"]

    solar_rad["south"] = pvlib.irradiance.get_total_irradiance(90,
                                                        180,
                                                        weather["zenith"],
                                                        weather["azimuth"],
                                                        weather["dni"],
                                                        weather["ghi"],
                                                        weather["dhi"]
                                                        )["poa_global"]

    solar_rad["west"] = pvlib.irradiance.get_total_irradiance(90,
                                                        270,
                                                        weather["zenith"],
                                                        weather["azimuth"],
                                                        weather["dni"],
                                                        weather["ghi"],
                                                        weather["dhi"]
                                                        )["poa_global"]

    return weather, solar_rad

def sig(x,n):
    return 1/(1 + np.exp(n*(-x)))

def create_ventilation_rate(idx,on_time = 4,off_time = 19):
    df = pd.DataFrame(index = idx)
    df["time"] = df.index
    df["verate"] = 0
    df["verate"][df["time"].dt.hour.between(on_time-1.5,on_time+1)] = [sig(x-on_time-0.25,15) if x > on_time-1 and x < off_time else 0 for x in df["time"].dt.hour+df["time"].dt.minute/60]
    df["verate"][df["time"].dt.hour.between(on_time+1,off_time)] = 1
    df["verate"][df["time"].dt.hour.between(off_time-1.5,off_time+1)] = [1-sig(x-off_time+0.25,15) for x in df["time"].dt.hour+df["time"].dt.minute/60]
    df["verate"].loc[df["time"].dt.weekday > 4] = 0
    
    return df["verate"]

def create_ventilation_stp(weather: pd.DataFrame):
    T_out = [-10,   0,      25,     35]
    T_ve =  [22.1,  22.1,   17.0,   17.0]
    ve_stp = pd.DataFrame(index=weather.index)
    ve_stp.index = pd.to_datetime(ve_stp.index)
    ve_stp["Tout"] = weather["temp"]
    interpolate_f = interp1d(T_out,T_ve,"linear")
    ve_stp["Tvest"] = interpolate_f(ve_stp["Tout"])

    ve_stp = ve_stp.drop(["Tout"],axis=1)

    return ve_stp

if __name__ == "__main__":
    import data_importer as data
    import pandas as pd
    import os
    import importlib
    import plotly.express as px

    folder_name = "May"

    raw_folder = f"Resources/Data/Raw/{folder_name}/"
    resampled_folder = raw_folder.replace("/Raw/","/Resampled/")

    # Path for raw data
    isExist = os.path.exists(resampled_folder)

    if not isExist:
        # Create a new directory because it does not exist 
        os.makedirs(resampled_folder)
        print("The new directory is created!")

    # Frequency for resampling
    freq = pd.Timedelta("5min") # Frequency for resampling


    files = [f for f in os.listdir(raw_folder) if os.path.isfile(os.path.join(raw_folder, f))]

    dfs = dict()

    for file in files:
        key = file.replace(".csv","")
        dfs[key] = pd.read_csv(os.path.join(raw_folder,file),index_col=0)
        dfs[key].index = pd.to_datetime(dfs[key].index)

        

    # Resample temps for building CE
    # temps_CE = data.resample_temperatures(dfs,"IC_CE",freq)

    # # Resample CO2
    # avg_co2 = data.resample_CO2(dfs, ["IC_AE", "IC_AW", "IC_BE", "IC_CE", "IC_CW", "IC_CX"], freq)

    # # Resample heating for building and riser CE
    # heat_primary, heat_secondary, riser_CE = data.resample_heating(dfs,"riser_CE",freq)

    # # Resample occupants
    # occupants = data.resample_occupants(dfs, "occupants_AP15", freq)
    # occupants[["inhouse","inhouse_bad"]].plot()

    # print("Done!")


    # # Resample weather
    weather, solar_rad = resample_weather(dfs, "weather", freq)

    # Find ventilation setpoint

    Tvest = create_ventilation_stp(weather)

    Tvest.plot()
    plt.show()

    # # Find largest 1st index
    # min_idx = max(temps_CE.index[0], avg_co2.index[0], heat_primary.index[0], occupants.index[0], weather.index[0], heat_secondary.index[0], riser_CE.index[0], solar_rad.index[0])
    # # Find smallest last index
    # max_idx = min(temps_CE.index[-1], avg_co2.index[-1], heat_primary.index[-1], occupants.index[-1], weather.index[-1], heat_secondary.index[-1], riser_CE.index[-1], solar_rad.index[-1])

    # print(f"Setting first value of each df to:\t {min_idx}")
    # print(f"Setting last value of each df to: \t {max_idx}")

    # # Align all dfs
    # temps_CE       = temps_CE.loc[min_idx:max_idx]
    # avg_co2        = avg_co2.loc[min_idx:max_idx]
    # heat_primary   = heat_primary.loc[min_idx:max_idx]
    # occupants      = occupants.loc[min_idx:max_idx]
    # weather        = weather.loc[min_idx:max_idx]
    # heat_secondary = heat_secondary.loc[min_idx:max_idx]
    # riser_CE       = riser_CE.loc[min_idx:max_idx]
    # solar_rad      = solar_rad.loc[min_idx:max_idx]

    # temps_CE.to_csv(os.path.join(resampled_folder, "temps_CE.csv"))
    # avg_co2.to_csv(os.path.join(resampled_folder, "avg_co2.csv"))
    # heat_primary.to_csv(os.path.join(resampled_folder, "heat_primary.csv"))
    # occupants.to_csv(os.path.join(resampled_folder, "occupants.csv"))
    # weather.to_csv(os.path.join(resampled_folder, "weather.csv"))
    # heat_secondary.to_csv(os.path.join(resampled_folder, "heat_secondary.csv"))
    # riser_CE.to_csv(os.path.join(resampled_folder, "riser_CE.csv"))
    # solar_rad.to_csv(os.path.join(resampled_folder, "solar_rad.csv"))