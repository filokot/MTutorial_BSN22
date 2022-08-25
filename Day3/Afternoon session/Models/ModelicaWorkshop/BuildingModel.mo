within ModelicaWorkshop;
model BuildingModel "Simple zone"

  package Air = Buildings.Media.Air(extraPropertiesNames={"CO2"})
    "Medium model";

  Modelica.Blocks.Interfaces.RealInput Tout "Outdoor temperature [degC]"
    annotation (Placement(transformation(extent={{-240,76},{-212,104}}),
        iconTransformation(extent={{-234,84},{-206,112}})));
  Modelica.Blocks.Interfaces.RealInput verate "Ventilation rate fraction [0-1]"
                                      annotation (Placement(transformation(
          extent={{-240,-92},{-212,-64}}), iconTransformation(extent={{-240,-92},
            {-212,-64}})));
  Modelica.Blocks.Interfaces.RealOutput T "[K]"
    annotation (Placement(transformation(extent={{216,110},{236,130}}),
        iconTransformation(extent={{216,110},{236,130}})));

  parameter Real TAirInit=20 "Initial temperature of indoor air [degC]";
  parameter Real Tstp=22 "Setpoint for indoor air temperature [degC]";
  parameter Real TretInit=40 "Initial return temperature [degC]";
  parameter Real CO2Init=400 "Initial CO2 concentration [ppmv]";
  parameter Real RExt=1.0 "External wall thermal resistance";
  parameter Real RInt=1.0 "Internal wall thermal resistance";
  parameter Real tmass=5 "Zone thermal mass factor [-]";
  parameter Real imass=10 "Zone internal thermal mass factor [-]";
  parameter Real shgcNorth=0.5 "Solar heat gain coefficient north [-]";
  parameter Real shgcSouth=0.5 "Solar heat gain coefficient south [-]";
  parameter Real shgcEast=0.5 "Solar heat gain coefficient east [-]";
  parameter Real shgcWest=0.5 "Solar heat gain coefficient west [-]";

  parameter Real CO2n=400 "CO2 Neutral Level";
  parameter Real CO2pp(unit="m3/h")=0.02 "CO2 generation per person [m3/h]";
  parameter Real maxVent=2000 "Maximum ventilation flowrate [m3/h]";
  parameter Real maxHeat=5000 "Heating power of radiators [W]";

  Modelica.Thermal.HeatTransfer.Components.ThermalResistor re(R=RExt/(3*Vi^(2/3)))
    annotation (Placement(transformation(extent={{-128,80},{-108,100}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{62,110},{82,130}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow occHeatGain
    annotation (Placement(transformation(extent={{-14,18},{6,38}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin
    annotation (Placement(transformation(extent={{182,110},{202,130}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
    annotation (Placement(transformation(extent={{-200,-56},{-180,-36}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
    annotation (Placement(transformation(extent={{-200,80},{-180,100}})));
  parameter Real Vi=3000
                        "Air volume [m3]";
  parameter Real occheff=1. "Occupant heat generation effectiveness";
  Modelica.Blocks.Math.Gain occeffectiv(k=84)
    annotation (Placement(transformation(extent={{-120,18},{-100,38}})));
  parameter Real Vinf=50 "Infiltration rate";
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor air(T(fixed=true,
        start=TAirInit + 273.15), C=tmass*1.2*1005*Vi)
    annotation (Placement(transformation(extent={{36,120},{56,140}})));
  OU44.Components.AirMix_new
                         airMix_new
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Blocks.Interfaces.RealInput Tvestp
    "Ventilation air setpoint temperature [degC]" annotation (Placement(
        transformation(extent={{-240,-60},{-212,-32}}), iconTransformation(
          extent={{-240,-60},{-212,-32}})));
  Modelica.Blocks.Interfaces.RealInput occ "Number of occupants"
    annotation (Placement(transformation(extent={{-240,20},{-212,48}}),
        iconTransformation(extent={{-234,2},{-206,30}})));
  Modelica.Blocks.Math.Gain heating(k=maxMassFlow)
    annotation (Placement(transformation(extent={{-110,-160},{-90,-140}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor IntMass(C=imass*1.2*1005
        *Vi, T(fixed=true, start=TAirInit + 273.15))
    annotation (Placement(transformation(extent={{108,158},{128,178}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor re1(R=RInt/(3*Vi^(2/3)))
    annotation (Placement(transformation(extent={{76,148},{96,168}})));
  Modelica.Blocks.Continuous.LimPID P_temp(
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    k=0.5,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    Ti=600) "Model of a proportional controller to represent TRVs"
    annotation (Placement(transformation(extent={{-142,-160},{-122,-140}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin1
    annotation (Placement(transformation(extent={{-50,-194},{-70,-174}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Buildings.Media.Water,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-72,-152},{-52,-132}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
    redeclare package Medium = Buildings.Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=TretInit + 273.15,
    nEle=1,
    fraRad=0,
    Q_flow_nominal=abs(nomPower),
    T_a_nominal=343.15,
    T_b_nominal=313.15,
    TRad_nominal=293.15)
    annotation (Placement(transformation(extent={{-38,-152},{-18,-132}})));
  Buildings.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        Buildings.Media.Water, nPorts=1) "Sink for the heating system"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={38,-142})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(
    redeclare package Medium = Buildings.Media.Water,
    allowFlowReversal=false,
    m_flow_nominal=rad.m_flow_nominal,
    T_start=TretInit + 273.15)
    annotation (Placement(transformation(extent={{-10,-152},{10,-132}})));
  Modelica.Blocks.Interfaces.RealOutput Tret annotation (Placement(
        transformation(extent={{216,-130},{236,-110}}), iconTransformation(
          extent={{214,-136},{234,-116}})));
  Modelica.Blocks.Interfaces.RealInput Tsup(final unit="degC")
    "Indoor temperature setpoint [degC]" annotation (Placement(transformation(
          extent={{-240,-132},{-212,-104}}), iconTransformation(extent={{-234,-186},
            {-206,-158}})));
  parameter Real maxMassFlow=50
    "Maximum mass flow through the radiators [kg/s]";
  parameter Real nomPower=5000 "Nominal lumped output of radiator(s)"
    annotation (Evaluate=false);
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin2
    annotation (Placement(transformation(extent={{-200,-128},{-180,-108}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin2
    annotation (Placement(transformation(extent={{180,-130},{200,-110}})));
  Modelica.Blocks.Math.Gain solarCoeffWest(k=shgcWest)
    annotation (Placement(transformation(extent={{-196,154},{-176,174}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow solarGainWest
    annotation (Placement(transformation(extent={{-158,154},{-138,174}})));
  Modelica.Blocks.Math.Gain solarCoeffEast(k=shgcEast)
    annotation (Placement(transformation(extent={{-196,194},{-176,214}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow solarGainEast
    annotation (Placement(transformation(extent={{-158,194},{-138,214}})));
  Modelica.Blocks.Math.Gain solarCoeffSouth(k=shgcSouth)
    annotation (Placement(transformation(extent={{-196,234},{-176,254}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow solarGainSouth
    annotation (Placement(transformation(extent={{-158,234},{-138,254}})));
  Modelica.Blocks.Math.Gain solarCoeffNorth(k=shgcNorth)
    annotation (Placement(transformation(extent={{-196,274},{-176,294}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow solarGainNorth
    annotation (Placement(transformation(extent={{-158,274},{-138,294}})));
  Modelica.Blocks.Interfaces.RealInput solrad_west "Solar radiation [W]"
    annotation (Placement(transformation(extent={{-242,150},{-214,178}}),
        iconTransformation(extent={{-234,166},{-206,194}})));
  Modelica.Blocks.Interfaces.RealInput solrad_east "Solar radiation [W]"
    annotation (Placement(transformation(extent={{-242,190},{-214,218}}),
        iconTransformation(extent={{-234,166},{-206,194}})));
  Modelica.Blocks.Interfaces.RealInput solrad_south "Solar radiation [W]"
    annotation (Placement(transformation(extent={{-242,230},{-214,258}}),
        iconTransformation(extent={{-234,166},{-206,194}})));
  Modelica.Blocks.Interfaces.RealInput solrad_north "Solar radiation [W]"
    annotation (Placement(transformation(extent={{-242,270},{-214,298}}),
        iconTransformation(extent={{-234,166},{-206,194}})));

  Modelica.Blocks.Sources.Constant const(k=Tstp)
    annotation (Placement(transformation(extent={{-206,-154},{-186,-134}})));
equation
  connect(prescribedTemperature.port, re.port_a)
    annotation (Line(points={{-140,90},{-128,90}}, color={191,0,0}));
  connect(temperatureSensor.T, fromKelvin.Kelvin)
    annotation (Line(points={{82,120},{180,120}},            color={0,0,127}));
  connect(T, fromKelvin.Celsius)
    annotation (Line(points={{226,120},{203,120}}, color={0,0,127}));
  connect(toKelvin1.Kelvin, prescribedTemperature.T)
    annotation (Line(points={{-179,90},{-162,90}},           color={0,0,127}));
  connect(toKelvin1.Celsius,Tout)
    annotation (Line(points={{-202,90},{-226,90}},           color={0,0,127}));
  connect(re.port_b, air.port)
    annotation (Line(points={{-108,90},{-108,90},{-80,90},{-80,120},{46,120}},
                                                 color={191,0,0}));
  connect(temperatureSensor.port, air.port)
    annotation (Line(points={{62,120},{62,120},{46,120}},
                                                  color={191,0,0}));
  connect(occHeatGain.port, air.port)
    annotation (Line(points={{6,28},{46,28},{46,120}},   color={191,0,0}));
  connect(temperatureSensor.T, airMix_new.Ti) annotation (Line(points={{82,120},
          {90,120},{90,-22},{90,-60},{0,-60},{0,-50.8}}, color={0,0,127}));
  connect(Tvestp, toKelvin.Celsius) annotation (Line(points={{-226,-46},{-226,
          -46},{-202,-46}}, color={0,0,127}));
  connect(airMix_new.port_b, air.port)
    annotation (Line(points={{10,-40},{46,-40},{46,120}}, color={191,0,0}));
  connect(re1.port_b, IntMass.port)
    annotation (Line(points={{96,158},{110,158},{118,158}}, color={191,0,0}));
  connect(re1.port_a, air.port) annotation (Line(points={{76,158},{62,158},{62,120},
          {46,120}}, color={191,0,0}));
  connect(P_temp.y, heating.u)
    annotation (Line(points={{-121,-150},{-112,-150}}, color={0,0,127}));
  connect(fromKelvin1.Celsius, P_temp.u_m) annotation (Line(points={{-71,-184},{
          -132,-184},{-132,-162}},  color={0,0,127}));
  connect(fromKelvin1.Kelvin, temperatureSensor.T) annotation (Line(points={{-48,
          -184},{90,-184},{90,120},{82,120}},     color={0,0,127}));
  connect(heating.y, boundary.m_flow_in) annotation (Line(points={{-89,-150},{-86,
          -150},{-86,-134},{-74,-134}},     color={0,0,127}));
  connect(boundary.ports[1], rad.port_a)
    annotation (Line(points={{-52,-142},{-38,-142}}, color={0,127,255}));
  connect(rad.heatPortRad, air.port) annotation (Line(points={{-26,-134.8},{-26,
          -120},{-28,-120},{-28,-108},{46,-108},{46,120}}, color={191,0,0}));
  connect(rad.heatPortCon, air.port) annotation (Line(points={{-30,-134.8},{-30,
          -120},{-28,-120},{-28,-108},{46,-108},{46,120}}, color={191,0,0}));
  connect(senTem.port_b, bou.ports[1])
    annotation (Line(points={{10,-142},{28,-142}}, color={0,127,255}));
  connect(senTem.port_a, rad.port_b)
    annotation (Line(points={{-10,-142},{-18,-142}}, color={0,127,255}));
  connect(boundary.T_in, toKelvin2.Kelvin) annotation (Line(points={{-74,-138},
          {-86,-138},{-86,-118},{-179,-118}},color={0,0,127}));
  connect(toKelvin2.Celsius, Tsup)
    annotation (Line(points={{-202,-118},{-226,-118}}, color={0,0,127}));
  connect(senTem.T, fromKelvin2.Kelvin)
    annotation (Line(points={{0,-131},{0,-120},{178,-120}}, color={0,0,127}));
  connect(fromKelvin2.Celsius, Tret)
    annotation (Line(points={{201,-120},{226,-120}}, color={0,0,127}));
  connect(solarGainWest.port, air.port) annotation (Line(points={{-138,164},{-80,164},
          {-80,120},{46,120}}, color={191,0,0}));
  connect(solarGainEast.port, air.port) annotation (Line(points={{-138,204},{-80,204},
          {-80,120},{46,120}}, color={191,0,0}));
  connect(solarGainSouth.port, air.port) annotation (Line(points={{-138,244},{-80,
          244},{-80,120},{46,120}}, color={191,0,0}));
  connect(solarGainNorth.port, air.port) annotation (Line(points={{-138,284},{-80,
          284},{-80,120},{46,120}}, color={191,0,0}));
  connect(solrad_west,solarCoeffWest. u) annotation (Line(points={{-228,164},{-198,
          164}},                 color={0,0,127}));
  connect(solrad_east,solarCoeffEast. u)
    annotation (Line(points={{-228,204},{-198,204}}, color={0,0,127}));
  connect(solrad_south,solarCoeffSouth. u)
    annotation (Line(points={{-228,244},{-198,244}}, color={0,0,127}));
  connect(solrad_north,solarCoeffNorth. u)
    annotation (Line(points={{-228,284},{-198,284}}, color={0,0,127}));
  connect(solarCoeffNorth.y, solarGainNorth.Q_flow)
    annotation (Line(points={{-175,284},{-158,284}}, color={0,0,127}));
  connect(solarCoeffSouth.y, solarGainSouth.Q_flow)
    annotation (Line(points={{-175,244},{-158,244}}, color={0,0,127}));
  connect(solarCoeffEast.y, solarGainEast.Q_flow)
    annotation (Line(points={{-175,204},{-158,204}}, color={0,0,127}));
  connect(solarCoeffWest.y, solarGainWest.Q_flow)
    annotation (Line(points={{-175,164},{-158,164}}, color={0,0,127}));
  connect(const.y, P_temp.u_s) annotation (Line(points={{-185,-144},{-164,-144},
          {-164,-150},{-144,-150}}, color={0,0,127}));
  connect(occ, occeffectiv.u) annotation (Line(points={{-226,34},{-174,34},{
          -174,28},{-122,28}}, color={0,0,127}));
  connect(occeffectiv.y, occHeatGain.Q_flow)
    annotation (Line(points={{-99,28},{-14,28}}, color={0,0,127}));
  connect(toKelvin.Kelvin, airMix_new.Tve) annotation (Line(points={{-179,-46},
          {-94,-46},{-94,-36.6},{-10.8,-36.6}}, color={0,0,127}));
  connect(verate, airMix_new.Vve) annotation (Line(points={{-226,-78},{-72,-78},
          {-72,-45},{-11,-45}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-280,
            -220},{280,360}},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{-208,138},{-100,66}},
          lineColor={28,108,200},
          fillColor={225,225,225},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-208,60},{16,-20}},
          lineColor={28,108,200},
          fillColor={225,225,225},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-204,136},{-148,126}},
          lineColor={28,108,200},
          fillColor={225,225,225},
          fillPattern=FillPattern.Solid,
          textString="External walls"),
        Text(
          extent={{-204,60},{-118,46}},
          lineColor={28,108,200},
          fillColor={225,225,225},
          fillPattern=FillPattern.Solid,
          horizontalAlignment=TextAlignment.Left,
          textString="Occ. heat gains and CO2"),
        Rectangle(
          extent={{-208,-26},{16,-96}},
          lineColor={28,108,200},
          fillColor={225,225,225},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-30,-82},{10,-92}},
          lineColor={28,108,200},
          fillColor={225,225,225},
          fillPattern=FillPattern.Solid,
          textString="Ventilation"),
        Rectangle(
          extent={{-208,-104},{16,-172}},
          lineColor={28,108,200},
          fillColor={225,225,225},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-208,-160},{-170,-170}},
          lineColor={28,108,200},
          fillColor={225,225,225},
          fillPattern=FillPattern.Solid,
          textString="Heating"),
        Rectangle(
          extent={{-208,316},{-124,144}},
          lineColor={28,108,200},
          fillColor={225,225,225},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-204,314},{-150,304}},
          lineColor={28,108,200},
          fillColor={225,225,225},
          fillPattern=FillPattern.Solid,
          horizontalAlignment=TextAlignment.Left,
          textString="Solar heat gains"),
        Rectangle(
          extent={{32,200},{146,104}},
          lineColor={28,108,200},
          fillColor={225,225,225},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{36,198},{138,184}},
          lineColor={28,108,200},
          fillColor={225,225,225},
          fillPattern=FillPattern.Solid,
          horizontalAlignment=TextAlignment.Left,
          textString="Thermal mass and air volume")}),
    experiment(Tolerance=1e-006),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-280,-220},{280,
            360}},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{-220,-220},{220,220}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-202,202},{200,-202}},
          pattern=LinePattern.None,
          lineColor={117,148,176},
          fillColor={170,213,255},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{-96,102},{96,-100}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid)}));
end BuildingModel;
