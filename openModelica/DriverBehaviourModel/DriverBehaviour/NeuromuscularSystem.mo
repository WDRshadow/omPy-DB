within DriverBehaviourModel.DriverBehaviour;

model NeuromuscularSystem
  parameter Real T_N(unit="1")=0.1 "Neuromuscular time constant.";
  parameter Real K_r(unit="1")=0.3 "Torque coefficient.";
  parameter Real K_t(unit="1")=0.5 "Stretch reflex.";
  parameter Real v(unit="m/s")=24 "Vehicle Speed.";
  Modelica.Blocks.Math.Gain gain_reflex(k = K_t)  annotation(
    Placement(visible = true, transformation(origin = {-12, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.Gain steering_stiffness(k = K_r * v)  annotation(
    Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add steering_wheel_add(k1 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-12, 68}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.Add torque_add annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction neuromuscular_dynamics(a = {T_N, 1})  annotation(
    Placement(visible = true, transformation(origin = {56, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.AngleRealInput desired_angle annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.TorqueRealOutput torque_output annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.AngleRealInput steering_wheel_angle annotation(
    Placement(visible = true, transformation(origin = {120, 80}, extent = {{20, -20}, {-20, 20}}, rotation = 0), iconTransformation(origin = {120, 80}, extent = {{20, -20}, {-20, 20}}, rotation = 0)));
equation
  connect(steering_wheel_add.y, gain_reflex.u) annotation(
    Line(points = {{-12, 57}, {-12, 41}}, color = {0, 0, 127}));
  connect(steering_stiffness.y, torque_add.u2) annotation(
    Line(points = {{-58, 0}, {-18, 0}, {-18, -6}, {-12, -6}}, color = {0, 0, 127}));
  connect(gain_reflex.y, torque_add.u1) annotation(
    Line(points = {{-12, 19}, {-12, 5}}, color = {0, 0, 127}));
  connect(torque_add.y, neuromuscular_dynamics.u) annotation(
    Line(points = {{11, 0}, {44, 0}}, color = {0, 0, 127}));
  connect(desired_angle, steering_stiffness.u) annotation(
    Line(points = {{-120, 0}, {-82, 0}}, color = {255, 0, 0}));
  connect(torque_output, neuromuscular_dynamics.y) annotation(
    Line(points = {{110, 0}, {68, 0}}));
  connect(steering_wheel_angle, steering_wheel_add.u1) annotation(
    Line(points = {{120, 80}, {-6, 80}}, color = {255, 0, 0}));
  connect(desired_angle, steering_wheel_add.u2) annotation(
    Line(points = {{-120, 0}, {-92, 0}, {-92, 80}, {-18, 80}}, color = {255, 0, 0}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Ellipse(fillColor = {255, 0, 0}, fillPattern = FillPattern.Backward, extent = {{-40, 40}, {40, -40}}), Ellipse( fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-30, 30}, {30, -30}}), Line(origin = {50, 60}, points = {{50, 20}, {-50, 20}, {-50, -20}, {-50, -20}}, color = {255, 0, 0}, thickness = 0.5), Line(origin = {-70, 0}, points = {{-30, 0}, {30, 0}, {30, 0}}, color = {255, 0, 0}, thickness = 0.5), Line(origin = {70, 0}, points = {{-30, 0}, {30, 0}, {30, 0}}, thickness = 0.5), Text(origin = {0, -60}, lineColor = {0, 0, 255}, extent = {{-100, 20}, {100, -20}}, textString = "%name")}));
end NeuromuscularSystem;
