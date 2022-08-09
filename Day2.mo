package Day2
  package Functions
    function CoolingLoadRoom
      input Real Qint;
      input Real UA;
      input Real Tamb;
      input Real Tr;
      output Real Qr;
    algorithm
      Qr := (-Qint) - UA * (Tamb - Tr);
    end CoolingLoadRoom;
  end Functions;

  package Components
    model SimpleRoom
      parameter Real n = 3;
      parameter Modelica.Units.SI.ThermalConductance G = 10000 / 30;
      parameter Modelica.Units.SI.Temperature T_start = 293.15;
      parameter Modelica.Units.SI.Volume V_room = 6 * 10 * 3;
      replaceable package Air = Buildings.Media.Air;
      Buildings.Fluid.MixingVolumes.MixingVolume AirThemMass(redeclare package Medium = Air, T_start = T_start, V = V_room, energyDynamics = Modelica.Fluid.Types.Dynamics.DynamicFreeInitial, mSenFac = n, m_flow_nominal = V_room * 6 / 3600, nPorts = 2) annotation(
        Placement(visible = true, transformation(extent = {{6, 0}, {26, 20}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation(
        Placement(visible = true, transformation(extent = {{-80, 60}, {-60, 80}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor Walls(G = G) annotation(
        Placement(visible = true, transformation(extent = {{-40, 60}, {-20, 80}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(
        Placement(visible = true, transformation(extent = {{-76, -80}, {-56, -60}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Air) annotation(
        Placement(visible = true, transformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0), iconTransformation(extent = {{-110, -10}, {-90, 10}}, rotation = 0)));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Air) annotation(
        Placement(visible = true, transformation(extent = {{90, -10}, {110, 10}}, rotation = 0), iconTransformation(extent = {{90, -10}, {110, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Gains annotation(
        Placement(visible = true, transformation(extent = {{-126, -90}, {-86, -50}}, rotation = 0), iconTransformation(origin = {-99, -59}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Tamb annotation(
        Placement(visible = true, transformation(extent = {{-128, 50}, {-88, 90}}, rotation = 0), iconTransformation(origin = {-99, 61}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput TIn annotation(
        Placement(visible = true, transformation(extent = {{96, -60}, {116, -40}}, rotation = 0), iconTransformation(extent = {{94, -50}, {114, -30}}, rotation = 0)));
      Modelica.Fluid.Sensors.TemperatureTwoPort OutletTSensor(redeclare package Medium = Air) annotation(
        Placement(visible = true, transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Sensors.TemperatureTwoPort InletTSensor(redeclare package Medium = Air) annotation(
        Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput TOut annotation(
        Placement(visible = true, transformation(extent = {{96, 50}, {116, 70}}, rotation = 0), iconTransformation(extent = {{94, 70}, {114, 90}}, rotation = 0)));
      Modelica.Fluid.Sensors.MassFlowRate InletMSensor(redeclare package Medium = Air) annotation(
        Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      Modelica.Fluid.Sensors.MassFlowRate OutletMSensor(redeclare package Medium = Air) annotation(
        Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput mIn annotation(
        Placement(visible = true, transformation(extent = {{96, -100}, {116, -80}}, rotation = 0), iconTransformation(extent = {{94, -90}, {114, -70}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput mOut annotation(
        Placement(visible = true, transformation(extent = {{96, 80}, {116, 100}}, rotation = 0), iconTransformation(extent = {{94, 30}, {114, 50}}, rotation = 0)));
    equation
      connect(prescribedTemperature.port, Walls.port_a) annotation(
        Line(points = {{-60, 70}, {-40, 70}}, color = {191, 0, 0}));
      connect(Walls.port_b, AirThemMass.heatPort) annotation(
        Line(points = {{-20, 70}, {0, 70}, {0, 10}, {6, 10}}, color = {191, 0, 0}));
      connect(prescribedHeatFlow.port, AirThemMass.heatPort) annotation(
        Line(points = {{-56, -70}, {0, -70}, {0, 10}, {6, 10}}, color = {191, 0, 0}));
      connect(InletTSensor.port_a, port_a) annotation(
        Line(points = {{-80, 0}, {-100, 0}}, color = {0, 127, 255}));
      connect(InletTSensor.T, TIn) annotation(
        Line(points = {{-70, -11}, {-70, -50}, {106, -50}}, color = {0, 0, 127}));
      connect(mIn, InletMSensor.m_flow) annotation(
        Line(points = {{106, -90}, {-30, -90}, {-30, -10}}, color = {0, 0, 127}));
      connect(InletTSensor.port_b, InletMSensor.port_a) annotation(
        Line(points = {{-60, 0}, {-40, 0}}, color = {0, 127, 255}));
      connect(InletMSensor.port_b, AirThemMass.ports[1]) annotation(
        Line(points = {{-20, 0}, {16, 0}}, color = {0, 127, 255}));
      connect(AirThemMass.ports[2], OutletMSensor.port_a) annotation(
        Line(points = {{16, 0}, {30, 0}}, color = {0, 127, 255}));
      connect(OutletMSensor.port_b, OutletTSensor.port_a) annotation(
        Line(points = {{50, 0}, {60, 0}}, color = {0, 127, 255}));
      connect(prescribedTemperature.T, Tamb) annotation(
        Line(points = {{-82, 70}, {-108, 70}}, color = {0, 0, 127}));
      connect(prescribedHeatFlow.Q_flow, Gains) annotation(
        Line(points = {{-76, -70}, {-106, -70}}, color = {0, 0, 127}));
      connect(OutletMSensor.m_flow, mOut) annotation(
        Line(points = {{40, 12}, {40, 90}, {106, 90}}, color = {0, 0, 127}));
      connect(OutletTSensor.T, TOut) annotation(
        Line(points = {{70, 12}, {70, 60}, {106, 60}}, color = {0, 0, 127}));
      connect(OutletTSensor.port_b, port_b) annotation(
        Line(points = {{80, 0}, {100, 0}}, color = {0, 127, 255}));
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false)),
        Diagram(coordinateSystem(preserveAspectRatio = false)));
    end SimpleRoom;
  end Components;

  package Experiments
    model Infiltration
      parameter Modelica.Units.SI.Volume V_room = 6 * 10 * 3;
      parameter Modelica.Units.SI.Power Gains = 1000;
      replaceable package Air = Buildings.Media.Air;
      Day2.Components.SimpleRoom Room(redeclare package Air = Air) annotation(
        Placement(visible = true, transformation(extent = {{40, -10}, {60, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.RealExpression realExpression(y = Gains) annotation(
        Placement(visible = true, transformation(extent = {{0, -40}, {20, -20}}, rotation = 0)));
      Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"), pAtmSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, TDryBulSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, TDryBul = 303.15) annotation(
        Placement(visible = true, transformation(extent = {{-86, 44}, {-66, 64}}, rotation = 0)));
      Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(
        Placement(visible = true, transformation(extent = {{-64, 34}, {-24, 74}}, rotation = 0), iconTransformation(extent = {{-148, 4}, {-128, 24}}, rotation = 0)));
      Buildings.Fluid.Sources.Outside out(redeclare package Medium = Buildings.Media.Air, nPorts = 2) annotation(
        Placement(visible = true, transformation(extent = {{-60, -10}, {-40, 10}}, rotation = 0)));
      Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium = Buildings.Media.Air, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = V_room / 600) annotation(
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.RealExpression realExpression1(y = V_room / 600) annotation(
        Placement(visible = true, transformation(origin = {-25, 20}, extent = {{-15, -10}, {15, 10}}, rotation = 0)));
    equation
      connect(weaDat.weaBus, weaBus) annotation(
        Line(points = {{-66, 54}, {-44, 54}}, color = {255, 204, 51}, thickness = 0.5));
      connect(out.weaBus, weaDat.weaBus) annotation(
        Line(points = {{-60, 0}, {-60, 54}, {-66, 54}}, color = {255, 204, 51}, thickness = 0.5));
      connect(out.ports[1], fan.port_a) annotation(
        Line(points = {{-40, 0}, {-10, 0}}, color = {0, 127, 255}));
      connect(fan.port_b, Room.port_a) annotation(
        Line(points = {{10, 0}, {40, 0}}, color = {0, 127, 255}));
      connect(realExpression1.y, fan.m_flow_in) annotation(
        Line(points = {{-8, 20}, {0, 20}, {0, 12}}, color = {0, 0, 127}));
      connect(weaBus.TDryBul, Room.Tamb) annotation(
        Line(points = {{-44, 54}, {34, 54}, {34, 6}, {40, 6}}, color = {0, 0, 127}));
      connect(realExpression.y, Room.Gains) annotation(
        Line(points = {{22, -30}, {30, -30}, {30, -6}, {40, -6}}, color = {0, 0, 127}));
      connect(Room.port_b, out.ports[2]) annotation(
        Line(points = {{60, 0}, {72, 0}, {72, -60}, {-40, -60}, {-40, 0}}, color = {0, 127, 255}));
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false)),
        Diagram(coordinateSystem(preserveAspectRatio = false)));
    end Infiltration;

    model Recovery
      parameter Modelica.Units.SI.Volume V_room = 6 * 10 * 3;
      parameter Modelica.Units.SI.Power Gains = 1000;
      replaceable package Air = Buildings.Media.Air;
      Day2.Components.SimpleRoom Room annotation(
        Placement(visible = true, transformation(extent = {{70, -10}, {90, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.RealExpression realExpression(y = Gains) annotation(
        Placement(visible = true, transformation(extent = {{30, -40}, {50, -20}}, rotation = 0)));
      Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"), pAtmSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, TDryBulSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, TDryBul = 303.15) annotation(
        Placement(visible = true, transformation(extent = {{-86, 44}, {-66, 64}}, rotation = 0)));
      Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(
        Placement(visible = true, transformation(extent = {{-64, 34}, {-24, 74}}, rotation = 0), iconTransformation(extent = {{-148, 4}, {-128, 24}}, rotation = 0)));
      Buildings.Fluid.Sources.Outside out(redeclare package Medium = Air, nPorts = 2) annotation(
        Placement(visible = true, transformation(extent = {{-60, -10}, {-40, 10}}, rotation = 0)));
      Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium = Air, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = V_room / 600) annotation(
        Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.RealExpression realExpression1(y = V_room / 600) annotation(
        Placement(visible = true, transformation(origin = {25, 24}, extent = {{-9, -10}, {9, 10}}, rotation = 0)));
      Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(redeclare package Medium1 = Air, redeclare package Medium2 = Air, dp1_nominal = 200, dp2_nominal = 200, m1_flow_nominal = V_room / 600, m2_flow_nominal = V_room / 600) annotation(
        Placement(visible = true, transformation(extent = {{-30, -16}, {-10, 4}}, rotation = 0)));
    equation
      connect(weaDat.weaBus, weaBus) annotation(
        Line(points = {{-66, 54}, {-44, 54}}, color = {255, 204, 51}, thickness = 0.5));
      connect(out.weaBus, weaDat.weaBus) annotation(
        Line(points = {{-60, 0}, {-60, 54}, {-66, 54}}, color = {255, 204, 51}, thickness = 0.5));
      connect(fan.port_b, Room.port_a) annotation(
        Line(points = {{50, 0}, {70, 0}}, color = {0, 127, 255}));
      connect(realExpression1.y, fan.m_flow_in) annotation(
        Line(points = {{35, 24}, {40, 24}, {40, 12}}, color = {0, 0, 127}));
      connect(weaBus.TDryBul, Room.Tamb) annotation(
        Line(points = {{-44, 54}, {60, 54}, {60, 6}, {70, 6}}, color = {0, 0, 127}));
      connect(realExpression.y, Room.Gains) annotation(
        Line(points = {{51, -30}, {59, -30}, {59, -6}, {69, -6}}, color = {0, 0, 127}));
      connect(hex.port_b1, fan.port_a) annotation(
        Line(points = {{-10, 0}, {30, 0}}, color = {0, 127, 255}));
      connect(hex.port_a1, out.ports[1]) annotation(
        Line(points = {{-30, 0}, {-40, 0}}, color = {0, 127, 255}));
      connect(hex.port_b2, out.ports[2]) annotation(
        Line(points = {{-30, -12}, {-40, -12}, {-40, 0}}, color = {0, 127, 255}));
      connect(Room.port_b, hex.port_a2) annotation(
        Line(points = {{90, 0}, {96, 0}, {96, -12}, {-10, -12}}, color = {0, 127, 255}));
//Documentation(Buildings.Examples.Tutorial.SpaceCooling)
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false)),
        Diagram(coordinateSystem(preserveAspectRatio = false)));
    end Recovery;

    model Cooling
      parameter Modelica.Units.SI.Volume V_room = 6 * 10 * 3;
      parameter Modelica.Units.SI.Temperature Tamb = 30 + 273.15, Tset = 24 + 273.15, Tsup = 18 + 273.15 "Design temperatures";
      parameter Modelica.Units.SI.HeatFlowRate Qint = 1000;
      parameter Modelica.Units.SI.HeatFlowRate Qr = (-Qint) - 10000 / 30 * (30 - 24) "Cooling load of the room";
      parameter Modelica.Units.SI.MassFlowRate air_flow_nominal = 1.3 * Qr / 1006 / (18 - 24);
      parameter Modelica.Units.SI.HeatFlowRate Qconv = air_flow_nominal * 1006 * (18 - 2 - 25.2);
      parameter Modelica.Units.SI.HeatFlowRate Qsen = Qr + Qconv;
      //Qconv = Uin - Uout = cp*m_in*T_in - cp*m_out*T_out
      parameter Modelica.Units.SI.HeatFlowRate Qc = 4 * Qsen;
      parameter Modelica.Units.SI.Power Gains = 1000;
      replaceable package Air = Buildings.Media.Air;
      Day2.Components.SimpleRoom Room annotation(
        Placement(visible = true, transformation(extent = {{70, -10}, {90, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.RealExpression realExpression(y = Gains) annotation(
        Placement(visible = true, transformation(extent = {{30, -40}, {50, -20}}, rotation = 0)));
      Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"), pAtmSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, TDryBulSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, TDryBul = 303.15) annotation(
        Placement(visible = true, transformation(extent = {{-86, 68}, {-66, 88}}, rotation = 0)));
      Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(
        Placement(visible = true, transformation(extent = {{-64, 58}, {-24, 98}}, rotation = 0), iconTransformation(extent = {{-148, 4}, {-128, 24}}, rotation = 0)));
      Buildings.Fluid.Sources.Outside out(redeclare package Medium = Air, nPorts = 2) annotation(
        Placement(visible = true, transformation(extent = {{-60, -10}, {-40, 10}}, rotation = 0)));
      Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium = Air, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = V_room / 600) annotation(
        Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.RealExpression realExpression1(y = air_flow_nominal) annotation(
        Placement(visible = true, transformation(origin = {25, 24}, extent = {{-9, -10}, {9, 10}}, rotation = 0)));
      Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(redeclare package Medium1 = Air, redeclare package Medium2 = Air, dp1_nominal = 200, dp2_nominal = 200, m1_flow_nominal = V_room / 600, m2_flow_nominal = V_room / 600) annotation(
        Placement(visible = true, transformation(extent = {{-30, -16}, {-10, 4}}, rotation = 0)));
      Buildings.Controls.OBC.CDL.Continuous.Sources.Constant TRooSetPoi(k = 1) annotation(
        Placement(visible = true, transformation(extent = {{-40, 18}, {-20, 38}}, rotation = 0)));
      Buildings.Fluid.HeatExchangers.HeaterCooler_u cooCoi(redeclare package Medium = Air, Q_flow_nominal = Qc, m_flow_nominal = air_flow_nominal) annotation(
        Placement(visible = true, transformation(origin = {10, 0}, extent = {{10, 10}, {-10, -10}}, rotation = 180)));
    equation
      connect(weaDat.weaBus, weaBus) annotation(
        Line(points = {{-66, 78}, {-44, 78}}, color = {255, 204, 51}, thickness = 0.5));
      connect(out.weaBus, weaDat.weaBus) annotation(
        Line(points = {{-60, 0}, {-60, 78}, {-66, 78}}, color = {255, 204, 51}, thickness = 0.5));
      connect(fan.port_b, Room.port_a) annotation(
        Line(points = {{50, 0}, {70, 0}}, color = {0, 127, 255}));
      connect(realExpression1.y, fan.m_flow_in) annotation(
        Line(points = {{35, 24}, {40, 24}, {40, 12}}, color = {0, 0, 127}));
      connect(weaBus.TDryBul, Room.Tamb) annotation(
        Line(points = {{-44, 78}, {60, 78}, {60, 6}, {70, 6}}, color = {0, 0, 127}));
      connect(realExpression.y, Room.Gains) annotation(
        Line(points = {{51, -30}, {59, -30}, {59, -6}, {69, -6}}, color = {0, 0, 127}));
      connect(hex.port_a1, out.ports[1]) annotation(
        Line(points = {{-30, 0}, {-40, 0}}, color = {0, 127, 255}));
      connect(hex.port_b2, out.ports[2]) annotation(
        Line(points = {{-30, -12}, {-40, -12}, {-40, 0}}, color = {0, 127, 255}));
      connect(Room.port_b, hex.port_a2) annotation(
        Line(points = {{90, 0}, {96, 0}, {96, -12}, {-10, -12}}, color = {0, 127, 255}));
//Documentation(Buildings.Examples.Tutorial.SpaceCooling)
      connect(fan.port_a, cooCoi.port_b) annotation(
        Line(points = {{30, 0}, {20, 0}}, color = {0, 127, 255}));
      connect(hex.port_b1, cooCoi.port_a) annotation(
        Line(points = {{-10, 0}, {0, 0}}, color = {0, 127, 255}));
  connect(TRooSetPoi.y, cooCoi.u) annotation(
        Line(points = {{-18, 28}, {-10, 28}, {-10, 6}, {-2, 6}}, color = {0, 0, 127}));
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false)),
        Diagram(coordinateSystem(preserveAspectRatio = false)));
    end Cooling;

    model Control
      parameter Modelica.Units.SI.Volume V_room = 6 * 10 * 3;
      parameter Modelica.Units.SI.Temperature Tamb = 30 + 273.15, Tset = 24 + 273.15, Tsup = 18 + 273.15 "Design temperatures";
      parameter Modelica.Units.SI.HeatFlowRate Qint = 1000;
      parameter Modelica.Units.SI.HeatFlowRate Qr = (-Qint) - 10000 / 30 * (30 - 24) "Cooling load of the room";
      parameter Modelica.Units.SI.MassFlowRate air_flow_nominal = 1.3 * Qr / 1006 / (18 - 24);
      parameter Modelica.Units.SI.HeatFlowRate Qconv = air_flow_nominal * 1006 * (18 - 2 - 25.2);
      parameter Modelica.Units.SI.HeatFlowRate Qsen = Qr + Qconv;
      //Qconv = Uin - Uout = cp*m_in*T_in - cp*m_out*T_out
      parameter Modelica.Units.SI.HeatFlowRate Qc = 4 * Qsen;
      parameter Modelica.Units.SI.Power Gains = 1000;
      replaceable package Air = Buildings.Media.Air;
      Day2.Components.SimpleRoom Room annotation(
        Placement(visible = true, transformation(extent = {{70, -10}, {90, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.RealExpression realExpression(y = Gains) annotation(
        Placement(visible = true, transformation(extent = {{30, -40}, {50, -20}}, rotation = 0)));
      Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"), pAtmSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, TDryBulSou = Buildings.BoundaryConditions.Types.DataSource.Parameter, TDryBul = 303.15) annotation(
        Placement(visible = true, transformation(extent = {{-86, 68}, {-66, 88}}, rotation = 0)));
      Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(
        Placement(visible = true, transformation(extent = {{-64, 58}, {-24, 98}}, rotation = 0), iconTransformation(extent = {{-148, 4}, {-128, 24}}, rotation = 0)));
      Buildings.Fluid.Sources.Outside out(redeclare package Medium = Air, nPorts = 2) annotation(
        Placement(visible = true, transformation(extent = {{-60, -10}, {-40, 10}}, rotation = 0)));
      Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium = Air, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = V_room / 600) annotation(
        Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.RealExpression realExpression1(y = air_flow_nominal) annotation(
        Placement(visible = true, transformation(origin = {25, 24}, extent = {{-9, -10}, {9, 10}}, rotation = 0)));
      Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(redeclare package Medium1 = Air, redeclare package Medium2 = Air, dp1_nominal = 200, dp2_nominal = 200, m1_flow_nominal = V_room / 600, m2_flow_nominal = V_room / 600) annotation(
        Placement(visible = true, transformation(extent = {{-30, -16}, {-10, 4}}, rotation = 0)));
      Buildings.Controls.OBC.CDL.Logical.OnOffController con(bandwidth = 1) annotation(
        Placement(visible = true, transformation(extent = {{-66, -76}, {-46, -56}}, rotation = 0)));
      Buildings.Controls.OBC.CDL.Continuous.Sources.Constant TRooSetPoi(k = Tset) annotation(
        Placement(visible = true, transformation(extent = {{-102, -70}, {-82, -50}}, rotation = 0)));
      Buildings.Fluid.HeatExchangers.HeaterCooler_u cooCoi(redeclare package Medium = Air, Q_flow_nominal = Qc, m_flow_nominal = air_flow_nominal) annotation(
        Placement(visible = true, transformation(origin = {10, 0}, extent = {{10, 10}, {-10, -10}}, rotation = 180)));
      Buildings.Controls.OBC.CDL.Conversions.BooleanToReal mWat_flow(realFalse = 1, realTrue = 0) annotation(
        Placement(visible = true, transformation(extent = {{-38, -76}, {-18, -56}}, rotation = 0)));
    equation
      connect(weaDat.weaBus, weaBus) annotation(
        Line(points = {{-66, 78}, {-44, 78}}, color = {255, 204, 51}, thickness = 0.5));
      connect(out.weaBus, weaDat.weaBus) annotation(
        Line(points = {{-60, 0}, {-60, 78}, {-66, 78}}, color = {255, 204, 51}, thickness = 0.5));
      connect(fan.port_b, Room.port_a) annotation(
        Line(points = {{50, 0}, {70, 0}}, color = {0, 127, 255}));
      connect(realExpression1.y, fan.m_flow_in) annotation(
        Line(points = {{35, 24}, {40, 24}, {40, 12}}, color = {0, 0, 127}));
      connect(weaBus.TDryBul, Room.Tamb) annotation(
        Line(points = {{-44, 78}, {60, 78}, {60, 6}, {70, 6}}, color = {0, 0, 127}));
      connect(realExpression.y, Room.Gains) annotation(
        Line(points = {{51, -30}, {59, -30}, {59, -6}, {69, -6}}, color = {0, 0, 127}));
      connect(hex.port_a1, out.ports[1]) annotation(
        Line(points = {{-30, 0}, {-40, 0}}, color = {0, 127, 255}));
      connect(hex.port_b2, out.ports[2]) annotation(
        Line(points = {{-30, -12}, {-40, -12}, {-40, 0}}, color = {0, 127, 255}));
      connect(Room.port_b, hex.port_a2) annotation(
        Line(points = {{90, 0}, {96, 0}, {96, -12}, {-10, -12}}, color = {0, 127, 255}));
//Documentation(Buildings.Examples.Tutorial.SpaceCooling)
      connect(cooCoi.u, mWat_flow.y) annotation(
        Line(points = {{-2, 6}, {-8, 6}, {-8, -66}, {-16, -66}}, color = {0, 0, 127}));
      connect(con.y, mWat_flow.u) annotation(
        Line(points = {{-44, -66}, {-40, -66}}, color = {255, 0, 255}));
      connect(TRooSetPoi.y, con.reference) annotation(
        Line(points = {{-80, -60}, {-68, -60}}, color = {0, 0, 127}));
      connect(fan.port_a, cooCoi.port_b) annotation(
        Line(points = {{30, 0}, {20, 0}}, color = {0, 127, 255}));
      connect(hex.port_b1, cooCoi.port_a) annotation(
        Line(points = {{-10, 0}, {0, 0}}, color = {0, 127, 255}));
      connect(con.u, Room.TOut) annotation(
        Line(points = {{-68, -72}, {-80, -72}, {-80, -80}, {120, -80}, {120, 8}, {90, 8}}, color = {0, 0, 127}));
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false)),
        Diagram(coordinateSystem(preserveAspectRatio = false)));
    end Control;
  end Experiments;

  package Building
  end Building;
  annotation(
    uses(Buildings(version = "7.0.0"), Modelica(version = "4.0.0"), ModelicaServices(version = "4.0.0")), Documentation(info="<html> This package adopts buildings and ideas tutorials to the teaching goals of the workshop. For more information and further practice see https://simulationresearch.lbl.gov/modelica/releases/latest/help/Buildings_Examples_Tutorial_SpaceCooling.html and https://github.com/open-ideas/IDEAS/tree/master/IDEAS/Templates </html>"));
end Day2;
