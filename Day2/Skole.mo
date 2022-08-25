within ;
package Skole
  model Skole_PID

    replaceable package MediumAir = IDEAS.Media.Air (extraPropertiesNames={"CO2"});

    // Building characteristics ---------------------------------------------------------------------------------------------------------------------------------------------
    parameter Modelica.Units.SI.Temperature T_start=MediumAir.T_default "Operative zonal start temperatures";

    parameter Integer nZones(min=1) = 5 "Number of conditioned thermal zones in the building";
    parameter Integer nEmb(min=0)=0 "Number of embedded systems in the building";

    // COMPONENTS - ----------------------------------------------------------------------------------------------------------------------------------------------
    Envelope.Structure Structure
      annotation (Placement(transformation(extent={{-70,10},{-30,30}})));
    Skole.Occupancy.Occupancy
                        Occupancy(nZones=5)
      annotation (Placement(transformation(extent={{-70,-30},{-30,-10}})));
    Skole.Ventilation.Ventilation
                            Ventilation(nZones=5)
      annotation (Placement(transformation(extent={{-70,50},{-30,70}})));
    Heating.PIDHeatingCooling PIDHeatingCooling(nZones=5)
      annotation (Placement(transformation(extent={{30,10},{70,30}})));
    Modelica.Blocks.Sources.RealExpression m_ex_vent_data[nZones](each y=0) annotation (Placement(transformation(extent={{-110,50},
              {-90,58}})));
    Modelica.Blocks.Sources.RealExpression m_sup_vent_data[nZones](each y=0) annotation (
       Placement(transformation(extent={{-110,62},{-90,70}})));
    Modelica.Blocks.Sources.RealExpression Qcon_data[nZones](each y=0)
      annotation (Placement(transformation(extent={{-110,-20},{-90,-12}})));
    Modelica.Blocks.Sources.RealExpression Qrad_data[nZones](each y=0)
      annotation (Placement(transformation(extent={{-110,-28},{-90,-20}})));
    Modelica.Blocks.Sources.RealExpression TSetCool_data[nZones](each y=27)
      annotation (Placement(transformation(extent={{-110,20},{-90,28}})));
    Modelica.Blocks.Sources.RealExpression TSetHeat_data[nZones](each y=20)
      annotation (Placement(transformation(extent={{-110,12},{-90,20}})));
    Records.BuildingZones buildingZones
      annotation (Placement(transformation(extent={{72,72},{88,88}})));
    Records.BuildingEnvelope buildingEnvelope
      annotation (Placement(transformation(extent={{72,52},{88,68}})));
    inner IDEAS.BoundaryConditions.SimInfoManager sim
      annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
  equation
    connect(m_sup_vent_data.y,Ventilation. m_sup) annotation (Line(points={{-89,66},
            {-74,66},{-74,62},{-69.8,62}}, color={0,0,127}));
    connect(m_ex_vent_data.y,Ventilation. m_ex) annotation (Line(points={{-89,54},
            {-74,54},{-74,58},{-69.8,58}}, color={0,0,127}));
    connect(Structure.heatPortEmb,PIDHeatingCooling. heatPortEmb) annotation (
        Line(points={{-30,25.8},{0,25.8},{0,26},{30,26}}, color={191,0,0}));
    connect(Structure.heatPortCon,PIDHeatingCooling. heatPortCon)
      annotation (Line(points={{-30,22},{30,22}}, color={191,0,0}));
    connect(Structure.heatPortRad,PIDHeatingCooling. heatPortRad)
      annotation (Line(points={{-30,18},{30,18}}, color={191,0,0}));
    connect(Qcon_data.y,Occupancy. Q_con) annotation (Line(points={{-89,-16},{-80,
            -16},{-80,-18},{-70,-18}}, color={0,0,127}));
    connect(Qrad_data.y,Occupancy. Q_rad) annotation (Line(points={{-89,-24},{-80,
            -24},{-80,-22},{-70,-22}}, color={0,0,127}));
    connect(Occupancy.heatPortCon,Structure. heatPortCon) annotation (Line(points=
           {{-30,-18},{-24,-18},{-24,22},{-30,22}}, color={191,0,0}));
    connect(Occupancy.heatPortRad,Structure. heatPortRad) annotation (Line(points=
           {{-30,-22},{-22,-22},{-22,18},{-30,18}}, color={191,0,0}));
    connect(Structure.T_oper_zone,PIDHeatingCooling. TSensor)
      annotation (Line(points={{-30,14},{30,14}}, color={0,0,127}));
    connect(Ventilation.Ventilation_ex,Structure. Vent_exh)
      annotation (Line(points={{-52,50},{-52,30}}, color={0,127,255}));
    connect(Ventilation.Ventilation_sup,Structure. Vent_sup) annotation (Line(
          points={{-48,50},{-48,40},{-47.8,40},{-47.8,30}}, color={0,127,255}));
    connect(TSetCool_data.y,PIDHeatingCooling. TSetCool) annotation (Line(points={
            {-89,24},{-74,24},{-74,6},{48,6},{48,10}}, color={0,0,127}));
    connect(TSetHeat_data.y,PIDHeatingCooling. TSetHeat) annotation (Line(points={
            {-89,16},{-76,16},{-76,4},{52,4},{52,10}}, color={0,0,127}));
    connect(sim.weaDatBus,Ventilation. weaBus) annotation (Line(
        points={{-30.1,-60},{0,-60},{0,80},{-50,80},{-50,70}},
        color={255,204,51},
        thickness=0.5,
        pattern=LinePattern.Dash));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio = false, extent = {{-120, 100}, {100, -80}})),
      experiment(
        StopTime=8640000,
        Interval=599.999616,
        __Dymola_Algorithm="Cvode"),
      __Dymola_experimentSetupOutput);
  end Skole_PID;

  model Skole_Radiator2

    replaceable package MediumAir = IDEAS.Media.Air (extraPropertiesNames={"CO2"});

    // Building characteristics ---------------------------------------------------------------------------------------------------------------------------------------------
    parameter Modelica.Units.SI.Temperature T_start=MediumAir.T_default "Operative zonal start temperatures";

    parameter Integer nZones(min=1) = 5 "Number of conditioned thermal zones in the building";
    parameter Integer nEmb(min=0)=0 "Number of embedded systems in the building";

    // COMPONENTS - ----------------------------------------------------------------------------------------------------------------------------------------------
    Envelope.Structure Structure
      annotation (Placement(transformation(extent={{-70,10},{-30,30}})));
    Skole.Occupancy.Occupancy
                        Occupancy(nZones=5)
      annotation (Placement(transformation(extent={{-70,-30},{-30,-10}})));
    Skole.Ventilation.Ventilation
                            Ventilation(nZones=5)
      annotation (Placement(transformation(extent={{-70,50},{-30,70}})));
    Heating.RadiatorHeating2 RadiatorHeating(nZones=5)
      annotation (Placement(transformation(extent={{30,10},{70,30}})));
    Modelica.Blocks.Sources.RealExpression m_ex_vent_data[nZones](each y=0) annotation (Placement(transformation(extent={{-110,50},
              {-90,58}})));
    Modelica.Blocks.Sources.RealExpression m_sup_vent_data[nZones](each y=0) annotation (
       Placement(transformation(extent={{-110,62},{-90,70}})));
    Modelica.Blocks.Sources.RealExpression Qcon_data[nZones](each y=0)
      annotation (Placement(transformation(extent={{-110,-20},{-90,-12}})));
    Modelica.Blocks.Sources.RealExpression Qrad_data[nZones](each y=0)
      annotation (Placement(transformation(extent={{-110,-28},{-90,-20}})));
    Modelica.Blocks.Sources.RealExpression TSetHeat_data[nZones](each y=20)
      annotation (Placement(transformation(extent={{-110,12},{-90,20}})));
    Records.BuildingZones buildingZones
      annotation (Placement(transformation(extent={{72,72},{88,88}})));
    Records.BuildingEnvelope buildingEnvelope
      annotation (Placement(transformation(extent={{72,52},{88,68}})));
    inner IDEAS.BoundaryConditions.SimInfoManager sim
      annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
    Modelica.Blocks.Sources.RealExpression TSetCool_data[nZones](each y=27)
      annotation (Placement(transformation(extent={{-110,20},{-90,28}})));
  equation
    connect(m_sup_vent_data.y,Ventilation. m_sup) annotation (Line(points={{-89,66},
            {-74,66},{-74,62},{-69.8,62}}, color={0,0,127}));
    connect(m_ex_vent_data.y,Ventilation. m_ex) annotation (Line(points={{-89,54},
            {-74,54},{-74,58},{-69.8,58}}, color={0,0,127}));
    connect(Structure.heatPortEmb,RadiatorHeating. heatPortEmb) annotation (Line(
          points={{-30,25.8},{0,25.8},{0,26},{30,26}}, color={191,0,0}));
    connect(Structure.heatPortCon,RadiatorHeating. heatPortCon)
      annotation (Line(points={{-30,22},{30,22}}, color={191,0,0}));
    connect(Structure.heatPortRad,RadiatorHeating. heatPortRad)
      annotation (Line(points={{-30,18},{30,18}}, color={191,0,0}));
    connect(Qcon_data.y,Occupancy. Q_con) annotation (Line(points={{-89,-16},{-80,
            -16},{-80,-18},{-70,-18}}, color={0,0,127}));
    connect(Qrad_data.y,Occupancy. Q_rad) annotation (Line(points={{-89,-24},{-80,
            -24},{-80,-22},{-70,-22}}, color={0,0,127}));
    connect(Occupancy.heatPortCon,Structure. heatPortCon) annotation (Line(points={{-30,-18},
            {-24,-18},{-24,22},{-30,22}},           color={191,0,0}));
    connect(Occupancy.heatPortRad,Structure. heatPortRad) annotation (Line(points={{-30,-22},
            {-22,-22},{-22,18},{-30,18}},           color={191,0,0}));
    connect(Structure.T_oper_zone,RadiatorHeating. TSensor)
      annotation (Line(points={{-30,14},{30,14}}, color={0,0,127}));
    connect(Ventilation.Ventilation_ex,Structure. Vent_exh)
      annotation (Line(points={{-52,50},{-52,30}}, color={0,127,255}));
    connect(Ventilation.Ventilation_sup,Structure. Vent_sup) annotation (Line(
          points={{-48,50},{-48,40},{-47.8,40},{-47.8,30}}, color={0,127,255}));
    connect(sim.weaDatBus,Ventilation. weaBus) annotation (Line(
        points={{-30.1,-60},{0,-60},{0,80},{-50,80},{-50,70}},
        color={255,204,51},
        thickness=0.5,
        pattern=LinePattern.Dash));
    connect(TSetHeat_data.y,RadiatorHeating. TSetHeat) annotation (Line(points={{-89,
            16},{-80,16},{-80,6},{52,6},{52,9.6}}, color={0,0,127}));
    connect(TSetCool_data.y, RadiatorHeating.TSetCool) annotation (Line(points=
            {{-89,24},{-78,24},{-78,8},{48,8},{48,10}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Skole_Radiator2;

  model Skole_Radiator5

    replaceable package MediumAir = IDEAS.Media.Air (extraPropertiesNames={"CO2"});

    // Building characteristics ---------------------------------------------------------------------------------------------------------------------------------------------
    parameter Modelica.Units.SI.Temperature T_start=MediumAir.T_default "Operative zonal start temperatures";

    parameter Integer nZones(min=1) = 5 "Number of conditioned thermal zones in the building";
    parameter Integer nEmb(min=0)=0 "Number of embedded systems in the building";

    // COMPONENTS - ----------------------------------------------------------------------------------------------------------------------------------------------
    Envelope.Structure Structure
      annotation (Placement(transformation(extent={{-70,10},{-30,30}})));
    Skole.Occupancy.Occupancy
                        Occupancy(nZones=5)
      annotation (Placement(transformation(extent={{-70,-30},{-30,-10}})));
    Skole.Ventilation.Ventilation
                            Ventilation(nZones=5)
      annotation (Placement(transformation(extent={{-70,50},{-30,70}})));
    Heating.RadiatorHeating5b RadiatorHeating(nZones=5)
      annotation (Placement(transformation(extent={{30,10},{70,30}})));
    Modelica.Blocks.Sources.RealExpression m_ex_vent_data[nZones](each y=0) annotation (Placement(transformation(extent={{-110,50},
              {-90,58}})));
    Modelica.Blocks.Sources.RealExpression m_sup_vent_data[nZones](each y=0) annotation (
       Placement(transformation(extent={{-110,62},{-90,70}})));
    Modelica.Blocks.Sources.RealExpression Qcon_data[nZones](each y=0)
      annotation (Placement(transformation(extent={{-110,-20},{-90,-12}})));
    Modelica.Blocks.Sources.RealExpression Qrad_data[nZones](each y=0)
      annotation (Placement(transformation(extent={{-110,-28},{-90,-20}})));
    Modelica.Blocks.Sources.RealExpression TSetHeat_data[nZones](each y=20)
      annotation (Placement(transformation(extent={{-110,12},{-90,20}})));
    Records.BuildingZones buildingZones
      annotation (Placement(transformation(extent={{72,72},{88,88}})));
    Records.BuildingEnvelope buildingEnvelope
      annotation (Placement(transformation(extent={{72,52},{88,68}})));
    inner IDEAS.BoundaryConditions.SimInfoManager sim
      annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
    Modelica.Blocks.Sources.RealExpression TSetCool_data[nZones](each y=27)
      annotation (Placement(transformation(extent={{-110,20},{-90,28}})));
  equation
    connect(m_sup_vent_data.y,Ventilation. m_sup) annotation (Line(points={{-89,66},
            {-74,66},{-74,62},{-69.8,62}}, color={0,0,127}));
    connect(m_ex_vent_data.y,Ventilation. m_ex) annotation (Line(points={{-89,54},
            {-74,54},{-74,58},{-69.8,58}}, color={0,0,127}));
    connect(Structure.heatPortEmb,RadiatorHeating. heatPortEmb) annotation (Line(
          points={{-30,25.8},{0,25.8},{0,26},{30,26}}, color={191,0,0}));
    connect(Structure.heatPortCon,RadiatorHeating. heatPortCon)
      annotation (Line(points={{-30,22},{30,22}}, color={191,0,0}));
    connect(Structure.heatPortRad,RadiatorHeating. heatPortRad)
      annotation (Line(points={{-30,18},{30,18}}, color={191,0,0}));
    connect(Qcon_data.y,Occupancy. Q_con) annotation (Line(points={{-89,-16},{-80,
            -16},{-80,-18},{-70,-18}}, color={0,0,127}));
    connect(Qrad_data.y,Occupancy. Q_rad) annotation (Line(points={{-89,-24},{-80,
            -24},{-80,-22},{-70,-22}}, color={0,0,127}));
    connect(Occupancy.heatPortCon,Structure. heatPortCon) annotation (Line(points={{-30,-18},
            {-24,-18},{-24,22},{-30,22}},           color={191,0,0}));
    connect(Occupancy.heatPortRad,Structure. heatPortRad) annotation (Line(points={{-30,-22},
            {-22,-22},{-22,18},{-30,18}},           color={191,0,0}));
    connect(Structure.T_oper_zone,RadiatorHeating. TSensor)
      annotation (Line(points={{-30,14},{30,14}}, color={0,0,127}));
    connect(Ventilation.Ventilation_ex,Structure. Vent_exh)
      annotation (Line(points={{-52,50},{-52,30}}, color={0,127,255}));
    connect(Ventilation.Ventilation_sup,Structure. Vent_sup) annotation (Line(
          points={{-48,50},{-48,40},{-47.8,40},{-47.8,30}}, color={0,127,255}));
    connect(sim.weaDatBus,Ventilation. weaBus) annotation (Line(
        points={{-30.1,-60},{0,-60},{0,80},{-50,80},{-50,70}},
        color={255,204,51},
        thickness=0.5,
        pattern=LinePattern.Dash));
    connect(TSetHeat_data.y,RadiatorHeating. TSetHeat) annotation (Line(points={{-89,
            16},{-80,16},{-80,6},{52,6},{52,9.6}}, color={0,0,127}));
    connect(TSetCool_data.y, RadiatorHeating.TSetCool) annotation (Line(points=
            {{-89,24},{-78,24},{-78,8},{48,8},{48,10}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=31536000,
        Interval=599.999616,
        __Dymola_Algorithm="Cvode"));
  end Skole_Radiator5;

  package Envelope
    model Structure

      replaceable package MediumAir = IDEAS.Media.Air (extraPropertiesNames={"CO2"});

      // Building characteristics ---------------------------------------------------------------------------------------------------------------------------------------------
      parameter Modelica.Units.SI.Temperature T_start=MediumAir.T_default
        "Operative zonal start temperatures";

      parameter Integer nZones(min=1) = 5 "Number of conditioned thermal zones in the building";
      parameter Integer nEmb(min=0)=0 "Number of embedded systems in the building";
      parameter Boolean useFluPor = true "Set to false to remove fluid ports";

      //Zones:
      //       1  -> C0.15 (claas)
      //       2  -> C0.13 (class)
      //       3  -> C0.14 (entrance)
      //       4  -> C0.12 (restroom)
      //       5  -> C0.11 (corridor)
      // Records --------------------------------------------------------------------------------------------------------------------------------------------------------------
      Records.BuildingZones BuildingZones
        annotation (Placement(transformation(extent={{120,520},{200,600}})));
      Records.BuildingEnvelope BuildingEnvelope
        annotation (Placement(transformation(extent={{220,520},{300,600}})));

      // Interfaces -----------------------------------------------------------------------------------------------------------------------------------------------------------
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortCon
        "Internal zone nodes for convective heat gains" annotation (Placement(
            transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={340,240}),                          iconTransformation(extent={{-10,-10},
                {10,10}},
            rotation=90,
            origin={200,20})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortRad
        "Internal zones node for radiative heat gains" annotation (Placement(
            transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={340,220}),                            iconTransformation(extent={{-10,-10},
                {10,10}},
            rotation=90,
            origin={200,-20})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[nZones] heatPortEmb
        "Construction nodes for heat gains by embedded layers" annotation (
          Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={340,200}),                                  iconTransformation(
              extent={{-10,-10},{10,10}},
            rotation=90,
            origin={200,58})));
      Modelica.Fluid.Interfaces.FluidPort_b[nZones] Vent_exh(redeclare package
          Medium =                                                                      MediumAir)
                                                                                                 if useFluPor
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={340,300}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-20,100})));
      Modelica.Fluid.Interfaces.FluidPort_a[nZones] Vent_sup(redeclare package
          Medium =                                                                      MediumAir)
                                                                                                 if useFluPor
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={340,280}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={22,100})));
      Modelica.Blocks.Interfaces.RealOutput[nZones] T_oper_zone(
        final quantity="ThermodynamicTemperature",
        displayUnit="degC",
        min=0,
        unit="degC")
        "Sensor temperature of the zones"
        annotation (Placement(transformation(extent={{336,150},{356,170}}),
            iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={200,-60})));
      Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin[nZones]
        annotation (Placement(transformation(extent={{280,150},{300,170}})));

      Modelica.Blocks.Interfaces.RealOutput[nZones] C_CO2_zone(min=0)
        "CO2 concentration in the zone - unit=ppm"
        annotation (Placement(transformation(extent={{336,130},{356,150}}),
            iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={200,-80})));

      //extends IDEAS.Templates.Interfaces.BaseClasses.Structure(nZones=10, nEmb=0);
      // Zones ----------------------------------------------------------------------------------------------------------------------------------------------------------------
      IDEAS.Buildings.Components.Zone Z1(
        redeclare package Medium = MediumAir,
        nSurf=12,
        nPorts=2,
        redeclare IDEAS.Buildings.Components.InterzonalAirFlow.n50Tight
          interzonalAirFlow,
        energyDynamicsAir=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
        V=BuildingZones.Z1_Volume,
        hZone=BuildingZones.Z1_hZone,
        A=BuildingZones.Z1_FloorArea,
        n50=BuildingZones.X_n50,
        n50toAch=BuildingZones.X_n50toAch) "Zone 1 - C0.15"
        annotation (Placement(transformation(extent={{-210,-50},{-190,-30}})));

      IDEAS.Buildings.Components.Zone Z3(
        redeclare package Medium = MediumAir,
        nSurf=8,
        nPorts=2,
        redeclare IDEAS.Buildings.Components.InterzonalAirFlow.n50Tight
          interzonalAirFlow,
        energyDynamicsAir=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
        V=BuildingZones.Z3_Volume,
        hZone=BuildingZones.Z3_hZone,
        A=BuildingZones.Z3_FloorArea,
        n50=BuildingZones.X_n50,
        n50toAch=BuildingZones.X_n50toAch) "Zone 3 - C0.14"
        annotation (Placement(transformation(extent={{-36,-30},{-16,-10}})));

      IDEAS.Buildings.Components.Zone Z2(
        redeclare package Medium = MediumAir,
        nSurf=11,
        nPorts=2,
        redeclare IDEAS.Buildings.Components.InterzonalAirFlow.n50Tight
          interzonalAirFlow,
        energyDynamicsAir=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
        V=BuildingZones.Z2_Volume,
        hZone=BuildingZones.Z2_hZone,
        A=BuildingZones.Z2_FloorArea,
        n50=BuildingZones.X_n50,
        n50toAch=BuildingZones.X_n50toAch) "Zone 2 - C0.13"
        annotation (Placement(transformation(extent={{130,-50},{150,-30}})));

      // Outer walls ----------------------------------------------------------------------------------------------------------------------------------------------------------
      IDEAS.Buildings.Components.OuterWall Z1_wall_F(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.Z1_wall_F,
        redeclare .Skole.Envelope.Data.Construction_elements.X_ExtWall_Brick
          constructionType) annotation (Placement(transformation(
            extent={{5.00002,7.99994},{-5.00003,-8.00008}},
            rotation=270,
            origin={-250,-111})));

      // Outer door -----------------------------------------------------------------------------------------------------------------------------------------------------------
      // Windows --------------------------------------------------------------------------------------------------------------------------------------------------------------
      IDEAS.Buildings.Components.Window W1_F(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.W1_F,
        nWin=8,
        frac=BuildingEnvelope.W_frac,
        redeclare .Skole.Envelope.Data.Construction_elements.X_DoubleGlazingAir
          glazing,
        redeclare .Skole.Envelope.Data.Construction_elements.X_WindowFrameTimber
          fraType) annotation (Placement(transformation(
            extent={{-5,-8.00015},{5,8.00022}},
            rotation=90,
            origin={-210,-111})));

      // Inner walls ----------------------------------------------------------------------------------------------------------------------------------------------------------
      IDEAS.Buildings.Components.InternalWall W_Z1Z4(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.W_Z1Z4,
        redeclare .Skole.Envelope.Data.Construction_elements.X_IntWall_Thick
          constructionType) annotation (Placement(transformation(
            extent={{-6,-8},{6,8}},
            rotation=90,
            origin={-210,30})));

      // Interior doors -------------------------------------------------------------------------------------------------------------------------------------------------------
      // Boundary conditions --------------------------------------------------------------------------------------------------------------------------------------------------
      IDEAS.Buildings.Components.InternalWall I1_Z1Z5(
        redeclare .Skole.Envelope.Data.Construction_elements.X_IntDoor_Timber
          constructionType,
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.I1_Z1Z5) annotation (Placement(transformation(
            extent={{-6,-8},{6,8}},
            rotation=-90,
            origin={-130,30})));
      IDEAS.Buildings.Components.BoundaryWall Z2_FloorG(
        redeclare Data.Construction_elements.X_Groundfloor constructionType,
        incOpt=2,
        A=BuildingEnvelope.Z2_FloorG,
        use_T_in=true) annotation (Placement(transformation(
            extent={{-6,-10},{6,10}},
            rotation=90,
            origin={140,-380})));
      IDEAS.Buildings.Components.BoundaryWall Z3_FloorG(
        redeclare .Skole.Envelope.Data.Construction_elements.X_Groundfloor
          constructionType,
        incOpt=2,
        A=BuildingEnvelope.Z3_FloorG,
        use_T_in=true) annotation (Placement(transformation(
            extent={{-6,-10},{6,10}},
            rotation=90,
            origin={-20,-360})));
      IDEAS.Buildings.Components.BoundaryWall Z1_FloorG(
        redeclare .Skole.Envelope.Data.Construction_elements.X_Groundfloor
          constructionType,
        incOpt=2,
        A=BuildingEnvelope.Z1_FloorG,
        use_T_in=true) annotation (Placement(transformation(
            extent={{-6,-10},{6,10}},
            rotation=90,
            origin={-200,-380})));

      IDEAS.Buildings.Components.BoundaryWall Z4_FloorG(
        redeclare .Skole.Envelope.Data.Construction_elements.X_Groundfloor
          constructionType,
        incOpt=2,
        A=BuildingEnvelope.Z4_FloorG,
        use_T_in=true) annotation (Placement(transformation(
            extent={{-6,-10},{6,10}},
            rotation=90,
            origin={-220,-280})));
      IDEAS.Buildings.Components.BoundaryWall Z5_FloorG(
        redeclare .Skole.Envelope.Data.Construction_elements.X_Groundfloor
          constructionType,
        incOpt=2,
        A=BuildingEnvelope.Z5_FloorG,
        use_T_in=true) annotation (Placement(transformation(
            extent={{-6,-10},{6,10}},
            rotation=90,
            origin={40,-280})));
      IDEAS.Buildings.Components.BoundaryWall Z4_Ceiling(
        redeclare .Skole.Envelope.Data.Construction_elements.X_Firstfloor
          constructionType,
        incOpt=3,
        A=BuildingEnvelope.Z4_FloorG,
        use_T_in=true) annotation (Placement(transformation(
            extent={{6,-10},{-6,10}},
            rotation=90,
            origin={-220,400})));
      IDEAS.Buildings.Components.BoundaryWall Z1_Ceiling(
        redeclare .Skole.Envelope.Data.Construction_elements.X_Firstfloor
          constructionType,
        incOpt=3,
        A=BuildingEnvelope.Z1_FloorG,
        use_T_in=true) annotation (Placement(transformation(
            extent={{6,-10},{-6,10}},
            rotation=90,
            origin={-200,300})));
      IDEAS.Buildings.Components.BoundaryWall Z3_Ceiling(
        redeclare .Skole.Envelope.Data.Construction_elements.X_Firstfloor
          constructionType,
        incOpt=3,
        A=BuildingEnvelope.Z3_FloorG,
        use_T_in=true) annotation (Placement(transformation(
            extent={{6,-10},{-6,10}},
            rotation=90,
            origin={-30,320})));
      IDEAS.Buildings.Components.BoundaryWall Z5_Ceiling(
        redeclare .Skole.Envelope.Data.Construction_elements.X_Firstfloor
          constructionType,
        incOpt=3,
        A=BuildingEnvelope.Z5_FloorG,
        use_T_in=true) annotation (Placement(transformation(
            extent={{6,-10},{-6,10}},
            rotation=90,
            origin={40,400})));
      IDEAS.Buildings.Components.BoundaryWall Z2_Ceiling(
        redeclare .Skole.Envelope.Data.Construction_elements.X_Firstfloor
          constructionType,
        incOpt=3,
        A=BuildingEnvelope.Z2_FloorG,
        use_T_in=true) annotation (Placement(transformation(
            extent={{6,-10},{-6,10}},
            rotation=90,
            origin={140,300})));
      IDEAS.Buildings.Components.Zone Z4(
        redeclare package Medium = MediumAir,
        nSurf=9,
        nPorts=2,
        redeclare IDEAS.Buildings.Components.InterzonalAirFlow.n50Tight
          interzonalAirFlow,
        energyDynamicsAir=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
        V=BuildingZones.Z4_Volume,
        hZone=BuildingZones.Z4_hZone,
        A=BuildingZones.Z4_FloorArea,
        n50=BuildingZones.X_n50,
        n50toAch=BuildingZones.X_n50toAch) "Zone 4 - C0.12"
        annotation (Placement(transformation(extent={{-230,50},{-210,70}})));
      IDEAS.Buildings.Components.Zone Z5(
        redeclare package Medium = MediumAir,
        nSurf=16,
        nPorts=2,
        redeclare IDEAS.Buildings.Components.InterzonalAirFlow.n50Tight
          interzonalAirFlow,
        energyDynamicsAir=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
        V=BuildingZones.Z5_Volume,
        hZone=BuildingZones.Z5_hZone,
        A=BuildingZones.Z5_FloorArea,
        n50=BuildingZones.X_n50,
        n50toAch=BuildingZones.X_n50toAch) "Zone 5 - C0.11"
        annotation (Placement(transformation(extent={{30,50},{50,70}})));
      IDEAS.Buildings.Components.Window W3_F(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.W3_F,
        nWin=8,
        frac=BuildingEnvelope.W_frac,
        redeclare IDEAS.Buildings.Data.Glazing.Ins2Ar2020 glazing,
        redeclare .Skole.Envelope.Data.Construction_elements.X_WindowFrameTimber
          fraType) annotation (Placement(transformation(
            extent={{-4.99999,-8},{5,7.99995}},
            rotation=90,
            origin={-170,-111})));
      IDEAS.Buildings.Components.Window W2_F(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.W2_F,
        nWin=8,
        frac=BuildingEnvelope.W_frac,
        redeclare .Skole.Envelope.Data.Construction_elements.X_DoubleGlazingAir
          glazing,
        redeclare .Skole.Envelope.Data.Construction_elements.X_WindowFrameTimber
          fraType) annotation (Placement(transformation(
            extent={{-4.99995,-7.99993},{4.99995,7.99991}},
            rotation=90,
            origin={-190,-111})));
      IDEAS.Buildings.Components.OuterWall Z1_wall_L(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_L,
        A=BuildingEnvelope.Z1_wall_L,
        redeclare .Skole.Envelope.Data.Construction_elements.X_ExtWall_Brick
          constructionType) annotation (Placement(transformation(
            extent={{5.00002,7.99995},{-5.00001,-8.00005}},
            rotation=180,
            origin={-291,-50})));
      IDEAS.Buildings.Components.OuterWall Z1_wall_R(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_R,
        A=BuildingEnvelope.Z1_wall_R,
        redeclare .Skole.Envelope.Data.Construction_elements.X_ExtWall_Brick
          constructionType) annotation (Placement(transformation(
            extent={{-5.00002,7.99995},{5.00001,-8.00005}},
            rotation=180,
            origin={-89,-90})));
      IDEAS.Buildings.Components.OuterWall Z4_wall_L(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_L,
        A=BuildingEnvelope.Z4_wall_L,
        redeclare .Skole.Envelope.Data.Construction_elements.X_ExtWall_Brick
          constructionType) annotation (Placement(transformation(
            extent={{5.00002,7.99995},{-5.00001,-8.00005}},
            rotation=180,
            origin={-291,50})));
      IDEAS.Buildings.Components.OuterWall Z1_wall_F1(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.Z1_wall_F,
        redeclare .Skole.Envelope.Data.Construction_elements.X_ExtWall_Brick
          constructionType) annotation (Placement(transformation(
            extent={{5.00002,-7.99994},{-5.00003,8.00008}},
            rotation=270,
            origin={190,-111})));
      IDEAS.Buildings.Components.Window W4_F(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.W4_F,
        nWin=8,
        frac=BuildingEnvelope.W_frac,
        redeclare .Skole.Envelope.Data.Construction_elements.X_DoubleGlazingAir
          glazing,
        redeclare .Skole.Envelope.Data.Construction_elements.X_WindowFrameTimber
          fraType) annotation (Placement(transformation(
            extent={{-5,8.00015},{5,-8.00022}},
            rotation=90,
            origin={110,-111})));
      IDEAS.Buildings.Components.Window W5_F(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.W5_F,
        nWin=8,
        frac=BuildingEnvelope.W_frac,
        redeclare .Skole.Envelope.Data.Construction_elements.X_DoubleGlazingAir
          glazing,
        redeclare .Skole.Envelope.Data.Construction_elements.X_WindowFrameTimber
          fraType) annotation (Placement(transformation(
            extent={{-4.99995,7.99993},{4.99995,-7.99991}},
            rotation=90,
            origin={130,-111})));
      IDEAS.Buildings.Components.Window W6_F(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.W6_F,
        nWin=8,
        frac=BuildingEnvelope.W_frac,
        redeclare .Skole.Envelope.Data.Construction_elements.X_DoubleGlazingAir
          glazing,
        redeclare .Skole.Envelope.Data.Construction_elements.X_WindowFrameTimber
          fraType) annotation (Placement(transformation(
            extent={{-4.99999,8},{5,-7.99995}},
            rotation=90,
            origin={150,-111})));
      IDEAS.Buildings.Components.OuterWall Z2_wall_L(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_L,
        A=BuildingEnvelope.Z2_wall_L,
        redeclare .Skole.Envelope.Data.Construction_elements.X_ExtWall_Brick
          constructionType) annotation (Placement(transformation(
            extent={{5.00002,7.99995},{-5.00001,-8.00005}},
            rotation=180,
            origin={29,-90})));
      IDEAS.Buildings.Components.Window W7_L(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_L,
        A=BuildingEnvelope.W7_L,
        nWin=8,
        frac=BuildingEnvelope.W_frac,
        redeclare .Skole.Envelope.Data.Construction_elements.X_DoubleGlazingAir
          glazing,
        redeclare .Skole.Envelope.Data.Construction_elements.X_WindowFrameTimber
          fraType) annotation (Placement(transformation(
            extent={{-5,-8},{5,8.00007}},
            rotation=0,
            origin={-291,70})));
      IDEAS.Buildings.Components.Window W8_B(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_B,
        A=BuildingEnvelope.W8_B,
        nWin=8,
        frac=BuildingEnvelope.W_frac,
        redeclare .Skole.Envelope.Data.Construction_elements.X_DoubleGlazingAir
          glazing,
        redeclare .Skole.Envelope.Data.Construction_elements.X_WindowFrameTimber
          fraType) annotation (Placement(transformation(
            extent={{5,-8.00015},{-5,8.00022}},
            rotation=90,
            origin={-230,91})));
      IDEAS.Buildings.Components.Window W12_B(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_B,
        A=BuildingEnvelope.W12_B,
        nWin=8,
        frac=BuildingEnvelope.W_frac,
        redeclare .Skole.Envelope.Data.Construction_elements.X_DoubleGlazingAir
          glazing,
        redeclare .Skole.Envelope.Data.Construction_elements.X_WindowFrameTimber
          fraType) annotation (Placement(transformation(
            extent={{4.99999,-8},{-5,7.99995}},
            rotation=90,
            origin={50,91})));
      IDEAS.Buildings.Components.Window W11_B(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_B,
        A=BuildingEnvelope.W11_B,
        nWin=8,
        frac=BuildingEnvelope.W_frac,
        redeclare .Skole.Envelope.Data.Construction_elements.X_DoubleGlazingAir
          glazing,
        redeclare .Skole.Envelope.Data.Construction_elements.X_WindowFrameTimber
          fraType) annotation (Placement(transformation(
            extent={{4.99995,-7.99993},{-4.99995,7.99991}},
            rotation=90,
            origin={30,91})));
      IDEAS.Buildings.Components.Window W10_B(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_B,
        A=BuildingEnvelope.W10_B,
        nWin=8,
        frac=BuildingEnvelope.W_frac,
        redeclare .Skole.Envelope.Data.Construction_elements.X_DoubleGlazingAir
          glazing,
        redeclare .Skole.Envelope.Data.Construction_elements.X_WindowFrameTimber
          fraType) annotation (Placement(transformation(
            extent={{5,-8.00015},{-5,8.00022}},
            rotation=90,
            origin={10,91})));
      IDEAS.Buildings.Components.Window W9_B(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_B,
        A=BuildingEnvelope.W9_B,
        nWin=8,
        frac=BuildingEnvelope.W_frac,
        redeclare .Skole.Envelope.Data.Construction_elements.X_DoubleGlazingAir
          glazing,
        redeclare .Skole.Envelope.Data.Construction_elements.X_WindowFrameTimber
          fraType) annotation (Placement(transformation(
            extent={{5,-8.00015},{-5,8.00022}},
            rotation=90,
            origin={-10,91})));
      IDEAS.Buildings.Components.OuterWall Z5_wall_B(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_B,
        A=BuildingEnvelope.Z5_wall_B,
        redeclare .Skole.Envelope.Data.Construction_elements.X_ExtWall_Brick
          constructionType) annotation (Placement(transformation(
            extent={{-5.00002,7.99994},{5.00003,-8.00008}},
            rotation=270,
            origin={-50,91})));
      IDEAS.Buildings.Components.OuterWall Z4_wall_B(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_B,
        A=BuildingEnvelope.Z4_wall_B,
        redeclare .Skole.Envelope.Data.Construction_elements.X_ExtWall_Brick
          constructionType) annotation (Placement(transformation(
            extent={{-5.00002,7.99994},{5.00003,-8.00008}},
            rotation=270,
            origin={-210,91})));
      IDEAS.Buildings.Components.OuterWall Z3_wall_F(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.Z3_wall_F,
        redeclare .Skole.Envelope.Data.Construction_elements.X_ExtWall_Brick
          constructionType) annotation (Placement(transformation(
            extent={{5.00002,7.99994},{-5.00003,-8.00008}},
            rotation=270,
            origin={-50,-73})));
      IDEAS.Buildings.Components.OuterWall Z3_door_F(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.Z3_door_F,
        redeclare .Skole.Envelope.Data.Construction_elements.X_ExtDoor_Timber
          constructionType) annotation (Placement(transformation(
            extent={{5.00002,7.99994},{-5.00003,-8.00008}},
            rotation=270,
            origin={-30,-73})));
      IDEAS.Buildings.Components.InternalWall W_Z1Z5(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.W_Z1Z5,
        redeclare .Skole.Envelope.Data.Construction_elements.X_IntWall_Thick
          constructionType) annotation (Placement(transformation(
            extent={{-6,-8},{6,8}},
            rotation=90,
            origin={-110,30})));
      IDEAS.Buildings.Components.InternalWall W_Z3Z5(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.W_Z3Z5,
        redeclare .Skole.Envelope.Data.Construction_elements.X_IntWall_Thick
          constructionType) annotation (Placement(transformation(
            extent={{-6,-8},{6,8}},
            rotation=90,
            origin={-30,30})));
      IDEAS.Buildings.Components.InternalWall I2_Z3Z5(
        redeclare .Skole.Envelope.Data.Construction_elements.X_IntDoor_Timber
          constructionType,
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.I2_Z3Z5) annotation (Placement(transformation(
            extent={{-6,-8},{6,8}},
            rotation=-90,
            origin={-50,30})));
      IDEAS.Buildings.Components.InternalWall W_Z2Z5(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.W_Z2Z5,
        redeclare .Skole.Envelope.Data.Construction_elements.X_IntWall_Thick
          constructionType) annotation (Placement(transformation(
            extent={{-6,-8},{6,8}},
            rotation=90,
            origin={70,30})));
      IDEAS.Buildings.Components.InternalWall I3_Z2Z5(
        redeclare .Skole.Envelope.Data.Construction_elements.X_IntDoor_Timber
          constructionType,
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_F,
        A=BuildingEnvelope.I3_Z2Z5) annotation (Placement(transformation(
            extent={{-6,-8},{6,8}},
            rotation=-90,
            origin={50,30})));
      IDEAS.Buildings.Components.InternalWall I4_Z4Z5(
        redeclare .Skole.Envelope.Data.Construction_elements.X_IntDoor_Timber
          constructionType,
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_L,
        A=BuildingEnvelope.I4_Z4Z5) annotation (Placement(transformation(
            extent={{-6,-8},{6,8}},
            rotation=180,
            origin={-150,70})));
      IDEAS.Buildings.Components.InternalWall W_Z4Z5(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_L,
        A=BuildingEnvelope.W_Z4Z5,
        redeclare .Skole.Envelope.Data.Construction_elements.X_IntWall_Thick
          constructionType) annotation (Placement(transformation(
            extent={{-6,-8},{6,8}},
            rotation=0,
            origin={-150,50})));
      IDEAS.Buildings.Components.InternalWall W_Z1Z3(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_L,
        A=BuildingEnvelope.W_Z1Z3,
        redeclare .Skole.Envelope.Data.Construction_elements.X_IntWall_Thick
          constructionType) annotation (Placement(transformation(
            extent={{-6,-8},{6,8}},
            rotation=0,
            origin={-90,-30})));
      IDEAS.Buildings.Components.InternalWall W_Z2Z3(
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_L,
        A=BuildingEnvelope.W_Z2Z3,
        redeclare .Skole.Envelope.Data.Construction_elements.X_IntWall_Thick
          constructionType) annotation (Placement(transformation(
            extent={{-6,-8},{6,8}},
            rotation=0,
            origin={30,-30})));
      IDEAS.Buildings.Components.BoundaryWall Z2_AdWall(
        redeclare .Skole.Envelope.Data.Construction_elements.X_IntWall_Thick
          constructionType,
        incOpt=4,
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_L,
        A=BuildingEnvelope.Z2_AdWall,
        use_T_in=true) annotation (Placement(transformation(
            extent={{-6,-10},{6,10}},
            rotation=180,
            origin={230,-30})));
      IDEAS.Buildings.Components.BoundaryWall Z5_AdWall(
        redeclare .Skole.Envelope.Data.Construction_elements.X_IntWall_Thick
          constructionType,
        inc=IDEAS.Types.Tilt.Wall,
        azi=BuildingEnvelope.azi_L,
        A=BuildingEnvelope.Z5_AdWall,
        use_T_in=true) annotation (Placement(transformation(
            extent={{-6,-10},{6,10}},
            rotation=180,
            origin={230,70})));

      Modelica.Blocks.Sources.RealExpression realExpression(y=11.0)
        annotation (Placement(transformation(extent={{350,-330},{330,-310}})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
        annotation (Placement(transformation(extent={{300,-330},{280,-310}})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
        annotation (Placement(transformation(extent={{300,-40},{280,-20}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=17.0)
        annotation (Placement(transformation(extent={{350,-40},{330,-20}})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin2
        annotation (Placement(transformation(extent={{300,350},{280,370}})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=15.0)
        annotation (Placement(transformation(extent={{350,350},{330,370}})));
      inner IDEAS.BoundaryConditions.SimInfoManager sim
        annotation (Placement(transformation(extent={{120,620},{200,700}})));
    equation

      connect(fromKelvin.Celsius, T_oper_zone) annotation (Line(points={{301,160},{346,
              160}},                                                                        color={0,0,127}));
      connect(realExpression.y, toKelvin.Celsius) annotation (Line(points={{329,-320},{302,-320}}, color={0,0,127}));
      connect(toKelvin.Kelvin, Z1_FloorG.T) annotation (Line(points={{279,-320},{-180,
              -320},{-180,-396},{-202,-396},{-202,-391}}, color={0,0,127}));
      connect(toKelvin.Kelvin, Z2_FloorG.T) annotation (Line(points={{279,-320},{120,
              -320},{120,-396},{138,-396},{138,-391}}, color={0,0,127}));
      connect(toKelvin.Kelvin, Z3_FloorG.T) annotation (Line(points={{279,-320},{0,-320},
              {0,-376},{-22,-376},{-22,-371}}, color={0,0,127}));
      connect(toKelvin.Kelvin, Z4_FloorG.T) annotation (Line(points={{279,-320},{-222,
              -320},{-222,-291}}, color={0,0,127}));
      connect(toKelvin.Kelvin, Z5_FloorG.T) annotation (Line(points={{279,-320},{38,
              -320},{38,-291}}, color={0,0,127}));
      connect(realExpression1.y, toKelvin1.Celsius) annotation (Line(points={{329,-30},{302,-30}}, color={0,0,127}));

      connect(toKelvin1.Kelvin, Z2_AdWall.T) annotation (Line(points={{279,-30},{246,
              -30},{246,-32},{241,-32}}, color={0,0,127}));
      connect(toKelvin1.Kelvin, Z5_AdWall.T) annotation (Line(points={{279,-30},{246,
              -30},{246,68},{241,68}}, color={0,0,127}));
      connect(realExpression2.y, toKelvin2.Celsius) annotation (Line(points={{329,360},{302,360}}, color={0,0,127}));

      connect(toKelvin2.Kelvin, Z1_Ceiling.T) annotation (Line(points={{279,360},{-202,
              360},{-202,311}}, color={0,0,127}));
      connect(toKelvin2.Kelvin, Z2_Ceiling.T) annotation (Line(points={{279,360},{138,360},{138,311}}, color={0,0,127}));
      connect(toKelvin2.Kelvin, Z3_Ceiling.T) annotation (Line(points={{279,360},{-32,360},{-32,331}}, color={0,0,127}));
      connect(toKelvin2.Kelvin, Z4_Ceiling.T) annotation (Line(points={{279,360},{-200,
              360},{-200,416},{-222,416},{-222,411}}, color={0,0,127}));
      connect(toKelvin2.Kelvin, Z5_Ceiling.T) annotation (Line(points={{279,360},{20,
              360},{20,416},{38,416},{38,411}}, color={0,0,127}));

      connect(heatPortRad[1], Z1.gainRad) annotation (Line(points={{340,216},{340,220},
              {258,220},{258,-62},{-184,-62},{-184,-46},{-190,-46}},
                                               color={191,0,0}));
      connect(heatPortRad[2], Z2.gainRad) annotation (Line(points={{340,218},{340,220},
              {258,220},{258,-62},{154,-62},{154,-46},{150,-46}},
                                               color={191,0,0}));
      connect(heatPortRad[3], Z3.gainRad) annotation (Line(points={{340,220},{340,220},
              {258,220},{258,-62},{-8,-62},{-8,-26},{-16,-26}},
                                               color={191,0,0}));
      connect(heatPortRad[4], Z4.gainRad) annotation (Line(points={{340,222},{340,220},
              {258,220},{258,-62},{-184,-62},{-184,54},{-210,54}},
                                               color={191,0,0}));
      connect(heatPortRad[5], Z5.gainRad) annotation (Line(points={{340,224},{340,220},
              {258,220},{258,-62},{86,-62},{86,54},{50,54}},
                                               color={191,0,0}));

      connect(heatPortCon[1], Z1.gainCon) annotation (Line(points={{340,236},{340,240},
              {258,240},{258,-62},{-184,-62},{-184,-43},{-190,-43}},
                                               color={191,0,0}));
      connect(heatPortCon[2], Z2.gainCon) annotation (Line(points={{340,238},{340,240},
              {258,240},{258,-62},{154,-62},{154,-43},{150,-43}},
                                               color={191,0,0}));
      connect(heatPortCon[3], Z3.gainCon) annotation (Line(points={{340,240},{340,240},
              {258,240},{258,-62},{-8,-62},{-8,-23},{-16,-23}},
                                               color={191,0,0}));
      connect(heatPortCon[4], Z4.gainCon) annotation (Line(points={{340,242},{340,240},
              {258,240},{258,-62},{-184,-62},{-184,57},{-210,57}},
                                               color={191,0,0}));
      connect(heatPortCon[5], Z5.gainCon) annotation (Line(points={{340,244},{340,240},
              {258,240},{258,-62},{86,-62},{86,57},{50,57}},
                                               color={191,0,0}));

      connect(C_CO2_zone[1], Z1.ppm) annotation (Line(points={{346,136},{346,140},{256,
              140},{256,-60},{-182,-60},{-182,-40},{-189,-40}},
                                      color={0,0,127}));
      connect(C_CO2_zone[2], Z2.ppm) annotation (Line(points={{346,138},{346,140},{256,
              140},{256,-60},{156,-60},{156,-40},{151,-40}},
                                      color={0,0,127}));
      connect(C_CO2_zone[3], Z3.ppm) annotation (Line(points={{346,140},{346,140},{256,
              140},{256,-60},{-6,-60},{-6,-20},{-15,-20}},
                                      color={0,0,127}));
      connect(C_CO2_zone[4], Z4.ppm) annotation (Line(points={{346,142},{346,140},{256,
              140},{256,-60},{-182,-60},{-182,60},{-209,60}},
                                      color={0,0,127}));
      connect(C_CO2_zone[5], Z5.ppm) annotation (Line(points={{346,144},{346,140},{256,
              140},{256,-60},{88,-60},{88,60},{51,60}},
                                      color={0,0,127}));

      connect(fromKelvin[1].Kelvin, Z1.TSensor) annotation (Line(points={{278,160},{
              256,160},{256,-60},{-182,-60},{-182,-38},{-189,-38}}, color={0,0,127}));
      connect(fromKelvin[2].Kelvin, Z2.TSensor) annotation (Line(points={{278,160},{
              256,160},{256,-60},{156,-60},{156,-38},{151,-38}},    color={0,0,127}));
      connect(fromKelvin[3].Kelvin, Z3.TSensor) annotation (Line(points={{278,160},{
              256,160},{256,-60},{-6,-60},{-6,-18},{-15,-18}},      color={0,0,127}));
      connect(fromKelvin[4].Kelvin, Z4.TSensor) annotation (Line(points={{278,160},{
              256,160},{256,-60},{-182,-60},{-182,62},{-209,62}},   color={0,0,127}));
      connect(fromKelvin[5].Kelvin, Z5.TSensor) annotation (Line(points={{278,160},{
              256,160},{256,-60},{88,-60},{88,62},{51,62}},         color={0,0,127}));

      connect(Vent_exh[1], Z1.ports[1]) annotation (Line(points={{340,296},{340,300},
              {254,300},{254,-58},{-180,-58},{-180,-28},{-200,-28},{-200,-30},{-201,
              -30}},                                                color={0,127,255}));
      connect(Vent_exh[2], Z2.ports[1]) annotation (Line(points={{340,298},{340,300},
              {254,300},{254,-58},{158,-58},{158,-30},{139,-30}},   color={0,127,255}));
      connect(Vent_exh[3], Z3.ports[1]) annotation (Line(points={{340,300},{340,300},
              {254,300},{254,-58},{-4,-58},{-4,-10},{-27,-10}},     color={0,127,255}));
      connect(Vent_exh[4], Z4.ports[1]) annotation (Line(points={{340,302},{340,300},
              {254,300},{254,-58},{-180,-58},{-180,72},{-220,72},{-220,70},{-221,70}},
                                                                    color={0,127,255}));
      connect(Vent_exh[5], Z5.ports[1]) annotation (Line(points={{340,304},{340,300},
              {254,300},{254,-58},{90,-58},{90,72},{40,72},{40,70},{39,70}},
                                                                    color={0,127,255}));

      connect(Vent_sup[1], Z1.ports[2]) annotation (Line(points={{340,276},{340,280},
              {254,280},{254,-58},{-180,-58},{-180,-28},{-200,-28},{-200,-30},{-199,
              -30}},                                       color={0,127,255}));
      connect(Vent_sup[2], Z2.ports[2]) annotation (Line(points={{340,278},{340,280},
              {254,280},{254,-58},{158,-58},{158,-30},{141,-30}},
                                                           color={0,127,255}));
      connect(Vent_sup[3], Z3.ports[2]) annotation (Line(points={{340,280},{340,280},
              {254,280},{254,-58},{-4,-58},{-4,-10},{-25,-10}},
                                                           color={0,127,255}));
      connect(Vent_sup[4], Z4.ports[2]) annotation (Line(points={{340,282},{340,280},
              {254,280},{254,-58},{-180,-58},{-180,72},{-220,72},{-220,70},{-219,70}},
                                                           color={0,127,255}));
      connect(Vent_sup[5], Z5.ports[2]) annotation (Line(points={{340,284},{340,280},
              {254,280},{254,-58},{90,-58},{90,72},{40,72},{40,70},{41,70}},
                                                           color={0,127,255}));


      connect(Z1.propsBus[1], Z1_FloorG.propsBus_a) annotation (Line(
          points={{-210,-36.9167},{-210,-40},{-214,-40},{-214,-54},{-70,-54},{
              -70,-340},{-202,-340},{-202,-375}},
          color={255,204,51},
          pattern=LinePattern.Dash));
      connect(Z1.propsBus[2], Z1_wall_L.propsBus_a) annotation (Line(
          points={{-210,-36.75},{-210,-40},{-282,-40},{-282,-48.3999},{-286.833,
              -48.3999}},
          color={255,204,51},
          thickness=0.5));

      connect(Z1.propsBus[3], Z1_wall_F.propsBus_a) annotation (Line(
          points={{-210,-36.5833},{-210,-40},{-282,-40},{-282,-102},{-251.6,
              -102},{-251.6,-106.833}},
          color={255,204,51},
          thickness=0.5));
      connect(Z1.propsBus[4], W1_F.propsBus_a) annotation (Line(
          points={{-210,-36.4167},{-210,-40},{-282,-40},{-282,-102},{-211.6,
              -102},{-211.6,-106.833}},
          color={255,204,51},
          thickness=0.5));
      connect(Z1.propsBus[5], W2_F.propsBus_a) annotation (Line(
          points={{-210,-36.25},{-210,-40},{-282,-40},{-282,-102},{-191.6,-102},
              {-191.6,-106.833}},
          color={255,204,51},
          thickness=0.5));
      connect(Z1.propsBus[6], W3_F.propsBus_a) annotation (Line(
          points={{-210,-36.0833},{-210,-40},{-282,-40},{-282,-102},{-171.6,
              -102},{-171.6,-106.833}},
          color={255,204,51},
          thickness=0.5));
      connect(Z1.propsBus[7], Z1_wall_R.propsBus_a) annotation (Line(
          points={{-210,-35.9167},{-210,-40},{-282,-40},{-282,-102},{-98,-102},
              {-98,-88.4},{-93.1667,-88.4}},
          color={255,204,51},
          thickness=0.5));
      connect(Z1.propsBus[8], W_Z1Z3.propsBus_b) annotation (Line(
          points={{-210,-35.75},{-210,-40},{-282,-40},{-282,-102},{-98,-102},{-98,-28.4},
              {-95,-28.4}},
          color={255,204,51},
          thickness=0.5));
      connect(Z1.propsBus[9], W_Z1Z5.propsBus_b) annotation (Line(
          points={{-210,-35.5833},{-210,-40},{-282,-40},{-282,-102},{-98,-102},
              {-98,22},{-111.6,22},{-111.6,25}},
          color={255,204,51},
          thickness=0.5));
      connect(Z1.propsBus[10], I1_Z1Z5.propsBus_a) annotation (Line(
          points={{-210,-35.4167},{-210,-40},{-282,-40},{-282,-102},{-98,-102},
              {-98,22},{-128.4,22},{-128.4,25}},
          color={255,204,51},
          thickness=0.5));
      connect(Z1.propsBus[11], W_Z1Z4.propsBus_b) annotation (Line(
          points={{-210,-35.25},{-210,-40},{-282,-40},{-282,22},{-211.6,22},{-211.6,
              25}},
          color={255,204,51},
          thickness=0.5));
      connect(Z1.propsBus[12], Z1_Ceiling.propsBus_a) annotation (Line(
          points={{-210,-35.0833},{-210,-40},{-214,-40},{-214,-54},{-70,-54},{
              -70,340},{-180,340},{-180,290},{-202,290},{-202,295}},
          color={255,204,51},
          pattern=LinePattern.Dash));
      connect(Z4.propsBus[1], Z4_FloorG.propsBus_a) annotation (Line(
          points={{-230,63.1111},{-230,60},{-234,60},{-234,40},{-70,40},{-70,
              -264},{-222,-264},{-222,-275}},
          color={255,204,51},
          pattern=LinePattern.Dash));
      connect(Z4.propsBus[2], Z4_wall_B.propsBus_a) annotation (Line(
          points={{-230,63.3333},{-230,60},{-282,60},{-282,82},{-211.6,82},{
              -211.6,86.8333}},
          color={255,204,51},
          thickness=0.5));

      connect(Z4.propsBus[3], W8_B.propsBus_a) annotation (Line(
          points={{-230,63.5556},{-230,60},{-282,60},{-282,82},{-231.6,82},{
              -231.6,86.8333}},
          color={255,204,51},
          thickness=0.5));

      connect(Z4.propsBus[4], W7_L.propsBus_a) annotation (Line(
          points={{-230,63.7778},{-230,60},{-282,60},{-282,72},{-286,72},{-286,
              71.6},{-286.833,71.6}},
          color={255,204,51},
          thickness=0.5));
      connect(Z4.propsBus[5], Z4_wall_L.propsBus_a) annotation (Line(
          points={{-230,64},{-230,60},{-282,60},{-282,51.6001},{-286.833,
              51.6001}},
          color={255,204,51},
          thickness=0.5));

      connect(Z4.propsBus[6], W_Z1Z4.propsBus_a) annotation (Line(
          points={{-230,64.2222},{-230,60},{-282,60},{-282,38},{-212,38},{-212,
              35},{-211.6,35}},
          color={255,204,51},
          thickness=0.5));
      connect(Z4.propsBus[7], W_Z4Z5.propsBus_b) annotation (Line(
          points={{-230,64.4444},{-230,60},{-282,60},{-282,38},{-158,38},{-158,
              51.6},{-155,51.6}},
          color={255,204,51},
          thickness=0.5));
      connect(Z4.propsBus[8], I4_Z4Z5.propsBus_a) annotation (Line(
          points={{-230,64.6667},{-230,60},{-282,60},{-282,38},{-158,38},{-158,
              68.4},{-155,68.4}},
          color={255,204,51},
          thickness=0.5));
      connect(Z4.propsBus[9], Z4_Ceiling.propsBus_a) annotation (Line(
          points={{-230,64.8889},{-230,60},{-234,60},{-234,40},{-70,40},{-70,
              388},{-222,388},{-222,395}},
          color={255,204,51},
          pattern=LinePattern.Dash));
      connect(Z3.propsBus[1], Z3_FloorG.propsBus_a) annotation (Line(
          points={{-36,-16.875},{-36,-20},{-70,-20},{-70,-340},{-22,-340},{-22,-355}},
          color={255,204,51},
          pattern=LinePattern.Dash));

      connect(Z3.propsBus[2], Z3_wall_F.propsBus_a) annotation (Line(
          points={{-36,-16.625},{-36,-20},{-82,-20},{-82,-64},{-51.6001,-64},{
              -51.6001,-68.8333}},
          color={255,204,51},
          thickness=0.5));
      connect(Z3.propsBus[3], Z3_door_F.propsBus_a) annotation (Line(
          points={{-36,-16.375},{-36,-20},{-82,-20},{-82,-64},{-31.6001,-64},{
              -31.6001,-68.8333}},
          color={255,204,51},
          thickness=0.5));
      connect(Z3.propsBus[4], W_Z2Z3.propsBus_b) annotation (Line(
          points={{-36,-16.125},{-36,-20},{-82,-20},{-82,-64},{22,-64},{22,-28.4},{25,
              -28.4}},
          color={255,204,51},
          thickness=0.5));
      connect(Z3.propsBus[5], W_Z3Z5.propsBus_b) annotation (Line(
          points={{-36,-15.875},{-36,-20},{-82,-20},{-82,22},{-31.6,22},{-31.6,25}},
          color={255,204,51},
          thickness=0.5));

      connect(Z3.propsBus[6], I2_Z3Z5.propsBus_a) annotation (Line(
          points={{-36,-15.625},{-36,-20},{-82,-20},{-82,22},{-48,22},{-48,24},{-48.4,
              24},{-48.4,25}},
          color={255,204,51},
          thickness=0.5));
      connect(Z3.propsBus[7], W_Z1Z3.propsBus_a) annotation (Line(
          points={{-36,-15.375},{-36,-20},{-82,-20},{-82,-28.4},{-85,-28.4}},
          color={255,204,51},
          thickness=0.5));
      connect(Z3.propsBus[8], Z3_Ceiling.propsBus_a) annotation (Line(
          points={{-36,-15.125},{-36,-20},{-70,-20},{-70,308},{-32,308},{-32,315}},
          color={255,204,51},
          pattern=LinePattern.Dash));

      connect(Z5.propsBus[1], Z5_FloorG.propsBus_a) annotation (Line(
          points={{30,63.0625},{30,60},{-70,60},{-70,-264},{38,-264},{38,-275}},
          color={255,204,51},
          pattern=LinePattern.Dash));
      connect(Z5.propsBus[2], W12_B.propsBus_a) annotation (Line(
          points={{30,63.1875},{30,82},{48,82},{48,86},{48.4,86},{48.4,86.8333}},
          color={255,204,51},
          thickness=0.5));
      connect(Z5.propsBus[3], W11_B.propsBus_a) annotation (Line(
          points={{30,63.3125},{30,82},{28.4,82},{28.4,86.8334}},
          color={255,204,51},
          thickness=0.5));
      connect(Z5.propsBus[4], W10_B.propsBus_a) annotation (Line(
          points={{30,63.4375},{30,82},{8,82},{8,86},{8.39993,86},{8.39993,
              86.8333}},
          color={255,204,51},
          thickness=0.5));

      connect(Z5.propsBus[5], W9_B.propsBus_a) annotation (Line(
          points={{30,63.5625},{30,82},{-11.6001,82},{-11.6001,86.8333}},
          color={255,204,51},
          thickness=0.5));
      connect(Z5.propsBus[6], Z5_wall_B.propsBus_a) annotation (Line(
          points={{30,63.6875},{30,82},{-51.6001,82},{-51.6001,86.8333}},
          color={255,204,51},
          thickness=0.5));
      connect(Z5.propsBus[7], I4_Z4Z5.propsBus_b) annotation (Line(
          points={{30,63.8125},{30,82},{-142,82},{-142,68.4},{-145,68.4}},
          color={255,204,51},
          thickness=0.5));
      connect(Z5.propsBus[8], W_Z4Z5.propsBus_a) annotation (Line(
          points={{30,63.9375},{30,82},{-142,82},{-142,51.6},{-145,51.6}},
          color={255,204,51},
          thickness=0.5));
      connect(Z5.propsBus[9], I1_Z1Z5.propsBus_b) annotation (Line(
          points={{30,64.0625},{30,82},{-142,82},{-142,38},{-128.4,38},{-128.4,35}},
          color={255,204,51},
          thickness=0.5));

      connect(Z5.propsBus[10], W_Z1Z5.propsBus_a) annotation (Line(
          points={{30,64.1875},{30,82},{-142,82},{-142,38},{-111.6,38},{-111.6,35}},
          color={255,204,51},
          thickness=0.5));

      connect(Z5.propsBus[11], I2_Z3Z5.propsBus_b) annotation (Line(
          points={{30,64.3125},{30,82},{-142,82},{-142,38},{-48.4,38},{-48.4,35}},
          color={255,204,51},
          thickness=0.5));
      connect(Z5.propsBus[12], W_Z3Z5.propsBus_a) annotation (Line(
          points={{30,64.4375},{30,82},{-142,82},{-142,38},{-31.6,38},{-31.6,35}},
          color={255,204,51},
          thickness=0.5));
      connect(Z5.propsBus[13], I3_Z2Z5.propsBus_b) annotation (Line(
          points={{30,64.5625},{30,82},{-142,82},{-142,38},{52,38},{52,35},{51.6,35}},
          color={255,204,51},
          thickness=0.5));

      connect(Z5.propsBus[14], W_Z2Z5.propsBus_a) annotation (Line(
          points={{30,64.6875},{30,82},{-142,82},{-142,38},{68.4,38},{68.4,35}},
          color={255,204,51},
          thickness=0.5));
      connect(Z5.propsBus[15], Z5_AdWall.propsBus_a) annotation (Line(
          points={{30,64.8125},{30,82},{222,82},{222,68},{225,68}},
          color={255,204,51},
          thickness=0.5));
      connect(Z5.propsBus[16], Z5_Ceiling.propsBus_a) annotation (Line(
          points={{30,64.9375},{30,60},{-70,60},{-70,388},{38,388},{38,395}},
          color={255,204,51},
          pattern=LinePattern.Dash));
      connect(Z2.propsBus[1], Z2_FloorG.propsBus_a) annotation (Line(
          points={{130,-36.9091},{130,-54},{-70,-54},{-70,-340},{138,-340},{138,-375}},
          color={255,204,51},
          pattern=LinePattern.Dash));

      connect(Z2.propsBus[2], Z2_wall_L.propsBus_a) annotation (Line(
          points={{130,-36.7273},{130,-40},{38,-40},{38,-88.4},{33.1667,-88.4}},
          color={255,204,51},
          thickness=0.5));
      connect(Z2.propsBus[3], W4_F.propsBus_a) annotation (Line(
          points={{130,-36.5455},{130,-40},{38,-40},{38,-102},{111.6,-102},{
              111.6,-106.833}},
          color={255,204,51},
          thickness=0.5));

      connect(Z2.propsBus[4], W5_F.propsBus_a) annotation (Line(
          points={{130,-36.3636},{130,-40},{38,-40},{38,-102},{131.6,-102},{
              131.6,-106.833}},
          color={255,204,51},
          thickness=0.5));

      connect(Z2.propsBus[5], W6_F.propsBus_a) annotation (Line(
          points={{130,-36.1818},{130,-40},{38,-40},{38,-102},{151.6,-102},{
              151.6,-106.833}},
          color={255,204,51},
          thickness=0.5));

      connect(Z2.propsBus[6], Z1_wall_F1.propsBus_a) annotation (Line(
          points={{130,-36},{130,-40},{38,-40},{38,-102},{191.6,-102},{191.6,
              -106.833}},
          color={255,204,51},
          thickness=0.5));

      connect(Z2.propsBus[7], Z2_AdWall.propsBus_a) annotation (Line(
          points={{130,-35.8182},{130,-40},{38,-40},{38,-102},{222,-102},{222,
              -32},{225,-32}},
          color={255,204,51},
          thickness=0.5));
      connect(Z2.propsBus[8], W_Z2Z5.propsBus_b) annotation (Line(
          points={{130,-35.6364},{130,-40},{38,-40},{38,22},{68.4,22},{68.4,25}},
          color={255,204,51},
          thickness=0.5));
      connect(Z2.propsBus[9], I3_Z2Z5.propsBus_a) annotation (Line(
          points={{130,-35.4545},{130,-40},{38,-40},{38,22},{51.6,22},{51.6,25}},
          color={255,204,51},
          thickness=0.5));
      connect(Z2.propsBus[10], W_Z2Z3.propsBus_a) annotation (Line(
          points={{130,-35.2727},{130,-40},{38,-40},{38,-28.4},{35,-28.4}},
          color={255,204,51},
          thickness=0.5));
      connect(Z2.propsBus[11], Z2_Ceiling.propsBus_a) annotation (Line(
          points={{130,-35.0909},{130,-54},{-70,-54},{-70,340},{120,340},{120,290},{
              138,290},{138,295}},
          color={255,204,51},
          pattern=LinePattern.Dash));
      annotation (Diagram(coordinateSystem(extent={{-340,-520},{340,740}}),
                                   graphics={
            Line(
              points={{-90,-450},{-290,-450}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{-90,-450},{-90,-310}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{-290,-450},{-290,-250}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{230,-310},{-290,-310}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{30,-412},{-90,-412}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{230,-250},{-290,-250}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{230,-450},{30,-450}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{230,-450},{230,-250}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{30,-450},{30,-310}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{-150,-310},{-150,-250}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{-90,-110},{-290,-110}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{-90,-110},{-90,30}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{-290,-110},{-290,90}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{230,30},{-290,30}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{30,-72},{-90,-72}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{230,90},{-290,90}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{230,-110},{30,-110}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{230,-110},{230,90}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{30,-110},{30,30}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{-150,30},{-150,90}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{-90,230},{-290,230}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{-90,230},{-90,370}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{-290,230},{-290,430}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{230,370},{-290,370}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{30,268},{-90,268}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{230,430},{-290,430}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{230,230},{30,230}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{230,230},{230,430}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{30,230},{30,370}},
              color={147,149,152},
              thickness=1),
            Line(
              points={{-150,370},{-150,430}},
              color={147,149,152},
              thickness=1)}),       Icon(
            coordinateSystem(extent={{-200,-100},{200,100}}), graphics={
            Rectangle(
              extent={{-200,100},{200,-100}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={191,0,0}),
            Polygon(
              points={{60,-10},{54,-14},{0,30},{-54,-14},{-54,-74},{60,-74},{60,-80},{-60,-80},{-60,-10},{0,40},{60,-10}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-86,80},{74,40}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              fontName="Times New Roman",
              horizontalAlignment=TextAlignment.Left,
              textString="STRUCTURE")}),
        experiment(
          StartTime=1,
          StopTime=259200,
          Interval=600,
          __Dymola_Algorithm="Lsodar"),
        __Dymola_experimentSetupOutput(events=false),
        __Dymola_experimentFlags(
          Advanced(
            EvaluateAlsoTop=true,
            GenerateVariableDependencies=false,
            OutputModelicaCode=false),
          Evaluate=true,
          OutputCPUtime=true,
          OutputFlatModelica=false));
    end Structure;

    package Data "data building"

      package Materials
        extends Modelica.Icons.MaterialPropertiesPackage;

        record Air =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.0241,
            c=1008,
            rho=1.23,
            epsSw=0.00001,
            epsLw=0.00001,
            gas=true,
            mhu=18.3*10e-6) "Air" annotation (Documentation(info="<html>
<p>
Constant air thermal properties.
</p>
</html>"));

        record AeratedConcrete =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.500,
            c=840,
            rho=1300,
            epsLw=0.88,
            epsSw=0.55)
          "light concrete block, for insulation in difficult places"
                                                                  annotation (
            Documentation(info="<html>
<p>
Thermal properties of concrete.
</p>
</html>"));
        record Brick =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=1.00,
            c=840,
            rho=1700,
            epsLw=0.88,
            epsSw=0.55)
          "Heavy masonry for exterior applications"               annotation (
            Documentation(info="<html>
<p>
Thermal properties of heavy bricks for exterior masonry.
</p>
</html>"));
        record Cavity_nr_brick =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.80,
            c=1000,
            rho=1200,
            epsLw=0.8,
            epsSw=0.8) "Cavity with non-reflective sides";
        record Cavity_nr_timber =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=1000,
            c=1008,
            rho=1.23,
            epsLw=0.8,
            epsSw=0.8)
          "Cavity with non-reflective side(s)";
        record Cavity_r =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.0162,
            c=519,
            rho=1.70,
            epsSw=0,
            epsLw=0,
            gas=true,
            mhu=22.9*10e-6)
          "Cavity with reflective sides" annotation (Documentation(info="<html>
<p>
Constant argon thermal properties.
</p>
</html>"));

        record Cavity_Roof =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.22222,
            c=1008,
            rho=1.23,
            epsLw=0.8,
            epsSw=0.8) "Cavity underneath roof tiles";
        record EPS_Insulation =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.022,
            c=1470,
            rho=15,
            epsLw=0.8,
            epsSw=0.8)
          "Waterproof insulatino type, exterior use";
        record Ext_Plaster =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.93,
            c=840,
            rho=1900,
            epsLw=0.8,
            epsSw=0.8) "Exterior plaster";
        record Floorfinish =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=1.3,
            c=840,
            rho=2000,
            epsLw=0.88,
            epsSw=0.55) "Floor finish";
        record Glass =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=1,
            c=750,
            rho=2500,
            epsLw=0.88,
            epsSw=0.55) "Glass in windows";
        record Ground =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=2.0,
            c=1250,
            rho=1600,
            epsLw=0.88,
            epsSw=0.68) "Green roof"
                        annotation (Documentation(info="<html>
<p>
Thermal properties of ground/soil.
</p>
</html>"));
        record PIR_Insulation =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.022,
            c=1470,
            rho=60) "Polyisocyanuraat foam, PIR" annotation (Documentation(info="<html>
<p>
Polyisocyanurate (PIR) insulation thermal properties.
</p>
</html>",         revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
        record PS_DoorInsulation =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.024,
            c=1470,
            rho=15,
            epsLw=0.8,
            epsSw=0.8) "Polystyreen insulation";
        record PS_FloorInsulation =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.030,
            c=1470,
            rho=15,
            epsLw=0.88,
            epsSw=0.55) "PS groundfloor";
        record PS_RoofInsulation =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.028,
            c=1470,
            rho=15,
            epsLw=0.8,
            epsSw=0.8) "Polystyreen roof insulation";
        record PrefabConcrete =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.9,
            c=880,
            rho=1900,
            epsLw=0.88,
            epsSw=0.55)
          "Dense cast concrete, also for finishing"               annotation (
            Documentation(info="<html>
<p>
Thermal properties of concrete.
</p>
</html>"));
        record ReinforcedConcrete =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=1.9,
            c=840,
            rho=2500,
            epsLw=0.88,
            epsSw=0.55)
          "Dense cast concrete, also for finishing"               annotation (
            Documentation(info="<html>
<p>
Thermal properties of concrete.
</p>
</html>"));
        record Rockwool_Insulation =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.036,
            c=840,
            rho=110,
            epsLw=0.8,
            epsSw=0.8) "Rockwool" annotation (Documentation(info="<html>
<p>
Rockwool insulation thermal properties.
</p>
</html>",         revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
        record Roofing =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.17,
            c=1470,
            rho=1200,
            epsLw=0.8,
            epsSw=0.8) "Roofing flat roof";
        record Roof_Tile =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.961,
            c=1000,
            rho=2000,
            epsLw=0.88,
            epsSw=0.55) "Roof tile";
        record Sandlime_Brick =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.9,
            c=900,
            rho=1900,
            epsLw=0.88,
            epsSw=0.55)
          "Dense cast concrete, also for finishing"               annotation (
            Documentation(info="<html>
<p>
Thermal properties of concrete.
</p>
</html>"));
        record SolarPanel =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=237,
            c=897,
            rho=2702,
            epsLw=0.85,
            epsSw=0.65) "Solar panel"                  annotation (Documentation(info="<html>
<p>
Thermal properties of gypsum.
</p>
</html>"));
        record Timber =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.131,
            c=1000,
            rho=600,
            epsLw=0.86,
            epsSw=0.44) "Timber finishing" annotation (Documentation(info="<html>
<p>
Thermal properties of timber.
</p>
</html>"));
        record Unilin_DSD_Univision =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.125,
            c=1450,
            rho=173.1)
          "Roof panel from unilin filled with polyisocyanuraat foam, PIR, 12 12 multiplex"
                                                      annotation (Documentation(info="<html>
<p>
Polyisocyanurate (PIR) insulation thermal properties.
</p>
</html>",         revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
        record WaterproofShield =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=0.052,
            c=1005,
            rho=1.23,
            epsLw=0.8,
            epsSw=0.8)
          "UV-foil, waterproof breathable shield";
        record Int_Plaster =
            IDEAS.Buildings.Data.Interfaces.Material (
            k=1.0,
            c=1000,
            rho=1200,
            epsLw=0.85,
            epsSw=0.65) "Gypsum plaster for finishing" annotation (Documentation(info="<html>
<p>
Thermal properties of gypsum.
</p>
</html>"));
        annotation (Icon(graphics={
              Rectangle(
                lineColor={200,200,200},
                fillColor={248,248,248},
                fillPattern=FillPattern.HorizontalCylinder,
                extent={{-100,-100},{100,100}},
                radius=25.0),
              Rectangle(
                lineColor={128,128,128},
                extent={{-100,-100},{100,100}},
                radius=25.0),
              Ellipse(
                lineColor={102,102,102},
                fillColor={204,204,204},
                pattern=LinePattern.None,
                fillPattern=FillPattern.Sphere,
                extent={{-60,-60},{60,60}})}));
      end Materials;

      package Construction_elements
        record X_DoubleGlazingAir =
            IDEAS.Buildings.Data.Interfaces.Glazing (
          final nLay=3,
          final checkLowPerformanceGlazing=false,
          final mats={
            IDEAS.Buildings.Data.Materials.Glass(d=0.0038),
            IDEAS.Buildings.Data.Materials.Air(d=0.012),
            IDEAS.Buildings.Data.Materials.Glass(d=0.0038)},
          final SwTrans=[0, 0.721;
                        10, 0.720;
                        20, 0.718;
                        30, 0.711;
                        40, 0.697;
                        50, 0.665;
                        60, 0.596;
                        70, 0.454;
                        80, 0.218;
                        90, 0.000],
          final SwAbs=[0, 0.082, 0, 0.062;
                      10, 0.082, 0, 0.062;
                      20, 0.084, 0, 0.063;
                      30, 0.086, 0, 0.065;
                      40, 0.090, 0, 0.067;
                      50, 0.094, 0, 0.068;
                      60, 0.101, 0, 0.067;
                      70, 0.108, 0, 0.061;
                      80, 0.112, 0, 0.045;
                      90, 0.000, 0, 0.000],
          final SwTransDif=0.619,
          final SwAbsDif={0.093, 0,  0.063},
          final U_value=2.9,
          final g_value=0.78) "X Double glazing archetype 4/12/4"
          annotation (Documentation(revisions="<html>
<ul>
<li>
September 2, 2015, by Filip Jorissen:<br/>
Moved epsLw definition to solid layer to be consistent 
with changed implementation of MultiLayerLucent.
</li>
</ul>
</html>",         info="<html>
<p>WINDOW v7.3.4.0 Glazing System Thermal and Optical Properties 11/15/15 12:01:44</p>
<p><br><br>ID      : 1</p>
<p>Name    : Single</p>
<p>Tilt    : 90.0</p>
<p>Glazings: 2</p>
<p>KEFF    : 0.1069</p>
<p>Width   : 19.518</p>
<p>Uvalue  : 2.85</p>
<p>SHGCc   : 0.78</p>
<p>SCc     : 0.90</p>
<p>Vtc     : 0.81</p>
<p>RHG     : 582.06</p>
<p><br><br><br>Layer Data for Glazing System &apos;1 Single&apos;</p>
<p><br>ID     Name            D(mm) Tsol  1 Rsol 2 Tvis  1 Rvis 2  Tir  1 Emis 2 Keff</p>
<p>------ --------------- ----- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----</p>
<p>Outside</p>
<p> 12014 Clear4mm.grm   #  3.8 .845 .078 .078 .899 .085 .085 .000 .840 .840 1.00  </p>
<p>       1 Air            12.0                                              .069  </p>
<p> 12014 Clear4mm.grm   #  3.8 .845 .078 .078 .899 .085 .085 .000 .840 .840 1.00  </p>
<p>Inside</p>
<p><br><br>Environmental Conditions: 4 CEN</p>
<p><br>          Tout   Tin  WndSpd   Wnd Dir   Solar  Tsky  Esky</p>
<p>          (C)    (C)   (m/s)            (W/m2)  (C)</p>
<p>         -----  ----  ------  --------  ------  ----  ----</p>
<p>Uvalue     0.0  20.0    5.50  Windward     0.0   0.0  1.00</p>
<p>Solar     30.0  25.0    2.75  Windward   500.0  30.0  1.00</p>
<p><br>Optical Properties for Glazing System &apos;1 Single&apos;</p>
<p><br>Angle      0    10    20    30    40    50    60    70    80    90 Hemis</p>
<p><br>Vtc  : 0.814 0.814 0.812 0.808 0.796 0.766 0.693 0.538 0.274 0.000 0.712</p>
<p>Rf   : 0.154 0.154 0.155 0.158 0.168 0.197 0.268 0.422 0.686 1.000 0.242</p>
<p>Rb   : 0.154 0.154 0.155 0.158 0.168 0.197 0.268 0.422 0.686 1.000 0.242</p>
<p><br>Tsol : 0.721 0.720 0.718 0.711 0.697 0.665 0.596 0.454 0.218 0.000 0.619</p>
<p>Rf   : 0.135 0.135 0.135 0.138 0.147 0.172 0.236 0.376 0.625 1.000 0.214</p>
<p>Rb   : 0.134 0.135 0.135 0.138 0.147 0.172 0.236 0.376 0.625 1.000 0.214</p>
<p><br>Abs1 : 0.082 0.082 0.084 0.086 0.090 0.094 0.101 0.108 0.112 0.000 0.093</p>
<p>Abs2 : 0.062 0.062 0.063 0.065 0.067 0.068 0.067 0.061 0.045 0.000 0.063</p>
<p><br>SHGCc: 0.780 0.780 0.778 0.773 0.761 0.732 0.664 0.520 0.276 0.000 0.682</p>
<p><br>Tdw-K  :  0.609</p>
<p>Tdw-ISO:  0.743</p>
<p>Tuv    :  0.579</p>
<p><br><br><br><br><br>      Temperature Distribution (degrees C)</p>
<p>        Winter         Summer</p>
<p>       Out   In       Out   In</p>
<p>      ----  ----     ----  ----</p>
<p>Lay1   2.5   2.7     34.0  34.0   </p>
<p>Lay2  12.7  12.9     32.7  32.6   </p>
</html>"));
        record X_ExtDoor_Timber "X_ExtDoor_Timber"
          extends IDEAS.Buildings.Data.Interfaces.Construction(
                                                         mats={
                 IDEAS.Buildings.Data.Materials.Timber(d=0.050)});

          annotation (Documentation(info="<html>
<p>
Example implementation of a cavity wall.
</p>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
        end X_ExtDoor_Timber;

        record X_ExtWall_Brick "X Brick cavity wall exterior"
          extends IDEAS.Buildings.Data.Interfaces.Construction(
                                                         mats={
                  IDEAS.Buildings.Data.Materials.BrickMe(d=0.08),
                  IDEAS.Buildings.Data.Insulation.Rockwool(d=0.05),
                  IDEAS.Buildings.Data.Materials.BrickMi(d=0.14),
                  IDEAS.Buildings.Data.Materials.Gypsum(d=0.015)});

          annotation (Documentation(info="<html>
<p>
Example implementation of a cavity wall.
</p>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
        end X_ExtWall_Brick;

        record X_Firstfloor "X Firstfloor build-up"
          extends IDEAS.Buildings.Data.Interfaces.Construction(
                                                         mats={
                 IDEAS.Buildings.Data.Materials.Concrete(d=0.015),
                 IDEAS.Buildings.Data.Materials.Screed(d=0.03),
                 IDEAS.Buildings.Data.Materials.Screed(d=0.05),
                 IDEAS.Buildings.Data.Insulation.Rockwool(d=0.10969),
                 IDEAS.Buildings.Data.Materials.Concrete(d=0.2)});

          annotation (Documentation(info="<html>
<p>
Example implementation of a cavity wall.
</p>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
        end X_Firstfloor;

        record X_WindowFrameTimber "X_WindowFrameTimber"
          extends IDEAS.Buildings.Data.Interfaces.Frame(U_value=0.95);
              annotation (Documentation(info="<html>
<p>
Wooden window frame. U value may vary.
</p>
</html>"));
        end X_WindowFrameTimber;

        record X_Groundfloor "X Ground floor build-up"
          extends IDEAS.Buildings.Data.Interfaces.Construction(
                                                         mats={
                 IDEAS.Buildings.Data.Materials.Concrete(d=0.20),
                 IDEAS.Buildings.Data.Insulation.Rockwool(d=0.10969),
                 IDEAS.Buildings.Data.Materials.Screed(d=0.05),
                 IDEAS.Buildings.Data.Materials.Screed(d=0.03),
                 IDEAS.Buildings.Data.Materials.Concrete(d=0.015)});

          annotation (Documentation(info="<html>
<p>
Example implementation of a cavity wall.
</p>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
        end X_Groundfloor;

        record X_IntDoor_Timber "X Interior door timber"
          extends IDEAS.Buildings.Data.Interfaces.Construction(
                                                         mats={
                 IDEAS.Buildings.Data.Materials.Timber(d=0.04)});

          annotation (Documentation(info="<html>
<p>
Example implementation of a cavity wall.
</p>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
        end X_IntDoor_Timber;

        record X_Vide "X Vide"
          extends IDEAS.Buildings.Data.Interfaces.Construction(
                                                         mats={
                 IDEAS.Buildings.Data.Materials.Air(d=0.001)});

          annotation (Documentation(info="<html>
<p>
Example implementation of a cavity wall.
</p>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
        end X_Vide;

        record X_IntWall_Thick "X Internel wall thick"
          extends IDEAS.Buildings.Data.Interfaces.Construction(
                                                         mats={
                  IDEAS.Buildings.Data.Materials.Gypsum(d=0.015),
                  IDEAS.Buildings.Data.Materials.BrickMi(d=0.27),
                  IDEAS.Buildings.Data.Materials.Gypsum(d=0.015)});

          annotation (Documentation(info="<html>
<p>
Example implementation of a cavity wall.
</p>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
        end X_IntWall_Thick;

        record X_IntWall_Medium "X Internal wall medium"
          extends IDEAS.Buildings.Data.Interfaces.Construction(
                                                         mats={
                  IDEAS.Buildings.Data.Materials.Gypsum(d=0.015),
                  IDEAS.Buildings.Data.Materials.BrickMi(d=0.22),
                  IDEAS.Buildings.Data.Materials.Gypsum(d=0.015)});

          annotation (Documentation(info="<html>
<p>
Example implementation of a cavity wall.
</p>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
        end X_IntWall_Medium;

        annotation (Icon(graphics={
              Rectangle(
                lineColor={200,200,200},
                fillColor={248,248,248},
                fillPattern=FillPattern.HorizontalCylinder,
                extent={{-100,-100},{100,100}},
                radius=25.0),
              Rectangle(
                lineColor={128,128,128},
                extent={{-100,-100},{100,100}},
                radius=25.0),
              Ellipse(
                lineColor={102,102,102},
                fillColor={204,204,204},
                pattern=LinePattern.None,
                fillPattern=FillPattern.Sphere,
                extent={{-60,-60},{60,60}})}));
      end Construction_elements;
      annotation (Icon(graphics={
            Rectangle(
              lineColor={200,200,200},
              fillColor={248,248,248},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100,-100},{100,100}},
              radius=25.0),
            Rectangle(
              lineColor={128,128,128},
              extent={{-100,-100},{100,100}},
              radius=25.0),
            Ellipse(
              lineColor={102,102,102},
              fillColor={204,204,204},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Sphere,
              extent={{-60,-60},{60,60}})}));
    end Data;

    annotation (Icon(graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={255,255,255},
            pattern=LinePattern.Dot,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}));
  end Envelope;

  package Records

    record Infiltration

      //Zones:
      //       1  -> Kitchen_Diningroom
      //       2  -> Livingroom
      //       3  -> KidsBedroom
      //       4  -> Bathroom
      //       5  -> TechnicalRoom
      //       6  -> Entrance
      //       7  -> Corridor
      //       8  -> MeterCupboard
      //       9  -> Restroom
      //       10 -> MasterBedroom
      // - INFILTRATION -
      // parameter Integer nWindows = 0 "Number of window-ports for the pressure-based infiltration model";
      // parameter Integer nGrids = 0 "Number of grid-ports for the pressure-based infiltration model";
      // parameter Integer nInt_openings= 0 "Number of interior door-ports for the pressure-based infiltration model";
      // parameter Integer nExt_walls = 0 "Number of exterior wall ports for the pressure-based infiltration model";
      // parameter Integer nInt_walls = 0 "Number of interior wall ports for the pressure-based infiltration model"; //MVH
      // Zone 1: Livingroom ---------------------------------------------------------------------------------------------------------------------------------------------------
      parameter Integer Z1_nWindows = 4;
      parameter Integer Z1_nGrids = 0;
      parameter Integer Z1_nInt_openings = 2;
      parameter Integer Z1_nExt_walls = 3;
      parameter Integer Z1_nInt_walls = 2;
      parameter Integer Z1_nInt_floors = 0;
      parameter Integer Z1_nInfiltration = Z1_nWindows*2 + Z1_nGrids + Z1_nInt_openings*2 + Z1_nExt_walls*2 + Z1_nInt_walls*2 + Z1_nInt_floors;

      // Zone 2: Kitchen ------------------------------------------------------------------------------------------------------------------------------------------------------
      parameter Integer Z2_nWindows = 1;
      parameter Integer Z2_nGrids = 0;
      parameter Integer Z2_nInt_openings = 1;
      parameter Integer Z2_nExt_walls = 2;
      parameter Integer Z2_nInt_walls = 2;
      parameter Integer Z2_nInt_floors = 0;
      parameter Integer Z2_nInfiltration = Z2_nWindows*2 + Z2_nGrids + Z2_nInt_openings*2 + Z2_nExt_walls*2 + Z2_nInt_walls*2 + Z2_nInt_floors;

      // Zone 3: Bedroom ------------------------------------------------------------------------------------------------------------------------------------------------------
      parameter Integer Z3_nWindows = 1;
      parameter Integer Z3_nGrids = 0;
      parameter Integer Z3_nInt_openings = 1;
      parameter Integer Z3_nExt_walls = 2;
      parameter Integer Z3_nInt_walls = 2;
      parameter Integer Z3_nInt_floors = 0;
      parameter Integer Z3_nInfiltration = Z3_nWindows*2 + Z3_nGrids + Z3_nInt_openings*2 + Z3_nExt_walls*2 + Z3_nInt_walls*2 + Z3_nInt_floors;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-42,42},{42,-42}},
              lineColor={255,200,0},
              fillColor={255,200,0},
              fillPattern=FillPattern.Solid),
            Ellipse(extent={{-40,40},{40,-40}}, lineColor={0,0,0}),
            Ellipse(
              extent={{-14,14},{14,-14}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-38,10},{-10,10}}, color={0,0,0}),
            Line(points={{-38,-10},{-10,-10}}, color={0,0,0}),
            Line(points={{10,10},{38,10}}, color={0,0,0}),
            Line(points={{10,-10},{38,-10}}, color={0,0,0}),
            Text(
              extent={{-24,34},{24,14}},
              lineColor={0,0,0},
              fillColor={255,200,0},
              fillPattern=FillPattern.Solid,
              fontName="Times New Roman",
              textString="Infiltration"),
            Text(
              extent={{-20,-14},{20,-34}},
              lineColor={0,0,0},
              fillColor={255,200,0},
              fillPattern=FillPattern.Solid,
              fontName="Times New Roman",
              textString="- record -")}), Diagram(coordinateSystem(preserveAspectRatio=false)));

    end Infiltration;

    record BuildingZones

      //Zones:
      //       1  -> C0.15 (claas)
      //       2  -> C0.13 (class)
      //       3  -> C0.14 (entrance)
      //       4  -> C0.12 (restroom)
      //       5  -> C0.11 (corridor)
      //parameter String data_BZ = Modelica.Utilities.Files.loadResource("modelica://MVH_TestHouse/Resources_BZ/BuildingZones.txt");
      parameter Real X_n50 = 2;
      parameter Integer X_n50toAch = 25;

      // Zone 1: ------------------------------------------------------------------------------------------------------------------------------------------------------
      parameter Modelica.Units.SI.Area   Z1_FloorArea = 10*7;
      parameter Modelica.Units.SI.Height Z1_hZone =     4;
      parameter Modelica.Units.SI.Volume Z1_Volume =    Z1_FloorArea*Z1_hZone;

      // Zone 2: -----------------------------------------------------------------------------------------------------------------------------------------------------
      parameter Modelica.Units.SI.Area   Z2_FloorArea = 10*7;
      parameter Modelica.Units.SI.Height Z2_hZone =     4;
      parameter Modelica.Units.SI.Volume Z2_Volume =    Z2_FloorArea*Z2_hZone;

      // Zone 3: ------------------------------------------------------------------------------------------------------------------------------------------------
      parameter Modelica.Units.SI.Area   Z3_FloorArea = 6*5;
      parameter Modelica.Units.SI.Height Z3_hZone =     4;
      parameter Modelica.Units.SI.Volume Z3_Volume =    Z3_FloorArea*Z3_hZone;

      // Zone 4: -----------------------------------------------------------------------------------------------------------------------------------------------------
      parameter Modelica.Units.SI.Area   Z4_FloorArea = 3*7;
      parameter Modelica.Units.SI.Height Z4_hZone =     4;
      parameter Modelica.Units.SI.Volume Z4_Volume =    Z4_FloorArea*Z4_hZone;

      // Zone 5: -----------------------------------------------------------------------------------------------------------------------------------------------------
      parameter Modelica.Units.SI.Area   Z5_FloorArea = 3*19;
      parameter Modelica.Units.SI.Height Z5_hZone =     4;
      parameter Modelica.Units.SI.Volume Z5_Volume =    Z5_FloorArea*Z5_hZone;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                            Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-42,42},{42,-42}},
              lineColor={65,105,225},
              fillColor={65,105,225},
              fillPattern=FillPattern.Solid),
            Ellipse(extent={{-40,40},{40,-40}}, lineColor={255,255,255},
              fillColor={65,105,225},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-14,14},{14,-14}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-38,10},{-10,10}}, color={255,255,255}),
            Line(points={{-38,-10},{-10,-10}}, color={255,255,255}),
            Line(points={{10,10},{38,10}}, color={255,255,255}),
            Line(points={{10,-10},{38,-10}}, color={255,255,255}),
            Text(
              extent={{-28,32},{30,14}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              fontName="Times New Roman",
              textString="Building Zones"),
            Text(
              extent={{-20,-14},{20,-34}},
              lineColor={255,255,255},
              fillColor={255,200,0},
              fillPattern=FillPattern.Solid,
              fontName="Times New Roman",
              textString="- record -")}), Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end BuildingZones;

    record BuildingEnvelope

      //Zones:
      //       1  -> Kitchen_Diningroom
      //       2  -> Livingroom
      //       3  -> KidsBedroom
      //       4  -> Bathroom
      //       5  -> TechnicalRoom
      //       6  -> Entrance
      //       7  -> Corridor
      //       8  -> MeterCupboard
      //       9  -> Restroom
      //       10 -> MasterBedroom
      parameter Modelica.Units.SI.Angle azi_F=3.141592654
        "N-Orientation 180°";
      parameter Modelica.Units.SI.Angle azi_L=4.712388980
        "E-Orientation 270°";
      parameter Modelica.Units.SI.Angle azi_B=0.000000000
        "S-Orientation 0°";
      parameter Modelica.Units.SI.Angle azi_R=1.570796327
        "W-Orientation 90°";

      parameter Real W_frac = 0.30 "Area fraction of the window framee";

      // Zone 1: -------------------------------------------------------------------------------------------------------------------------------------------
      parameter Modelica.Units.SI.Area Z1_FloorG = 10*7;

      parameter Modelica.Units.SI.Area W1_F = 2.20/8;
      parameter Modelica.Units.SI.Area W2_F = 2.20/8;
      parameter Modelica.Units.SI.Area W3_F = 2.20/8;

      parameter Modelica.Units.SI.Area Z1_wall_F = 10*4-W1_F-W2_F-W3_F;
      parameter Modelica.Units.SI.Area Z1_wall_L = 7*4;
      parameter Modelica.Units.SI.Area Z1_wall_R = 2*4;

      parameter Modelica.Units.SI.Area I1_Z1Z5 = 2.00;

      parameter Modelica.Units.SI.Area W_Z1Z3 = 5*4;
      parameter Modelica.Units.SI.Area W_Z1Z4 = 7*4;
      parameter Modelica.Units.SI.Area W_Z1Z5 = 3*4-I1_Z1Z5;

      parameter Modelica.Units.SI.Area Z1_Ceiling = 10*7;

      // Zone 2: ---------------------------------------------------------------------------------------------------------------------------------------------------
      parameter Modelica.Units.SI.Area Z2_FloorG = 10*7;

      parameter Modelica.Units.SI.Area W4_F = 2.20/8;
      parameter Modelica.Units.SI.Area W5_F = 2.20/8;
      parameter Modelica.Units.SI.Area W6_F = 2.20/8;

      parameter Modelica.Units.SI.Area Z2_wall_F = 10*4-W4_F-W5_F-W6_F;
      parameter Modelica.Units.SI.Area Z2_wall_L = 2*4;
      parameter Modelica.Units.SI.Area Z2_AdWall = 7*4;

      parameter Modelica.Units.SI.Area I3_Z2Z5 = 2.00;

      parameter Modelica.Units.SI.Area W_Z2Z3 = 5*4;
      parameter Modelica.Units.SI.Area W_Z2Z5 = 10*4-I3_Z2Z5;

      parameter Modelica.Units.SI.Area Z2_Ceiling = 10*7;

      // Zone 3: --------------------------------------------------------------------------------------------------------------------------------------------------
      parameter Modelica.Units.SI.Area Z3_FloorG = 6*5;

      parameter Modelica.Units.SI.Area Z3_door_F = 4.00;

      parameter Modelica.Units.SI.Area Z3_wall_F = 6*4-Z3_door_F;

      parameter Modelica.Units.SI.Area I2_Z3Z5 = 2.00;

      parameter Modelica.Units.SI.Area W_Z3Z5 = 6*4-I2_Z3Z5;

      parameter Modelica.Units.SI.Area Z3_Ceiling = 6*5;

      // Zone 4: ---------------------------------------------------------------------------------------------------------------------------------------------------
      parameter Modelica.Units.SI.Area Z4_FloorG = 7*3;

      parameter Modelica.Units.SI.Area W7_L = 2.20/8;
      parameter Modelica.Units.SI.Area W8_B = 2.20/8;

      parameter Modelica.Units.SI.Area Z4_wall_L = 3*4-W7_L;
      parameter Modelica.Units.SI.Area Z4_wall_B = 7*4-W8_B;

      parameter Modelica.Units.SI.Area I4_Z4Z5 = 2.00;

      parameter Modelica.Units.SI.Area W_Z4Z5 = 3*4-I4_Z4Z5;

      parameter Modelica.Units.SI.Area Z4_Ceiling = 7*3;

      // Zone 5: ---------------------------------------------------------------------------------------------------------------------------------------------------
      parameter Modelica.Units.SI.Area Z5_FloorG = 19*3;

      parameter Modelica.Units.SI.Area W9_B = 2.20/8;
      parameter Modelica.Units.SI.Area W10_B = 2.20/8;
      parameter Modelica.Units.SI.Area W11_B = 2.20/8;
      parameter Modelica.Units.SI.Area W12_B = 2.20/8;

      parameter Modelica.Units.SI.Area Z5_wall_B = 19*4-W9_B-W10_B-W11_B-W12_B;
      parameter Modelica.Units.SI.Area Z5_AdWall = 3*4;

      parameter Modelica.Units.SI.Area Z5_Ceiling = 19*3;




      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                            Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-42,42},{42,-42}},
              lineColor={255,0,0},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(extent={{-40,40},{40,-40}}, lineColor={255,255,255},
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-14,14},{14,-14}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-38,10},{-10,10}}, color={255,255,255}),
            Line(points={{-38,-10},{-10,-10}}, color={255,255,255}),
            Line(points={{10,10},{38,10}}, color={255,255,255}),
            Line(points={{10,-10},{38,-10}}, color={255,255,255}),
            Text(
              extent={{-28,32},{30,14}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              fontName="Times New Roman",
              textString="Building Envelope"),
            Text(
              extent={{-20,-14},{20,-34}},
              lineColor={255,255,255},
              fillColor={255,200,0},
              fillPattern=FillPattern.Solid,
              fontName="Times New Roman",
              textString="- record -")}), Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end BuildingEnvelope;
    annotation (Icon(graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={255,255,255},
            pattern=LinePattern.Dot,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}));
  end Records;

  package Heating

    model PIDHeatingCooling

      parameter Integer nZones(min=1) = nZones "Number of conditioned thermal zones in the building";
      parameter Integer timeI=3600 "Time constant for integrator - PID";
      parameter Integer timeD=60 "Time constant for derivative - PID";
      parameter Integer gainPID=1000 "Gain - PID";
      parameter Integer ymaxPIDH=1000000 "Max power heating (positive)";
      parameter Integer ymaxPIDC=ymaxPIDH "Max power cooling (positive)";
      parameter Real shareHeaCon(min=0,max=1) = 0.7 "Fraction of heat that is dissipated using convectice heat transfer";
      parameter Real shareCooCon(min=0,max=1) = 0.9 "Fraction of heat that is dissipated using convectice heat transfer";

    public
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortCon
        "Nodes for convective heat gains"
        annotation (Placement(transformation(extent={{-210,10},{-190,30}}),
            iconTransformation(extent={{-210,10},{-190,30}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortRad
        "Nodes for radiative heat gains"
        annotation (Placement(transformation(extent={{-210,-30},{-190,-10}}),
            iconTransformation(extent={{-210,-30},{-190,-10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[nZones] heatPortEmb
        "Construction nodes for heat gains by embedded layers"
        annotation (Placement(transformation(extent={{-210,50},{-190,70}}),
            iconTransformation(extent={{-210,50},{-190,70}})));
      Modelica.Blocks.Interfaces.RealInput[nZones] TSensor(
        final quantity="ThermodynamicTemperature",
        unit="degC",
        displayUnit="degC",
        min=0) "Sensor temperature" annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-204,-60}), iconTransformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-200,-60})));
      Modelica.Blocks.Interfaces.RealInput[nZones] TSetCool(
        final quantity="ThermodynamicTemperature",
        unit="degC",
        displayUnit="degC",
        min=0) "Setpoint temperature cooling for the zones"
                                                    annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-20,-104}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-20,-100})));
      IDEAS.Controls.Continuous.LimPID heatPID[nZones](k=gainPID, yMax=ymaxPIDH)
        annotation (Placement(transformation(extent={{-20,20},{-40,40}})));
      IDEAS.Controls.Continuous.LimPID coolPID[nZones](k=gainPID,
        yMax=0,
        yMin=-ymaxPIDC)
        annotation (Placement(transformation(extent={{-20,-40},{-40,-20}})));
      Modelica.Blocks.Interfaces.RealInput[nZones] TSetHeat(
        final quantity="ThermodynamicTemperature",
        unit="degC",
        displayUnit="degC",
        min=0) "Setpoint temperature heating for the zones" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,-104}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,-100})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin[nZones] toKelvin
        annotation (Placement(transformation(extent={{-160,-70},{-140,-50}})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin[nZones] toKelvin1
        annotation (Placement(transformation(extent={{-6,-6},{6,6}},
            rotation=90,
            origin={-20,-80})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin[nZones] toKelvin2
        annotation (Placement(transformation(extent={{-6,-6},{6,6}},
            rotation=90,
            origin={20,-80})));
      Modelica.Blocks.Interfaces.RealOutput HeatingPower[nZones](
        final quantity="Power",
        unit="W",
        displayUnit="W",
        min=0) annotation (Placement(transformation(extent={{196,10},{216,30}}),
            iconTransformation(
            extent={{8,-8},{-8,8}},
            rotation=180,
            origin={200,20})));
      Modelica.Blocks.Interfaces.RealOutput CoolingPower[nZones](
        final quantity="Power",
        unit="W",
        displayUnit="W",
        min=0) annotation (Placement(transformation(extent={{196,-30},{216,-10}}),
            iconTransformation(
            extent={{8,-8},{-8,8}},
            rotation=180,
            origin={200,-20})));
    protected
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector[nZones](each m=2)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-170,20})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow HeatingCon[nZones] annotation (Placement(transformation(extent={{-120,30},
                {-140,50}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow CoolingCon[nZones] annotation (Placement(transformation(extent={{-120,10},
                {-140,30}})));
    protected
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector1
                                                                                [nZones](each m=2)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-170,-20})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow HeatingRad[nZones] annotation (Placement(transformation(extent={{-120,
                -30},{-140,-10}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow CoolingRad[nZones] annotation (Placement(transformation(extent={{-120,
                -50},{-140,-30}})));
      Modelica.Blocks.Math.Gain[nZones] fraHeaCon(each k=shareHeaCon)
        "Fraction of heat that is dissipated through convective port"
        annotation (Placement(transformation(extent={{-84,34},{-96,46}})));
      Modelica.Blocks.Math.Gain[nZones] fraHeaRad(each k=1 - shareHeaCon)
        "Fraction of heat that is dissipated through radiative port"
        annotation (Placement(transformation(extent={{-84,-26},{-96,-14}})));
      Modelica.Blocks.Math.Gain[nZones] fraCooCon(each k=shareCooCon)
        "Fraction of heat that is dissipated through convective port"
        annotation (Placement(transformation(extent={{-84,14},{-96,26}})));
      Modelica.Blocks.Math.Gain[nZones] fraCoooRad(each k=1 - shareCooCon)
        "Fraction of heat that is dissipated through radiative port"
        annotation (Placement(transformation(extent={{-84,-46},{-96,-34}})));
    equation
      connect(thermalCollector.port_b, heatPortCon)
        annotation (Line(points={{-180,20},{-200,20}}, color={191,0,0}));
      connect(thermalCollector1.port_b, heatPortRad)
        annotation (Line(points={{-180,-20},{-200,-20}}, color={191,0,0}));
      connect(HeatingCon.port, thermalCollector.port_a[1]) annotation (Line(points={
              {-140,40},{-150,40},{-150,20},{-160.25,20}}, color={191,0,0}));
      connect(CoolingCon.port, thermalCollector.port_a[2])
        annotation (Line(points={{-140,20},{-159.75,20}}, color={191,0,0}));
      connect(HeatingRad.port, thermalCollector1.port_a[1])
        annotation (Line(points={{-140,-20},{-160.25,-20}}, color={191,0,0}));
      connect(CoolingRad.port, thermalCollector1.port_a[2]) annotation (Line(points=
             {{-140,-40},{-150,-40},{-150,-20},{-159.75,-20}}, color={191,0,0}));
      connect(fraHeaCon.y, HeatingCon.Q_flow)
        annotation (Line(points={{-96.6,40},{-120,40}}, color={0,0,127}));
      connect(fraCooCon.y, CoolingCon.Q_flow)
        annotation (Line(points={{-96.6,20},{-120,20}}, color={0,0,127}));
      connect(fraHeaRad.y, HeatingRad.Q_flow)
        annotation (Line(points={{-96.6,-20},{-120,-20}}, color={0,0,127}));
      connect(fraCoooRad.y, CoolingRad.Q_flow)
        annotation (Line(points={{-96.6,-40},{-120,-40}}, color={0,0,127}));
      connect(coolPID.y, fraCooCon.u) annotation (Line(points={{-41,-30},{-72,-30},{
              -72,20},{-82.8,20}}, color={0,0,127}));
      connect(coolPID.y, fraCoooRad.u) annotation (Line(points={{-41,-30},{-72,-30},
              {-72,-40},{-82.8,-40}}, color={0,0,127}));
      connect(heatPID.y, fraHeaCon.u) annotation (Line(points={{-41,30},{-76,30},{-76,
              40},{-82.8,40}}, color={0,0,127}));
      connect(heatPID.y, fraHeaRad.u) annotation (Line(points={{-41,30},{-76,30},{-76,
              -20},{-82.8,-20}}, color={0,0,127}));
      connect(TSensor, toKelvin.Celsius)
        annotation (Line(points={{-204,-60},{-162,-60}}, color={0,0,127}));
      connect(toKelvin.Kelvin, coolPID.u_m) annotation (Line(points={{-139,-60},{-30,
              -60},{-30,-42}}, color={0,0,127}));
      connect(toKelvin.Kelvin, heatPID.u_m) annotation (Line(points={{-139,-60},{-6,
              -60},{-6,12},{-30,12},{-30,18}}, color={0,0,127}));
      connect(TSetCool, toKelvin1.Celsius)
        annotation (Line(points={{-20,-104},{-20,-87.2}}, color={0,0,127}));
      connect(TSetHeat, toKelvin2.Celsius)
        annotation (Line(points={{20,-104},{20,-87.2}}, color={0,0,127}));
      connect(toKelvin1.Kelvin, coolPID.u_s) annotation (Line(points={{-20,-73.4},{-20,
              -56},{-10,-56},{-10,-30},{-18,-30}}, color={0,0,127}));
      connect(toKelvin2.Kelvin, heatPID.u_s)
        annotation (Line(points={{20,-73.4},{20,30},{-18,30}}, color={0,0,127}));
      connect(heatPID.y, HeatingPower) annotation (Line(points={{-41,30},{-46,30},{-46,
              46},{180,46},{180,20},{206,20}}, color={0,0,127}));
      connect(coolPID.y, CoolingPower) annotation (Line(points={{-41,-30},{-46,-30},
              {-46,-14},{180,-14},{180,-20},{206,-20}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
                {200,100}}),                                        graphics={
            Rectangle(
              extent={{-200,100},{200,-100}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={191,0,0}),
            Text(
              extent={{-60,88},{60,48}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              fontName="Times New Roman",
              horizontalAlignment=TextAlignment.Left,
              textString="HEATING"),
            Rectangle(
              extent={{-120,40},{-140,-40}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-90,0},{-90,40},{-120,20},{-90,0}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-90,-40},{-90,0},{-120,-20},{-90,-40}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,20},{-90,20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{0,-20},{-90,-20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{20,0},{0,-20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{20,0},{0,20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{140,0},{20,0}},
              color={191,0,0},
              thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={
                {-200,-100},{200,100}})));
    end PIDHeatingCooling;

    model RadiatorHeating2

      parameter Integer nZones(min=1) = 5 "Number of conditioned thermal zones in the building";
      //replaceable package Medium=IDEAS.Media.Water;
      parameter Real dTHys=2 "Temperature difference for hysteresis controller";

    public
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortCon
        "Nodes for convective heat gains"
        annotation (Placement(transformation(extent={{-210,10},{-190,30}}),
            iconTransformation(extent={{-210,10},{-190,30}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortRad
        "Nodes for radiative heat gains"
        annotation (Placement(transformation(extent={{-210,-30},{-190,-10}}),
            iconTransformation(extent={{-210,-30},{-190,-10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[nZones] heatPortEmb
        "Construction nodes for heat gains by embedded layers"
        annotation (Placement(transformation(extent={{-210,50},{-190,70}}),
            iconTransformation(extent={{-210,50},{-190,70}})));
      Modelica.Blocks.Interfaces.RealInput[nZones] TSensor(
        final quantity="ThermodynamicTemperature",
        unit="degC",
        displayUnit="degC",
        min=0) "Sensor temperature" annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-204,-60}), iconTransformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-200,-60})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin[nZones] toKelvin
        annotation (Placement(transformation(extent={{-160,-70},{-140,-50}})));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_1(
        redeclare package Medium = IDEAS.Media.Water,
        Q_flow_nominal=1200,
        T_a_nominal=353.15,
        T_b_nominal=333.15,
        dp_nominal=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={-70,10})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin[nZones] toKelvin2
        annotation (Placement(transformation(extent={{-6,-6},{6,6}},
            rotation=90,
            origin={20,-80})));
      Modelica.Blocks.Interfaces.RealInput[nZones] TSetHeat(
        final quantity="ThermodynamicTemperature",
        unit="degC",
        displayUnit="degC",
        min=0) "Setpoint temperature heating for the zones" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,-104}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,-104})));
      IDEAS.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
            IDEAS.Media.Water, m_flow_nominal=1)
        annotation (Placement(transformation(extent={{60,70},{40,90}})));
      IDEAS.Fluid.Actuators.Valves.TwoWayQuickOpening val1(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal=1,
        dpValve_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-70,40})));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_2(
        redeclare package Medium = IDEAS.Media.Water,
        Q_flow_nominal=1200,
        T_a_nominal=353.15,
        T_b_nominal=333.15,
        dp_nominal=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={-30,10})));
      IDEAS.Fluid.Actuators.Valves.TwoWayQuickOpening val2(redeclare package
          Medium =
            IDEAS.Media.Water,
        m_flow_nominal=1,
        dpValve_nominal=1)     annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-30,40})));
      IDEAS.Fluid.FixedResistances.Junction jun(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={1,-1,-1},
        dp_nominal={1,0,0})
        annotation (Placement(transformation(extent={{-20,70},{-40,90}})));
      IDEAS.Fluid.HeatExchangers.PrescribedOutlet preOut(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal=1,
        dp_nominal=1,
        use_X_wSet=false)
        annotation (Placement(transformation(extent={{120,70},{100,90}})));
      Modelica.Blocks.Sources.RealExpression TsetW(each y=273.15 + 80)
        annotation (Placement(transformation(extent={{160,78},{140,92}})));
      IDEAS.Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={1,-1,1},
        dp_nominal={1,0,1})
        annotation (Placement(transformation(extent={{-40,-10},{-20,-30}})));
      IDEAS.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
            IDEAS.Media.Water, nPorts=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={100,0})));
      IDEAS.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            IDEAS.Media.Water, m_flow_nominal=1)
        annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
      Modelica.Blocks.Sources.RealExpression mflow(each y=1)
        annotation (Placement(transformation(extent={{100,104},{80,118}})));
      Modelica.Blocks.Interfaces.RealInput[nZones] TSetCool(
        final quantity="ThermodynamicTemperature",
        unit="degC",
        displayUnit="degC",
        min=0) "Setpoint temperature cooling for the zones"
                                                    annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-20,-104}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-20,-100})));
      Modelica.Blocks.Interfaces.RealOutput CoolingPower[nZones](
        final quantity="Power",
        unit="W",
        displayUnit="W",
        min=0) annotation (Placement(transformation(extent={{196,-30},{216,-10}}),
            iconTransformation(
            extent={{8,-8},{-8,8}},
            rotation=180,
            origin={200,-20})));
      Modelica.Blocks.Sources.RealExpression Qcon_data[nZones - 2](each y=0)
        annotation (Placement(transformation(extent={{-110,72},{-130,88}})));
      Modelica.Blocks.Sources.RealExpression Qrad_data[nZones - 2](each y=0)
        annotation (Placement(transformation(extent={{-110,52},{-130,68}})));
    protected
      Modelica.Blocks.Logical.Hysteresis[nZones] hys(
        each uLow=0,
        each uHigh=dTHys,
        each pre_y_start=false)
        "Hysteresis controller to avoid chattering"
        annotation (Placement(transformation(extent={{90,30},{70,50}})));
      Modelica.Blocks.Math.Add[nZones] add(each final k1=-1, each final k2=1)
                                           annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,-50})));
      Modelica.Blocks.Math.BooleanToReal[nZones] booToRea "Boolean to real conversion"
        annotation (Placement(transformation(extent={{50,30},{30,50}})));
      Modelica.Blocks.Math.Gain[nZones] gain1(final k=0)   "Nominal heat gain"
        annotation (Placement(transformation(extent={{174,-86},{186,-74}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow HeatingCon[nZones -
        2] annotation (Placement(transformation(extent={{-150,70},{-170,90}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow HeatingRad[nZones -
        2] annotation (Placement(transformation(extent={{-150,50},{-170,70}})));
    equation
      connect(TSensor,toKelvin. Celsius)
        annotation (Line(points={{-204,-60},{-162,-60}}, color={0,0,127}));
      connect(TSetHeat,toKelvin2. Celsius)
        annotation (Line(points={{20,-104},{20,-87.2}}, color={0,0,127}));
      connect(add.y,hys. u)
        annotation (Line(points={{20,-39},{20,-32},{140,-32},{140,40},{92,40}},
                                                           color={0,0,127}));
      connect(hys.y,booToRea. u) annotation (Line(points={{69,40},{52,40}},
                   color={255,0,255}));
      connect(toKelvin2.Kelvin, add.u2) annotation (Line(points={{20,-73.4},{20,-70},
              {26,-70},{26,-62}}, color={0,0,127}));
      connect(toKelvin.Kelvin, add.u1) annotation (Line(points={{-139,-60},{2,-60},{
              2,-70},{14,-70},{14,-62}}, color={0,0,127}));
      connect(val1.port_a, rad_1.port_a)
        annotation (Line(points={{-70,30},{-70,20}}, color={0,127,255}));
      connect(val2.port_a, rad_2.port_a)
        annotation (Line(points={{-30,30},{-30,20}}, color={0,127,255}));
      connect(jun.port_2, val1.port_b)
        annotation (Line(points={{-40,80},{-70,80},{-70,50}}, color={0,127,255}));
      connect(jun.port_3, val2.port_b)
        annotation (Line(points={{-30,70},{-30,50}}, color={0,127,255}));
      connect(rad_2.port_b, jun1.port_3)
        annotation (Line(points={{-30,3.55271e-15},{-30,-10}}, color={0,127,255}));
      connect(fan.port_b, jun.port_1)
        annotation (Line(points={{40,80},{-20,80}}, color={0,127,255}));
      connect(preOut.port_b, fan.port_a)
        annotation (Line(points={{100,80},{60,80}}, color={0,127,255}));
      connect(TsetW.y, preOut.TSet) annotation (Line(points={{139,85},{139,88},
              {122,88}}, color={0,0,127}));
      connect(rad_1.heatPortCon, heatPortCon[1]) annotation (Line(points={{-77.2,
              12},{-182,12},{-182,20},{-200,20},{-200,16}},
                                              color={191,0,0}));
      connect(rad_1.heatPortRad, heatPortRad[1]) annotation (Line(points={{-77.2,8},
              {-178,8},{-178,-20},{-200,-20},{-200,-24}},
                                               color={191,0,0}));
      connect(rad_2.heatPortCon, heatPortCon[2]) annotation (Line(points={{-37.2,
              12},{-46,12},{-46,-6},{-182,-6},{-182,20},{-200,20},{-200,18}},
                                                                color={191,0,0}));
      connect(rad_2.heatPortRad, heatPortRad[2]) annotation (Line(points={{-37.2,8},
              {-44,8},{-44,-8},{-178,-8},{-178,-20},{-200,-20},{-200,-22}},
                                                                 color={191,0,0}));
      connect(rad_1.port_b, jun1.port_1) annotation (Line(points={{-70,
              3.55271e-15},{-70,-20},{-40,-20}},
                                    color={0,127,255}));
      connect(booToRea[1].y, val1.y) annotation (Line(points={{29,40},{0,40},{0,
              60},{-88,60},{-88,40},{-82,40}},color={0,0,127}));
      connect(booToRea[2].y, val2.y) annotation (Line(points={{29,40},{0,40},{0,60},
              {-50,60},{-50,40},{-42,40}}, color={0,0,127}));
      connect(bou.ports[1], preOut.port_b) annotation (Line(points={{100,10},{100,64},
              {94,64},{94,80},{100,80}}, color={0,127,255}));
      connect(jun1.port_2, senTem.port_a)
        annotation (Line(points={{-20,-20},{20,-20}}, color={0,127,255}));
      connect(senTem.port_b, preOut.port_a) annotation (Line(points={{40,-20},{126,-20},
              {126,80},{120,80}}, color={0,127,255}));
      connect(mflow.y, fan.m_flow_in)
        annotation (Line(points={{79,111},{50,111},{50,92}}, color={0,0,127}));
      connect(TSetCool,gain1. u) annotation (Line(points={{-20,-104},{-20,-80},
              {172.8,-80}},                     color={0,0,127}));
      connect(gain1.y,CoolingPower)
        annotation (Line(points={{186.6,-80},{192,-80},{192,-36},{190,-36},{190,
              -20},{206,-20}},                           color={0,0,127}));
      connect(Qcon_data.y, HeatingCon.Q_flow)
        annotation (Line(points={{-131,80},{-150,80}}, color={0,0,127}));
      connect(Qrad_data.y, HeatingRad.Q_flow)
        annotation (Line(points={{-131,60},{-150,60}}, color={0,0,127}));
      connect(HeatingCon[1].port, heatPortCon[3]) annotation (Line(points={{
              -170,80},{-182,80},{-182,20},{-200,20}}, color={191,0,0}));
      connect(HeatingCon[2].port, heatPortCon[4]) annotation (Line(points={{
              -170,80},{-182,80},{-182,20},{-200,20},{-200,22}}, color={191,0,0}));
      connect(HeatingCon[3].port, heatPortCon[5]) annotation (Line(points={{
              -170,80},{-182,80},{-182,20},{-200,20},{-200,24}}, color={191,0,0}));
      connect(HeatingRad[1].port, heatPortRad[3]) annotation (Line(points={{
              -170,60},{-178,60},{-178,-20},{-200,-20}}, color={191,0,0}));
      connect(HeatingRad[2].port, heatPortRad[4]) annotation (Line(points={{
              -170,60},{-178,60},{-178,-20},{-200,-20},{-200,-18}}, color={191,
              0,0}));
      connect(HeatingRad[3].port, heatPortRad[5]) annotation (Line(points={{
              -170,60},{-178,60},{-178,-20},{-200,-20},{-200,-16}}, color={191,
              0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
                {200,100}}), graphics={
            Rectangle(
              extent={{-200,100},{200,-100}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={191,0,0}),
            Text(
              extent={{-60,88},{60,48}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              fontName="Times New Roman",
              horizontalAlignment=TextAlignment.Left,
              textString="HEATING"),
            Rectangle(
              extent={{-120,40},{-140,-40}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-90,0},{-90,40},{-120,20},{-90,0}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-90,-40},{-90,0},{-120,-20},{-90,-40}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,20},{-90,20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{0,-20},{-90,-20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{20,0},{0,-20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{20,0},{0,20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{140,0},{20,0}},
              color={191,0,0},
              thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-200,-100},{200,100}})));
    end RadiatorHeating2;

    model RadiatorHeating5

      parameter Integer nZones(min=1) = 5 "Number of conditioned thermal zones in the building";
      //replaceable package Medium=IDEAS.Media.Water;
      parameter Real dTHys=2 "Temperature difference for hysteresis controller";

    public
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortCon
        "Nodes for convective heat gains"
        annotation (Placement(transformation(extent={{-210,10},{-190,30}}),
            iconTransformation(extent={{-210,10},{-190,30}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortRad
        "Nodes for radiative heat gains"
        annotation (Placement(transformation(extent={{-210,-30},{-190,-10}}),
            iconTransformation(extent={{-210,-30},{-190,-10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[nZones] heatPortEmb
        "Construction nodes for heat gains by embedded layers"
        annotation (Placement(transformation(extent={{-210,50},{-190,70}}),
            iconTransformation(extent={{-210,50},{-190,70}})));
      Modelica.Blocks.Interfaces.RealInput[nZones] TSensor(
        final quantity="ThermodynamicTemperature",
        unit="degC",
        displayUnit="degC",
        min=0) "Sensor temperature" annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-204,-60}), iconTransformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-200,-60})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin[nZones] toKelvin
        annotation (Placement(transformation(extent={{-160,-70},{-140,-50}})));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_1(
        redeclare package Medium = IDEAS.Media.Water,
        Q_flow_nominal=800,
        T_a_nominal=353.15,
        T_b_nominal=333.15,
        dp_nominal=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={-150,10})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin[nZones] toKelvin2
        annotation (Placement(transformation(extent={{-6,-6},{6,6}},
            rotation=90,
            origin={20,-80})));
      Modelica.Blocks.Interfaces.RealInput[nZones] TSetHeat(
        final quantity="ThermodynamicTemperature",
        unit="degC",
        displayUnit="degC",
        min=0) "Setpoint temperature heating for the zones" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,-104}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,-104})));
      IDEAS.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
            IDEAS.Media.Water, m_flow_nominal=0.05)
        annotation (Placement(transformation(extent={{120,70},{100,90}})));
      IDEAS.Fluid.Actuators.Valves.TwoWayQuickOpening val1(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal=0.01,
        dpValve_nominal=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-150,40})));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_2(
        redeclare package Medium = IDEAS.Media.Water,
        Q_flow_nominal=800,
        T_a_nominal=353.15,
        T_b_nominal=333.15,
        dp_nominal=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={-110,10})));
      IDEAS.Fluid.Actuators.Valves.TwoWayQuickOpening val2(redeclare package
          Medium =
            IDEAS.Media.Water,
        m_flow_nominal=0.01,
        dpValve_nominal=1)     annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-110,40})));
      IDEAS.Fluid.FixedResistances.Junction jun(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={0.2,-0.1,-0.1},
        dp_nominal={1,0,0})
        annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
      IDEAS.Fluid.HeatExchangers.PrescribedOutlet preOut(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal=0.05,
        dp_nominal=1,
        use_X_wSet=false)
        annotation (Placement(transformation(extent={{180,70},{160,90}})));
      Modelica.Blocks.Sources.RealExpression TsetW(each y=273.15 + 80)
        annotation (Placement(transformation(extent={{210,80},{190,94}})));
      IDEAS.Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={0.01,-0.02,0.01},
        dp_nominal={1,0,1})
        annotation (Placement(transformation(extent={{-120,-10},{-100,-30}})));
      IDEAS.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
            IDEAS.Media.Water, nPorts=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={150,50})));
      IDEAS.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            IDEAS.Media.Water, m_flow_nominal=0.01)
        annotation (Placement(transformation(extent={{140,-30},{160,-10}})));
      Modelica.Blocks.Sources.RealExpression mflow(each y=0.05)
        annotation (Placement(transformation(extent={{150,90},{130,104}})));
      Modelica.Blocks.Interfaces.RealInput[nZones] TSetCool(
        final quantity="ThermodynamicTemperature",
        unit="degC",
        displayUnit="degC",
        min=0) "Setpoint temperature cooling for the zones"
                                                    annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-20,-104}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-20,-100})));
      Modelica.Blocks.Interfaces.RealOutput CoolingPower[nZones](
        final quantity="Power",
        unit="W",
        displayUnit="W",
        min=0) annotation (Placement(transformation(extent={{196,-30},{216,-10}}),
            iconTransformation(
            extent={{8,-8},{-8,8}},
            rotation=180,
            origin={200,-20})));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_3(
        redeclare package Medium = IDEAS.Media.Water,
        Q_flow_nominal=300,
        T_a_nominal=353.15,
        T_b_nominal=333.15,
        dp_nominal=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={-70,10})));
      IDEAS.Fluid.Actuators.Valves.TwoWayQuickOpening val3(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal=0.01,
        dpValve_nominal=1)     annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-70,40})));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_4(
        redeclare package Medium = IDEAS.Media.Water,
        Q_flow_nominal=400,
        T_a_nominal=353.15,
        T_b_nominal=333.15,
        dp_nominal=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={-30,10})));
      IDEAS.Fluid.Actuators.Valves.TwoWayQuickOpening val4(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal=0.01,
        dpValve_nominal=1)     annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-30,40})));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_5(
        redeclare package Medium = IDEAS.Media.Water,
        Q_flow_nominal=800,
        T_a_nominal=353.15,
        T_b_nominal=333.15,
        dp_nominal=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={10,10})));
      IDEAS.Fluid.Actuators.Valves.TwoWayQuickOpening val5(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal=0.01,
        dpValve_nominal=1)     annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={10,40})));
      IDEAS.Fluid.FixedResistances.Junction jun2(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={0.03,-0.02,-0.01},
        dp_nominal={1,0,0})
        annotation (Placement(transformation(extent={{-60,70},{-80,90}})));
      IDEAS.Fluid.FixedResistances.Junction jun3(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={0.04,-0.03,-0.01},
        dp_nominal={1,0,0})
        annotation (Placement(transformation(extent={{-20,70},{-40,90}})));
      IDEAS.Fluid.FixedResistances.Junction jun4(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={0.05,-0.04,-0.01},
        dp_nominal={1,0,0})
        annotation (Placement(transformation(extent={{20,70},{0,90}})));
      IDEAS.Fluid.FixedResistances.Junction jun5(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={0.02,-0.03,0.01},
        dp_nominal={1,0,1})
        annotation (Placement(transformation(extent={{-80,-10},{-60,-30}})));
      IDEAS.Fluid.FixedResistances.Junction jun6(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={0.03,-0.04,0.01},
        dp_nominal={1,0,1})
        annotation (Placement(transformation(extent={{-40,-10},{-20,-30}})));
      IDEAS.Fluid.FixedResistances.Junction jun7(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={0.04,-0.05,0.01},
        dp_nominal={1,0,1})
        annotation (Placement(transformation(extent={{0,-10},{20,-30}})));
    protected
      Modelica.Blocks.Logical.Hysteresis[nZones] hys(
        each uLow=0,
        each uHigh=dTHys,
        each pre_y_start=false)
        "Hysteresis controller to avoid chattering"
        annotation (Placement(transformation(extent={{110,28},{90,48}})));
      Modelica.Blocks.Math.Add[nZones] add(each final k1=-1, each final k2=1)
                                           annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,-50})));
      Modelica.Blocks.Math.BooleanToReal[nZones] booToRea(realTrue=0, realFalse=
           0)                                             "Boolean to real conversion"
        annotation (Placement(transformation(extent={{70,28},{50,48}})));
      Modelica.Blocks.Math.Gain[nZones] gain1(final k=0)   "Nominal heat gain"
        annotation (Placement(transformation(extent={{174,-80},{186,-68}})));
    equation
      connect(TSensor,toKelvin. Celsius)
        annotation (Line(points={{-204,-60},{-162,-60}}, color={0,0,127}));
      connect(TSetHeat,toKelvin2. Celsius)
        annotation (Line(points={{20,-104},{20,-87.2}}, color={0,0,127}));
      connect(add.y,hys. u)
        annotation (Line(points={{20,-39},{20,-36},{120,-36},{120,38},{112,38}},
                                                           color={0,0,127}));
      connect(hys.y,booToRea. u) annotation (Line(points={{89,38},{72,38}},
                   color={255,0,255}));
      connect(toKelvin2.Kelvin, add.u2) annotation (Line(points={{20,-73.4},{20,-70},
              {26,-70},{26,-62}}, color={0,0,127}));
      connect(toKelvin.Kelvin, add.u1) annotation (Line(points={{-139,-60},{2,-60},{
              2,-70},{14,-70},{14,-62}}, color={0,0,127}));
      connect(val1.port_a, rad_1.port_a)
        annotation (Line(points={{-150,30},{-150,20}},
                                                     color={0,127,255}));
      connect(val2.port_a, rad_2.port_a)
        annotation (Line(points={{-110,30},{-110,20}},
                                                     color={0,127,255}));
      connect(jun.port_2, val1.port_b)
        annotation (Line(points={{-120,80},{-150,80},{-150,50}},
                                                              color={0,127,255}));
      connect(jun.port_3, val2.port_b)
        annotation (Line(points={{-110,70},{-110,50}},
                                                     color={0,127,255}));
      connect(rad_2.port_b, jun1.port_3)
        annotation (Line(points={{-110,3.55271e-15},{-110,-10}},
                                                               color={0,127,255}));
      connect(preOut.port_b, fan.port_a)
        annotation (Line(points={{160,80},{120,80}},color={0,127,255}));
      connect(TsetW.y, preOut.TSet) annotation (Line(points={{189,87},{185.5,87},
              {185.5,88},{182,88}}, color={0,0,127}));
      connect(rad_1.heatPortCon, heatPortCon[1]) annotation (Line(points={{-157.2,
              12},{-182,12},{-182,20},{-200,20},{-200,16}},
                                              color={191,0,0}));
      connect(rad_1.heatPortRad, heatPortRad[1]) annotation (Line(points={{-157.2,
              8},{-184,8},{-184,-20},{-200,-20},{-200,-24}},
                                               color={191,0,0}));
      connect(rad_2.heatPortCon, heatPortCon[2]) annotation (Line(points={{-117.2,
              12},{-126,12},{-126,24},{-182,24},{-182,20},{-200,20},{-200,18}},
                                                                color={191,0,0}));
      connect(rad_2.heatPortRad, heatPortRad[2]) annotation (Line(points={{-117.2,
              8},{-126,8},{-126,-4},{-184,-4},{-184,-20},{-200,-20},{-200,-22}},
                                                                 color={191,0,0}));
      connect(rad_1.port_b, jun1.port_1) annotation (Line(points={{-150,
              3.55271e-15},{-150,-20},{-120,-20}},
                                    color={0,127,255}));
      connect(booToRea[1].y, val1.y) annotation (Line(points={{49,38},{40,38},{
              40,60},{-168,60},{-168,40},{-162,40}},
                                              color={0,0,127}));
      connect(booToRea[2].y, val2.y) annotation (Line(points={{49,38},{40,38},{
              40,60},{-128,60},{-128,40},{-122,40}},
                                           color={0,0,127}));
      connect(bou.ports[1], preOut.port_b) annotation (Line(points={{150,60},{
              150,80},{160,80}},         color={0,127,255}));
      connect(senTem.port_b, preOut.port_a) annotation (Line(points={{160,-20},
              {180,-20},{180,80}},color={0,127,255}));
      connect(mflow.y, fan.m_flow_in) annotation (Line(points={{129,97},{110,97},
              {110,92}}, color={0,0,127}));
      connect(TSetCool,gain1. u) annotation (Line(points={{-20,-104},{-20,-80},
              {160,-80},{160,-74},{172.8,-74}}, color={0,0,127}));
      connect(gain1.y,CoolingPower)
        annotation (Line(points={{186.6,-74},{192,-74},{192,-36},{190,-36},{190,
              -20},{206,-20}},                           color={0,0,127}));
      connect(jun2.port_2, jun.port_1)
        annotation (Line(points={{-80,80},{-100,80}}, color={0,127,255}));
      connect(jun3.port_2, jun2.port_1)
        annotation (Line(points={{-40,80},{-60,80}}, color={0,127,255}));
      connect(jun4.port_2, jun3.port_1)
        annotation (Line(points={{0,80},{-20,80}}, color={0,127,255}));
      connect(jun2.port_3, val3.port_b)
        annotation (Line(points={{-70,70},{-70,50}}, color={0,127,255}));
      connect(jun3.port_3, val4.port_b)
        annotation (Line(points={{-30,70},{-30,50}}, color={0,127,255}));
      connect(jun4.port_3, val5.port_b)
        annotation (Line(points={{10,70},{10,50}}, color={0,127,255}));
      connect(fan.port_b, jun4.port_1)
        annotation (Line(points={{100,80},{20,80}}, color={0,127,255}));
      connect(val3.port_a, rad_3.port_a)
        annotation (Line(points={{-70,30},{-70,20}}, color={0,127,255}));
      connect(rad_3.port_b, jun5.port_3) annotation (Line(points={{-70,
              3.55271e-15},{-70,-10}}, color={0,127,255}));
      connect(val4.port_a, rad_4.port_a)
        annotation (Line(points={{-30,30},{-30,20}}, color={0,127,255}));
      connect(rad_4.port_b, jun6.port_3) annotation (Line(points={{-30,
              3.55271e-15},{-30,-10}}, color={0,127,255}));
      connect(val5.port_a, rad_5.port_a) annotation (Line(points={{10,30},{10,
              25},{10,25},{10,20}}, color={0,127,255}));
      connect(jun1.port_2, jun5.port_1)
        annotation (Line(points={{-100,-20},{-80,-20}}, color={0,127,255}));
      connect(jun5.port_2, jun6.port_1)
        annotation (Line(points={{-60,-20},{-40,-20}}, color={0,127,255}));
      connect(jun6.port_2, jun7.port_1)
        annotation (Line(points={{-20,-20},{0,-20}}, color={0,127,255}));
      connect(rad_5.port_b, jun7.port_3) annotation (Line(points={{10,
              3.55271e-15},{10,-5},{10,-5},{10,-10}}, color={0,127,255}));
      connect(jun7.port_2, senTem.port_a)
        annotation (Line(points={{20,-20},{140,-20}}, color={0,127,255}));
      connect(rad_3.heatPortCon, heatPortCon[3]) annotation (Line(points={{
              -77.2,12},{-86,12},{-86,24},{-182,24},{-182,20},{-200,20}}, color=
             {191,0,0}));
      connect(rad_4.heatPortCon, heatPortCon[4]) annotation (Line(points={{
              -37.2,12},{-46,12},{-46,24},{-182,24},{-182,20},{-200,20},{-200,
              22}}, color={191,0,0}));
      connect(rad_5.heatPortCon, heatPortCon[5]) annotation (Line(points={{2.8,
              12},{-4,12},{-4,24},{-182,24},{-182,20},{-200,20},{-200,24}},
            color={191,0,0}));
      connect(rad_3.heatPortRad, heatPortRad[3]) annotation (Line(points={{
              -77.2,8},{-86,8},{-86,-4},{-184,-4},{-184,-20},{-200,-20}}, color=
             {191,0,0}));
      connect(rad_4.heatPortRad, heatPortRad[4]) annotation (Line(points={{
              -37.2,8},{-46,8},{-46,-4},{-184,-4},{-184,-20},{-200,-20},{-200,
              -18}}, color={191,0,0}));
      connect(rad_5.heatPortRad, heatPortRad[5]) annotation (Line(points={{2.8,
              8},{-4,8},{-4,-4},{-184,-4},{-184,-20},{-200,-20},{-200,-16}},
            color={191,0,0}));
      connect(booToRea[3].y, val3.y) annotation (Line(points={{49,38},{40,38},{
              40,60},{-88,60},{-88,40},{-82,40}}, color={0,0,127}));
      connect(booToRea[4].y, val4.y) annotation (Line(points={{49,38},{40,38},{
              40,60},{-48,60},{-48,40},{-42,40}}, color={0,0,127}));
      connect(booToRea[5].y, val5.y) annotation (Line(points={{49,38},{40,38},{
              40,60},{-8,60},{-8,40},{-2,40}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
                {200,100}}), graphics={
            Rectangle(
              extent={{-200,100},{200,-100}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={191,0,0}),
            Text(
              extent={{-60,88},{60,48}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              fontName="Times New Roman",
              horizontalAlignment=TextAlignment.Left,
              textString="HEATING"),
            Rectangle(
              extent={{-120,40},{-140,-40}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-90,0},{-90,40},{-120,20},{-90,0}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-90,-40},{-90,0},{-120,-20},{-90,-40}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,20},{-90,20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{0,-20},{-90,-20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{20,0},{0,-20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{20,0},{0,20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{140,0},{20,0}},
              color={191,0,0},
              thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-200,-100},{200,100}})),
        experiment(
          StopTime=31536000,
          Interval=599.999616,
          __Dymola_Algorithm="Cvode"),
        __Dymola_experimentSetupOutput(events=false));
    end RadiatorHeating5;

    model RadiatorHeating5b

      parameter Integer nZones(min=1) = 5 "Number of conditioned thermal zones in the building";
      //replaceable package Medium=IDEAS.Media.Water;
      parameter Real dTHys=2 "Temperature difference for hysteresis controller";

    public
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortCon
        "Nodes for convective heat gains"
        annotation (Placement(transformation(extent={{-210,10},{-190,30}}),
            iconTransformation(extent={{-210,10},{-190,30}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortRad
        "Nodes for radiative heat gains"
        annotation (Placement(transformation(extent={{-210,-30},{-190,-10}}),
            iconTransformation(extent={{-210,-30},{-190,-10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[nZones] heatPortEmb
        "Construction nodes for heat gains by embedded layers"
        annotation (Placement(transformation(extent={{-210,50},{-190,70}}),
            iconTransformation(extent={{-210,50},{-190,70}})));
      Modelica.Blocks.Interfaces.RealInput[nZones] TSensor(
        final quantity="ThermodynamicTemperature",
        unit="degC",
        displayUnit="degC",
        min=0) "Sensor temperature" annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-204,-60}), iconTransformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-200,-60})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin[nZones] toKelvin
        annotation (Placement(transformation(extent={{-160,-70},{-140,-50}})));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_1(
        redeclare package Medium = IDEAS.Media.Water,
        Q_flow_nominal=800,
        T_a_nominal=353.15,
        T_b_nominal=333.15,
        dp_nominal=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={-150,10})));
      Modelica.Blocks.Interfaces.RealInput[nZones] TSetHeat(
        final quantity="ThermodynamicTemperature",
        unit="degC",
        displayUnit="degC",
        min=0) "Setpoint temperature heating for the zones" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,-104}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,-104})));
      IDEAS.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
            IDEAS.Media.Water, m_flow_nominal=0.05)
        annotation (Placement(transformation(extent={{120,70},{100,90}})));
      IDEAS.Fluid.Actuators.Valves.TwoWayTRV          val1(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal=0.01,
        dpValve_nominal=1,
        TSet=293.15)       annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-150,40})));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_2(
        redeclare package Medium = IDEAS.Media.Water,
        Q_flow_nominal=800,
        T_a_nominal=353.15,
        T_b_nominal=333.15,
        dp_nominal=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={-110,10})));
      IDEAS.Fluid.Actuators.Valves.TwoWayTRV          val2(redeclare package
          Medium =
            IDEAS.Media.Water,
        m_flow_nominal=0.01,
        dpValve_nominal=1,
        TSet=293.15)           annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-110,40})));
      IDEAS.Fluid.FixedResistances.Junction jun(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={0.2,-0.1,-0.1},
        dp_nominal={1,0,0})
        annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
      IDEAS.Fluid.HeatExchangers.PrescribedOutlet preOut(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal=0.05,
        dp_nominal=1,
        use_X_wSet=false)
        annotation (Placement(transformation(extent={{180,70},{160,90}})));
      Modelica.Blocks.Sources.RealExpression TsetW(each y=273.15 + 80)
        annotation (Placement(transformation(extent={{210,80},{190,94}})));
      IDEAS.Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={0.01,-0.02,0.01},
        dp_nominal={1,0,1})
        annotation (Placement(transformation(extent={{-120,-10},{-100,-30}})));
      IDEAS.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
            IDEAS.Media.Water, nPorts=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={150,50})));
      IDEAS.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            IDEAS.Media.Water, m_flow_nominal=0.01)
        annotation (Placement(transformation(extent={{140,-30},{160,-10}})));
      Modelica.Blocks.Sources.RealExpression mflow(each y=0.025)
        annotation (Placement(transformation(extent={{150,90},{130,104}})));
      Modelica.Blocks.Interfaces.RealInput[nZones] TSetCool(
        final quantity="ThermodynamicTemperature",
        unit="degC",
        displayUnit="degC",
        min=0) "Setpoint temperature cooling for the zones"
                                                    annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-20,-104}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-20,-100})));
      Modelica.Blocks.Interfaces.RealOutput CoolingPower[nZones](
        final quantity="Power",
        unit="W",
        displayUnit="W",
        min=0) annotation (Placement(transformation(extent={{196,-30},{216,-10}}),
            iconTransformation(
            extent={{8,-8},{-8,8}},
            rotation=180,
            origin={200,-20})));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_3(
        redeclare package Medium = IDEAS.Media.Water,
        Q_flow_nominal=300,
        T_a_nominal=353.15,
        T_b_nominal=333.15,
        dp_nominal=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={-70,10})));
      IDEAS.Fluid.Actuators.Valves.TwoWayTRV          val3(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal=0.01,
        dpValve_nominal=1,
        TSet=293.15)           annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-70,40})));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_4(
        redeclare package Medium = IDEAS.Media.Water,
        Q_flow_nominal=400,
        T_a_nominal=353.15,
        T_b_nominal=333.15,
        dp_nominal=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={-30,10})));
      IDEAS.Fluid.Actuators.Valves.TwoWayTRV          val4(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal=0.01,
        dpValve_nominal=1,
        TSet=293.15)           annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-30,40})));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad_5(
        redeclare package Medium = IDEAS.Media.Water,
        Q_flow_nominal=800,
        T_a_nominal=353.15,
        T_b_nominal=333.15,
        dp_nominal=1) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={10,10})));
      IDEAS.Fluid.Actuators.Valves.TwoWayTRV          val5(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal=0.01,
        dpValve_nominal=1,
        TSet=293.15)           annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={10,40})));
      IDEAS.Fluid.FixedResistances.Junction jun2(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={0.03,-0.02,-0.01},
        dp_nominal={1,0,0})
        annotation (Placement(transformation(extent={{-60,70},{-80,90}})));
      IDEAS.Fluid.FixedResistances.Junction jun3(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={0.04,-0.03,-0.01},
        dp_nominal={1,0,0})
        annotation (Placement(transformation(extent={{-20,70},{-40,90}})));
      IDEAS.Fluid.FixedResistances.Junction jun4(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={0.05,-0.04,-0.01},
        dp_nominal={1,0,0})
        annotation (Placement(transformation(extent={{20,70},{0,90}})));
      IDEAS.Fluid.FixedResistances.Junction jun5(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={0.02,-0.03,0.01},
        dp_nominal={1,0,1})
        annotation (Placement(transformation(extent={{-80,-10},{-60,-30}})));
      IDEAS.Fluid.FixedResistances.Junction jun6(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={0.03,-0.04,0.01},
        dp_nominal={1,0,1})
        annotation (Placement(transformation(extent={{-40,-10},{-20,-30}})));
      IDEAS.Fluid.FixedResistances.Junction jun7(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal={0.04,-0.05,0.01},
        dp_nominal={1,0,1})
        annotation (Placement(transformation(extent={{0,-10},{20,-30}})));
      Modelica.Blocks.Interfaces.RealOutput HeatingPower[nZones](
        final quantity="Power",
        unit="W",
        displayUnit="W",
        min=0) annotation (Placement(transformation(extent={{196,10},{216,30}}),
            iconTransformation(
            extent={{8,-8},{-8,8}},
            rotation=180,
            origin={208,38})));
    protected
      Modelica.Blocks.Math.Gain[nZones] gain1(final k=0)   "Nominal heat gain"
        annotation (Placement(transformation(extent={{174,-76},{186,-64}})));
      Modelica.Blocks.Math.Gain[nZones] gain2(final k=0)   "Nominal heat gain"
        annotation (Placement(transformation(extent={{174,-56},{186,-44}})));
    equation
      connect(TSensor,toKelvin. Celsius)
        annotation (Line(points={{-204,-60},{-162,-60}}, color={0,0,127}));
      connect(val1.port_a, rad_1.port_a)
        annotation (Line(points={{-150,30},{-150,20}},
                                                     color={0,127,255}));
      connect(val2.port_a, rad_2.port_a)
        annotation (Line(points={{-110,30},{-110,20}},
                                                     color={0,127,255}));
      connect(jun.port_2, val1.port_b)
        annotation (Line(points={{-120,80},{-150,80},{-150,50}},
                                                              color={0,127,255}));
      connect(jun.port_3, val2.port_b)
        annotation (Line(points={{-110,70},{-110,50}},
                                                     color={0,127,255}));
      connect(rad_2.port_b, jun1.port_3)
        annotation (Line(points={{-110,3.55271e-15},{-110,-10}},
                                                               color={0,127,255}));
      connect(preOut.port_b, fan.port_a)
        annotation (Line(points={{160,80},{120,80}},color={0,127,255}));
      connect(TsetW.y, preOut.TSet) annotation (Line(points={{189,87},{185.5,87},
              {185.5,88},{182,88}}, color={0,0,127}));
      connect(rad_1.heatPortCon, heatPortCon[1]) annotation (Line(points={{-157.2,
              12},{-182,12},{-182,20},{-200,20},{-200,16}},
                                              color={191,0,0}));
      connect(rad_1.heatPortRad, heatPortRad[1]) annotation (Line(points={{-157.2,
              8},{-184,8},{-184,-20},{-200,-20},{-200,-24}},
                                               color={191,0,0}));
      connect(rad_2.heatPortCon, heatPortCon[2]) annotation (Line(points={{-117.2,
              12},{-126,12},{-126,24},{-182,24},{-182,20},{-200,20},{-200,18}},
                                                                color={191,0,0}));
      connect(rad_2.heatPortRad, heatPortRad[2]) annotation (Line(points={{-117.2,
              8},{-126,8},{-126,-4},{-184,-4},{-184,-20},{-200,-20},{-200,-22}},
                                                                 color={191,0,0}));
      connect(rad_1.port_b, jun1.port_1) annotation (Line(points={{-150,
              3.55271e-15},{-150,-20},{-120,-20}},
                                    color={0,127,255}));
      connect(bou.ports[1], preOut.port_b) annotation (Line(points={{150,60},{
              150,80},{160,80}},         color={0,127,255}));
      connect(senTem.port_b, preOut.port_a) annotation (Line(points={{160,-20},
              {180,-20},{180,80}},color={0,127,255}));
      connect(mflow.y, fan.m_flow_in) annotation (Line(points={{129,97},{110,97},
              {110,92}}, color={0,0,127}));
      connect(TSetCool,gain1. u) annotation (Line(points={{-20,-104},{-20,-80},
              {160,-80},{160,-70},{172.8,-70}}, color={0,0,127}));
      connect(gain1.y,CoolingPower)
        annotation (Line(points={{186.6,-70},{192,-70},{192,-36},{190,-36},{190,
              -20},{206,-20}},                           color={0,0,127}));
      connect(jun2.port_2, jun.port_1)
        annotation (Line(points={{-80,80},{-100,80}}, color={0,127,255}));
      connect(jun3.port_2, jun2.port_1)
        annotation (Line(points={{-40,80},{-60,80}}, color={0,127,255}));
      connect(jun4.port_2, jun3.port_1)
        annotation (Line(points={{0,80},{-20,80}}, color={0,127,255}));
      connect(jun2.port_3, val3.port_b)
        annotation (Line(points={{-70,70},{-70,50}}, color={0,127,255}));
      connect(jun3.port_3, val4.port_b)
        annotation (Line(points={{-30,70},{-30,50}}, color={0,127,255}));
      connect(jun4.port_3, val5.port_b)
        annotation (Line(points={{10,70},{10,50}}, color={0,127,255}));
      connect(fan.port_b, jun4.port_1)
        annotation (Line(points={{100,80},{20,80}}, color={0,127,255}));
      connect(val3.port_a, rad_3.port_a)
        annotation (Line(points={{-70,30},{-70,20}}, color={0,127,255}));
      connect(rad_3.port_b, jun5.port_3) annotation (Line(points={{-70,
              3.55271e-15},{-70,-10}}, color={0,127,255}));
      connect(val4.port_a, rad_4.port_a)
        annotation (Line(points={{-30,30},{-30,20}}, color={0,127,255}));
      connect(rad_4.port_b, jun6.port_3) annotation (Line(points={{-30,
              3.55271e-15},{-30,-10}}, color={0,127,255}));
      connect(val5.port_a, rad_5.port_a) annotation (Line(points={{10,30},{10,
              25},{10,25},{10,20}}, color={0,127,255}));
      connect(jun1.port_2, jun5.port_1)
        annotation (Line(points={{-100,-20},{-80,-20}}, color={0,127,255}));
      connect(jun5.port_2, jun6.port_1)
        annotation (Line(points={{-60,-20},{-40,-20}}, color={0,127,255}));
      connect(jun6.port_2, jun7.port_1)
        annotation (Line(points={{-20,-20},{0,-20}}, color={0,127,255}));
      connect(rad_5.port_b, jun7.port_3) annotation (Line(points={{10,
              3.55271e-15},{10,-5},{10,-5},{10,-10}}, color={0,127,255}));
      connect(jun7.port_2, senTem.port_a)
        annotation (Line(points={{20,-20},{140,-20}}, color={0,127,255}));
      connect(rad_3.heatPortCon, heatPortCon[3]) annotation (Line(points={{
              -77.2,12},{-86,12},{-86,24},{-182,24},{-182,20},{-200,20}}, color=
             {191,0,0}));
      connect(rad_4.heatPortCon, heatPortCon[4]) annotation (Line(points={{
              -37.2,12},{-46,12},{-46,24},{-182,24},{-182,20},{-200,20},{-200,
              22}}, color={191,0,0}));
      connect(rad_5.heatPortCon, heatPortCon[5]) annotation (Line(points={{2.8,
              12},{-4,12},{-4,24},{-182,24},{-182,20},{-200,20},{-200,24}},
            color={191,0,0}));
      connect(rad_3.heatPortRad, heatPortRad[3]) annotation (Line(points={{
              -77.2,8},{-86,8},{-86,-4},{-184,-4},{-184,-20},{-200,-20}}, color=
             {191,0,0}));
      connect(rad_4.heatPortRad, heatPortRad[4]) annotation (Line(points={{
              -37.2,8},{-46,8},{-46,-4},{-184,-4},{-184,-20},{-200,-20},{-200,
              -18}}, color={191,0,0}));
      connect(rad_5.heatPortRad, heatPortRad[5]) annotation (Line(points={{2.8,
              8},{-4,8},{-4,-4},{-184,-4},{-184,-20},{-200,-20},{-200,-16}},
            color={191,0,0}));
      connect(TSetHeat, gain2.u) annotation (Line(points={{20,-104},{20,-50},{
              172.8,-50}}, color={0,0,127}));
      connect(gain2.y, HeatingPower) annotation (Line(points={{186.6,-50},{190,
              -50},{190,-38},{188,-38},{188,20},{206,20}}, color={0,0,127}));
      connect(toKelvin[1].Kelvin, val1.T) annotation (Line(points={{-139,-60},{
              -134,-60},{-134,24},{-166,24},{-166,40},{-160.6,40}}, color={0,0,
              127}));
      connect(toKelvin[2].Kelvin, val2.T) annotation (Line(points={{-139,-60},{
              -134,-60},{-134,40},{-120.6,40}}, color={0,0,127}));
      connect(toKelvin[3].Kelvin, val3.T) annotation (Line(points={{-139,-60},{
              -134,-60},{-134,26},{-86,26},{-86,40},{-80.6,40}}, color={0,0,127}));
      connect(toKelvin[4].Kelvin, val4.T) annotation (Line(points={{-139,-60},{
              -134,-60},{-134,26},{-46,26},{-46,40},{-40.6,40}}, color={0,0,127}));
      connect(toKelvin[5].Kelvin, val5.T) annotation (Line(points={{-139,-60},{
              -134,-60},{-134,26},{-6,26},{-6,40},{-0.6,40}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
                {200,100}}), graphics={
            Rectangle(
              extent={{-200,100},{200,-100}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={191,0,0}),
            Text(
              extent={{-60,88},{60,48}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              fontName="Times New Roman",
              horizontalAlignment=TextAlignment.Left,
              textString="HEATING"),
            Rectangle(
              extent={{-120,40},{-140,-40}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-90,0},{-90,40},{-120,20},{-90,0}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-90,-40},{-90,0},{-120,-20},{-90,-40}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,20},{-90,20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{0,-20},{-90,-20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{20,0},{0,-20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{20,0},{0,20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{140,0},{20,0}},
              color={191,0,0},
              thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-200,-100},{200,100}})),
        experiment(
          StopTime=31536000,
          Interval=599.999616,
          __Dymola_Algorithm="Cvode"),
        __Dymola_experimentSetupOutput(events=false));
    end RadiatorHeating5b;
    annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}})), Icon(
          coordinateSystem(extent={{-200,-100},{200,100}})));
  end Heating;

  package Ventilation
    model Ventilation

      replaceable package MediumAir = IDEAS.Media.Air (extraPropertiesNames={"CO2"});

      // Weather Data ---------------------------------------------------------------------------------------------------------------------------------------------------------
      //MVH added inner
      // Building characteristics ---------------------------------------------------------------------------------------------------------------------------------------------
      parameter Integer nZones(min=1) = nZones "Number of conditioned thermal zones in the building";
      parameter Modelica.Units.SI.Efficiency recupEff(min=0, max=1) = 0.00 "Efficiency of heat recuperation";

      // Ventilation characteristics ------------------------------------------------------------------------------------------------------------------------------------------
      Modelica.Blocks.Interfaces.RealInput m_sup[nZones](
        final quantity="VolumeFlowRate",
        unit="m3/h",
        displayUnit="m3/h",
        min=0)
        "Ventilation supply flow[m3/h]"
                                  annotation (
          Placement(transformation(extent={{214,40},
                {194,60}}),iconTransformation(
              extent={{-208,10},{-188,30}})));
      Modelica.Blocks.Interfaces.RealInput m_ex[nZones](
        final quantity="VolumeFlowRate",
        unit="m3/h",
        displayUnit="m3/h",
        min=0)
        "Ventilation exhaust flow" annotation (
          Placement(transformation(extent={{214,-60},{
                194,-40}}), iconTransformation(
              extent={{-208,-30},{-188,-10}})));

      //Zones:
      //       1  -> Kitchen_DiningRoom
      //       2  -> LivingRoom
      //       3  -> Bedroom1
      //       4  -> Bathroom
      //       5  -> Technics
      //       6  -> Entrance
      //       7  -> Corridor
      //       8  -> MeterCupboard
      //       9  -> Restroom
      //       10 -> Bedroom2
      IDEAS.Fluid.Movers.FlowControlled_m_flow pump[nZones](
        redeclare each package Medium = MediumAir, addPowerToMedium = false, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = 1. / 3600. * 1.204, nominalValuesDefineDefaultPressureCurve = true)
        annotation (Placement(transformation(extent={{-160,-10},{-140,-30}})));

      Modelica.Fluid.Sources.FixedBoundary Sink(
          redeclare package Medium = MediumAir, nPorts=nZones)
                         annotation (Placement(
            transformation(extent={{-20,-30},{-40,-10}})));
      Modelica.Fluid.Interfaces.FluidPort_a
        Ventilation_sup[nZones](redeclare package Medium =
            MediumAir)
        annotation (Placement(transformation(extent={{-10,-10},
                {10,10}},
            rotation=0,
            origin={-200,20}), iconTransformation(
              extent={{10,-110},{30,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_b
        Ventilation_ex[nZones](redeclare package Medium =
            MediumAir)
        annotation (Placement(transformation(extent={{-10,-10},
                {10,10}},
            rotation=0,
            origin={-200,-20}), iconTransformation(
              extent={{-30,-110},{-10,-90}})));
      Modelica.Blocks.Math.Gain gain[nZones](each k=1/
            3600)
        annotation (Placement(transformation(extent={{
                174,46},{166,54}})));
      Modelica.Fluid.Sensors.Density density[nZones](
          redeclare package Medium =
            MediumAir)
        annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},
            rotation=-90,
            origin={140,80})));
      Modelica.Blocks.Math.Product product[nZones]
        annotation (Placement(transformation(extent={{136,44},{124,56}})));
      Modelica.Blocks.Math.Gain gain1[
                                     nZones](each k=1/
            3600)
        annotation (Placement(transformation(extent={{174,-54},
                {166,-46}})));
      Modelica.Fluid.Sensors.Density density1[
                                             nZones](
          redeclare package Medium =
            MediumAir)
        annotation (Placement(transformation(
            extent={{6,-6},{-6,6}},
            rotation=-90,
            origin={140,-80})));
      Modelica.Blocks.Math.Product product1[
                                           nZones]
        annotation (Placement(transformation(extent={{136,-56},
                {124,-44}})));
      IDEAS.Fluid.HeatExchangers.ConstantEffectiveness hex[nZones](
        m1_flow_nominal=1./3600.*1.204,
        m2_flow_nominal=1./3600.*1.204,
        dp1_nominal=0,
        dp2_nominal=0,
        redeclare package Medium1 = MediumAir,
        redeclare package Medium2 = MediumAir,
        eps=recupEff) "Heat exchanger for the recuperator"
        annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
      IDEAS.Fluid.Movers.FlowControlled_m_flow pump1
                                                   [nZones](
        redeclare each package Medium = MediumAir, addPowerToMedium = false, m_flow_nominal = 1. / 3600. * 1.204, nominalValuesDefineDefaultPressureCurve = true)
        annotation (Placement(transformation(extent={{-140,10},{-160,30}})));

      IDEAS.Fluid.Sources.Boundary_pT sou[nZones](
        use_X_in=true,
        use_C_in=true,
        use_p_in=true,
        final nPorts=1,
        redeclare package Medium = MediumAir,
        use_T_in=true) "Ambient air"
        annotation (Placement(transformation(extent={{-20,10},{-40,30}})));
      IDEAS.Utilities.Psychrometrics.X_pTphi x_pTphi1
                                                    [nZones](each use_p_in=true)
                                                                             annotation (Placement(transformation(extent={{38,2},{
                22,18}})));
       IDEAS.BoundaryConditions.WeatherData.Bus     weaBus annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=0,
            origin={190,10}),  iconTransformation(
              extent={{-20,80},{20,120}})));
      Modelica.Blocks.Routing.Replicator replicator_P(nout=nZones)
        annotation (Placement(transformation(extent={{136,24},{124,36}})));
      Modelica.Blocks.Routing.Replicator replicator_T(nout=nZones)
        annotation (Placement(transformation(extent={{136,4},{124,16}})));
      Modelica.Blocks.Routing.Replicator replicator_phi(nout=nZones)
        annotation (Placement(transformation(extent={{136,-16},{124,-4}})));
      Modelica.Blocks.Routing.Replicator replicator_phi1(nout=nZones)
        annotation (Placement(transformation(extent={{136,-36},{124,-24}})));
    equation

      connect(Ventilation_ex, pump.port_a)
        annotation (Line(points={{-200,-20},{-160,-20}},
                          color={0,0,0}));

      connect(m_sup, gain.u) annotation (Line(points={
              {204,50},{174.8,50}}, color={0,0,127}));
      connect(Ventilation_sup, density.port)
        annotation (Line(points={{-200,20},{-200,20},{
              -200,80},{134,80}}, color={0,127,255}));
      connect(gain.y, product.u2) annotation (Line(
            points={{165.6,50},{152,50},{152,44},{137.2,44},{137.2,46.4}},
                      color={0,0,127}));
      connect(density.d, product.u1) annotation (Line(
            points={{140,73.4},{140,54},{138,54},{138,53.6},{137.2,53.6}},
                                   color={0,0,127}));

      connect(m_ex, gain1.u) annotation (Line(points={
              {204,-50},{190,-50},{174.8,-50}}, color=
             {0,0,127}));
      connect(gain1.y, product1.u1) annotation (Line(
            points={{165.6,-50},{152,-50},{152,-46.4},
              {137.2,-46.4}}, color={0,0,127}));
      connect(density1.d, product1.u2) annotation (
          Line(points={{140,-73.4},{140,-73.4},{140,-53.6},
              {137.2,-53.6}}, color={0,0,127}));
      connect(Ventilation_ex, density1.port)
        annotation (Line(points={{-200,-20},{-200,-20},
              {-200,-80},{134,-80}}, color={0,127,255}));
      connect(product1.y, pump.m_flow_in) annotation (
         Line(points={{123.4,-50},{-150,-50},{-150,-32}},
                         color={0,0,127}));
      connect(pump1.port_b, Ventilation_sup)
        annotation (Line(points={{-160,20},{-200,20}}, color={0,127,255}));
      connect(hex.port_a1, pump1.port_a) annotation (Line(points={{-100,6},{-134,6},
              {-134,20},{-140,20}}, color={0,127,255}));
      connect(hex.port_b2, pump.port_b) annotation (Line(points={{-100,-6},{-134,-6},
              {-134,-20},{-140,-20}}, color={0,127,255}));
      connect(Sink.ports, hex.port_a2) annotation (Line(points={{-40,-20},{-74,-20},
              {-74,-6},{-80,-6}}, color={0,127,255}));
      connect(sou.ports[1], hex.port_b1) annotation (Line(points={{-40,20},{-74,20},
              {-74,6},{-80,6}}, color={0,127,255}));
      connect(product.y, pump1.m_flow_in) annotation (Line(points={{123.4,50},{-150,
              50},{-150,32}}, color={0,0,127}));
      connect(x_pTphi1.X, sou.X_in) annotation (Line(points={{21.2,10},{-10,10},
              {-10,16},{-18,16}},
                             color={0,0,127}));
      connect(weaBus.pAtm, replicator_P.u) annotation (Line(
          points={{190,10},{190,30},{137.2,30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(replicator_P.y, sou.p_in) annotation (Line(points={{123.4,30},{
              -10,30},{-10,28},{-18,28}}, color={0,0,127}));
      connect(replicator_P.y, x_pTphi1.p_in) annotation (Line(points={{123.4,30},
              {44,30},{44,14.8},{39.6,14.8}}, color={0,0,127}));
      connect(weaBus.TDryBul, replicator_T.u) annotation (Line(
          points={{190,10},{137.2,10}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(replicator_T.y, sou.T_in) annotation (Line(points={{123.4,10},{46,
              10},{46,24},{-18,24}}, color={0,0,127}));
      connect(replicator_T.y, x_pTphi1.T)
        annotation (Line(points={{123.4,10},{39.6,10}}, color={0,0,127}));
      connect(weaBus.relHum, replicator_phi.u) annotation (Line(
          points={{190,10},{190,-10},{137.2,-10}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(replicator_phi.y, x_pTphi1.phi) annotation (Line(points={{123.4,
              -10},{44,-10},{44,5.2},{39.6,5.2}}, color={0,0,127}));
      connect(weaBus.CEnv, replicator_phi1.u) annotation (Line(
          points={{190,10},{190,-30},{137.2,-30}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(replicator_phi1.y, sou.C_in[1]) annotation (Line(points={{123.4,
              -30},{-12,-30},{-12,12},{-18,12}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-200,
                -100},{200,100}}), graphics={
            Rectangle(
              extent={{-200,100},{200,-100}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={191,0,0}),
            Text(
              extent={{-98,80},{82,40}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              fontName="Times New Roman",
              horizontalAlignment=TextAlignment.Left,
              textString="VENTILATION"),
            Line(
              points={{-140,20},{-60,20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{-140,-40},{-60,-40}},
              color={191,0,0},
              thickness=0.5,
              pattern=LinePattern.Dash),
            Line(
              points={{-60,20},{-48,20},{-28,14},
                  {-10,0},{0,-10},{10,-20},{28,
                  -34},{48,-40},{60,-40}},
              color={191,0,0},
              smooth=Smooth.Bezier,
              thickness=0.5),
            Line(
              points={{-60,-40},{-48,-40},{-28,
                  -34},{-10,-20},{0,-10},{10,0},{
                  28,14},{48,20},{60,20}},
              color={191,0,0},
              smooth=Smooth.Bezier,
              thickness=0.5,
              pattern=LinePattern.Dash),
            Line(
              points={{60,20},{140,20}},
              color={191,0,0},
              thickness=0.5,
              pattern=LinePattern.Dash),
            Line(
              points={{60,-40},{140,-40}},
              color={191,0,0},
              thickness=0.5),
            Polygon(
              points={{110,-60},{110,-20},{140,
                  -40},{110,-60}},
              lineColor={191,0,0},
              fillColor={191,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-110,-60},{-110,-20},{-140,
                  -40},{-110,-60}},
              lineColor={191,0,0},
              lineThickness=0.5,
              pattern=LinePattern.Dash)}),
                                    Diagram(
            coordinateSystem(preserveAspectRatio=false,
              extent={{-200,-100},{200,100}})));
    end Ventilation;
  end Ventilation;

  package Occupancy
    model Occupancy

      replaceable package MediumAir = IDEAS.Media.Air (extraPropertiesNames={"CO2"});

      // Weather Data ---------------------------------------------------------------------------------------------------------------------------------------------------------
      // Building characteristics ---------------------------------------------------------------------------------------------------------------------------------------------
      parameter Integer nZones(min=1) = nZones
        "Number of conditioned thermal zones in the building";

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortCon
        "Nodes for convective heat gains" annotation (Placement(transformation(
              extent={{-210,10},{-190,30}}),iconTransformation(extent={{-10,-10},{10,
                10}},
            rotation=180,
            origin={200,20})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[nZones] heatPortRad
        "Nodes for radiative heat gains" annotation (Placement(transformation(
              extent={{-210,-30},{-190,-10}}),iconTransformation(extent={{-10,-10},{
                10,10}},
            rotation=180,
            origin={200,-20})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow[nZones] annotation (Placement(transformation(extent={{-140,10},
                {-160,30}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1[nZones] annotation (Placement(transformation(extent={{-140,
                -30},{-160,-10}})));
      Modelica.Blocks.Interfaces.RealInput Q_rad[nZones] "[W]"
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={204,-20}), iconTransformation(
              extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-200,-20})));
      Modelica.Blocks.Interfaces.RealInput Q_con[nZones] "[W]"
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={204,20}), iconTransformation(
              extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-200,20})));
    equation
      connect(prescribedHeatFlow.port, heatPortCon) annotation (Line(points={{-160,20},
              {-198,20},{-200,20}},                                                                          color={191,0,0}));
      connect(prescribedHeatFlow1.port, heatPortRad) annotation (Line(points={{-160,
              -20},{-200,-20}},                                                                                  color={191,0,0}));
      connect(Q_con, prescribedHeatFlow.Q_flow)
        annotation (Line(points={{204,20},{204,20},
              {-140,20}}, color={0,0,127}));
      connect(Q_rad, prescribedHeatFlow1.Q_flow)
        annotation (Line(points={{204,-20},{-140,
              -20}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{200,100}}), graphics={
            Rectangle(
              extent={{-200,100},{200,-100}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={191,0,0}),
            Text(
              extent={{-80,80},{80,40}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              fontName="Times New Roman",
              horizontalAlignment=TextAlignment.Left,
              textString="OCCUPANCY"),
            Line(
              points={{-170,20},{10,20}},
              color={191,0,0},
              thickness=0.5),
            Line(
              points={{-170,-20},{10,-20}},
              color={191,0,0},
              thickness=0.5),
            Rectangle(
              extent={{120,40},{100,-40}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineThickness=0.5),
            Polygon(
              points={{40,-40},{40,40},{100,0},{40,-40}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineThickness=0.5),
            Text(
              extent={{22,30},{84,-30}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              textStyle={TextStyle.Italic},
              fontName="Bookman Old Style",
              textString="?")}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{200,100}})));
    end Occupancy;
  end Occupancy;
  annotation (uses(
      TestModel(version="2"),
      Modelica(version="4.0.0"),
      IDEAS(version="2.2.2"),
      ModelicaServices(version="4.0.0"),
      TwinHouses(version="3"),
      MVH_Detached(version="3")),
    version="2",
    conversion(from(version={"1",""}, script=
            "modelica://DyMatTest/ConvertFromDyMatTest_1.mos")));
end Skole;
