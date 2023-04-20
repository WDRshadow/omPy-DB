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
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-60, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.TorqueRealOutput torque_output annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.AngleRealInput steering_wheel_angle annotation(
    Placement(visible = true, transformation(origin = {120, 80}, extent = {{20, -20}, {-20, 20}}, rotation = 0), iconTransformation(origin = {0, -26}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
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
    Icon(graphics = {Text(origin = {0, -80}, lineColor = {0, 0, 255}, extent = {{-100, 20}, {100, -20}}, textString = "%name", fontSize = 20), Line(origin = {-10.6276, 6.53672}, points = {{-50.112, 3.80515}, {-28.112, -0.194848}, {-4.112, -2.19485}, {21.888, -2.19485}, {41.888, 1.80515}, {47.888, 3.80515}, {49.888, 7.80515}}, thickness = 0.5), Line(origin = {-10.7276, -12.5633}, points = {{-50.0082, 2.90344}, {-30.0082, -1.09656}, {-10.0082, -3.09656}, {9.99179, -3.09656}, {31.9918, -1.09656}, {51.9918, 0.90344}, {69.9918, 6.90344}}, thickness = 0.5), Line(origin = {36.0524, 42.3367}, points = {{23.2071, -48}, {25.2071, -46}, {29.2071, -40}, {29.2071, -30}, {21.2071, -14}, {1.20711, 14}, {-22.7929, 34}, {-28.7929, 36}, {-34.7929, 38}}, thickness = 0.5), Line(origin = {21.4924, 40.3567}, points = {{26.0171, -32.0171}, {20.0171, -30.0171}, {12.0171, -14.0171}, {-3.98294, 9.98294}, {-11.9829, 21.9829}, {-19.9829, 25.9829}}, thickness = 0.5), Ellipse(origin = {-7, 73}, fillPattern = FillPattern.Solid, extent = {{-11, 11}, {11, -11}})}));
end NeuromuscularSystem;
