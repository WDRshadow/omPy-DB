within DriverBehaviourModel.ComtrolledObjects;

model SteeringSystem
  parameter Real J_s(unit="1")=0.11 "Moment inertia of steering system.";
  parameter Real B_s(unit="1")=0.57 "Damping of steering system.";
  parameter Real K_h(unit="1")=1/17 "Transmission ratio between steering wheel angle and front wheel steering angle.";
  Modelica.Blocks.Math.Add add_torque annotation(
    Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain hydraulic(k = K_h)  annotation(
    Placement(visible = true, transformation(origin = {58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction damping_moment_inertia_system(a = {J_s, B_s})  annotation(
    Placement(visible = true, transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction damping_moment_inertia_system_2(a = {1, 0})  annotation(
    Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.AngleRealOutput steering_wheel_angle annotation(
    Placement(visible = true, transformation(origin = {-90, 32}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-90, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.TorqueRealInput torque_input annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.TorqueRealInput aligning_torque annotation(
    Placement(visible = true, transformation(origin = {-60, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {0, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  DriverBehaviourModel.Interfaces.AngleRealOutput front_wheel_angle annotation(
    Placement(visible = true, iconTransformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(add_torque.y, damping_moment_inertia_system.u) annotation(
    Line(points = {{-28, 0}, {-22, 0}}, color = {0, 0, 127}));
  connect(damping_moment_inertia_system.y, damping_moment_inertia_system_2.u) annotation(
    Line(points = {{2, 0}, {8, 0}}, color = {0, 0, 127}));
  connect(damping_moment_inertia_system_2.y, hydraulic.u) annotation(
    Line(points = {{31, 0}, {46, 0}}, color = {0, 0, 127}));
  connect(steering_wheel_angle, damping_moment_inertia_system_2.y) annotation(
    Line(points = {{-90, 32}, {38, 32}, {38, 0}, {32, 0}}, color = {255, 0, 0}));
  connect(torque_input, add_torque.u1) annotation(
    Line(points = {{-100, 0}, {-68, 0}, {-68, 6}, {-52, 6}}));
  connect(aligning_torque, add_torque.u2) annotation(
    Line(points = {{-60, -60}, {-60, -6}, {-52, -6}}));
  connect(front_wheel_angle, hydraulic.y) annotation(
    Line(points = {{90, 0}, {70, 0}}, color = {255, 0, 0}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-120, 40}, {100, -80}})),
    version = "",
  Icon(graphics = {Text(origin = {0, 80}, lineColor = {0, 0, 255}, extent = {{-100, 20}, {100, -20}}, textString = "%name"), Ellipse(fillColor = {255, 0, 0}, fillPattern = FillPattern.Backward, extent = {{-40, 40}, {40, -40}}), Ellipse(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-30, 30}, {30, -30}}), Line(origin = {-40, 45}, points = {{-40, 5}, {40, 5}, {40, -3}, {40, -5}, {40, -5}}, color = {255, 0, 0}, thickness = 0.5), Line(origin = {-50, 0.31}, points = {{-10, 0}, {10, 0}, {10, 0}}, thickness = 0.5), Line(origin = {60, 0}, points = {{-20, 0}, {20, 0}, {20, 0}}, color = {255, 0, 0}, thickness = 0.5), Line(origin = {0, -50}, points = {{0, 10}, {0, -10}, {0, -10}}, thickness = 0.5)}));
end SteeringSystem;
