within DriverBehaviourModel.Examples;

model DriverVehiclePath
  extends Modelica.Icons.Example;
  DriverBehaviourModel.ComtrolledObjects.VehicleDynamic vehicleDynamic(E_t = parameters.E_t, I = parameters.I, K_b = parameters.K_b, K_f = parameters.K_f, K_h = parameters.K_h, K_s = parameters.K_s, l_f = parameters.l_f, l_r = parameters.l_r,m = parameters.vehicleMass, v = parameters.vehicleSpeed)  annotation(
    Placement(visible = true, transformation(origin = {170, 30}, extent = {{30, -30}, {-30, 30}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable timeTable_far(table = far.getRealArray2D(458, 2))  annotation(
    Placement(visible = true, transformation(origin = {-130, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable timeTable_near(table = near.getRealArray2D(458, 2))  annotation(
    Placement(visible = true, transformation(origin = {-100, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner parameter ExternData.CSVFile far(fileName = "C:/Users/WDRshadow/PycharmProjects/omPy-DB/openModelica/data/far1.csv", nHeaderLines = 1)  annotation(
    Placement(visible = true, transformation(origin = {-170, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner parameter ExternData.CSVFile near(fileName = "C:/Users/WDRshadow/PycharmProjects/omPy-DB/openModelica/data/near1.csv", nHeaderLines = 1)  annotation(
    Placement(visible = true, transformation(origin = {-170, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DriverBehaviourModel.ComtrolledObjects.Path path(t_f = parameters.t_f, t_n = parameters.t_n)  annotation(
    Placement(visible = true, transformation(origin = {70, 30}, extent = {{30, -30}, {-30, 30}}, rotation = 0)));
  DriverBehaviourModel.DriverBehaviour.VisionSystem visionSystem(T_L = parameters.T_L, T_l = parameters.T_l, g_c = parameters.g_c, g_p = parameters.g_p, t_a = parameters.t_a, v = parameters.vehicleSpeed)  annotation(
    Placement(visible = true, transformation(origin = {-30, 90}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  DriverBehaviourModel.DriverBehaviour.NeuromuscularSystem neuromuscularSystem(K_r = parameters.K_r, K_t = parameters.K_t, T_N = parameters.T_N, v = parameters.vehicleSpeed)  annotation(
    Placement(visible = true, transformation(origin = {70, 90}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  DriverBehaviourModel.ComtrolledObjects.SteeringSystem steeringSystem(B_s = parameters.B_s, J_s = parameters.J_s, K_h = parameters.K_h)  annotation(
    Placement(visible = true, transformation(origin = {170, 90}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.AngleRealOutput front_wheel_angle annotation(
    Placement(visible = true, transformation(origin = {220, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {20, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  DriverBehaviourModel.Interfaces.AngleRealOutput heading_angle_output annotation(
    Placement(visible = true, transformation(origin = {70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {10, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  inner parameter ExternData.CSVFile heading(fileName = "C:/Users/WDRshadow/PycharmProjects/omPy-DB/openModelica/data/heading1.csv", nHeaderLines = 1) annotation(
    Placement(visible = true, transformation(origin = {-170, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable timeTable_heading(table = heading.getRealArray2D(458, 2)) annotation(
    Placement(visible = true, transformation(origin = {-130, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.AngleRealOutput heading_angle_reference annotation(
    Placement(visible = true, transformation(origin = {-100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-30, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  DriverBehaviourModel.Interfaces.AngleRealOutput heading_angle_difference annotation(
    Placement(visible = true, transformation(origin = {-20, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-10, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.Add add(k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-20, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  DriverBehaviourModel.ComtrolledObjects.Parameters parameters(K_t = 0.4, g_c = 0)  annotation(
    Placement(visible = true, transformation(origin = {-170, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.AngleRealOutput desired_angle annotation(
    Placement(visible = true, transformation(origin = {20, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Math.Abs abs annotation(
    Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(visionSystem.desired_angle, neuromuscularSystem.desired_angle) annotation(
    Line(points = {{4, 90}, {34, 90}}, color = {255, 0, 0}));
  connect(steeringSystem.steering_wheel_angle, neuromuscularSystem.steering_wheel_angle) annotation(
    Line(points = {{146, 103}, {130, 103}, {130, 114}, {106, 114}}, color = {255, 0, 0}));
  connect(neuromuscularSystem.torque_output, steeringSystem.torque_input) annotation(
    Line(points = {{104, 90}, {149, 90}}, thickness = 0.5));
  connect(steeringSystem.aligning_torque, vehicleDynamic.aligning_torque) annotation(
    Line(points = {{170, 66}, {170, 48}}));
  connect(steeringSystem.front_wheel_angle, vehicleDynamic.front_wheel_angle) annotation(
    Line(points = {{197, 90}, {220, 90}, {220, 30}, {200, 30}}, color = {255, 0, 0}));
  connect(vehicleDynamic.side_slip_angle, path.vehicle_side_slip_angle) annotation(
    Line(points = {{143, 39}, {106, 39}}, color = {255, 0, 0}));
  connect(vehicleDynamic.yaw_rate, path.vehicle_yaw_rate) annotation(
    Line(points = {{143, 21}, {106, 21}}, color = {0, 0, 127}));
  connect(steeringSystem.front_wheel_angle, front_wheel_angle) annotation(
    Line(points = {{198, 90}, {220, 90}, {220, 130}}, color = {255, 0, 0}));
  connect(visionSystem.near_angle, timeTable_near.y) annotation(
    Line(points = {{-66, 78}, {-89, 78}}, color = {255, 0, 0}));
  connect(visionSystem.far_angle, timeTable_far.y) annotation(
    Line(points = {{-66, 102}, {-119, 102}}, color = {255, 0, 0}));
  connect(path.heading_angle, heading_angle_output) annotation(
    Line(points = {{70, 10}, {70, -30}}, color = {255, 0, 0}));
  connect(heading_angle_reference, timeTable_heading.y) annotation(
    Line(points = {{-100, -30}, {-100, 50}, {-119, 50}}, color = {255, 0, 0}));
  connect(path.heading_angle, add.u1) annotation(
    Line(points = {{70, 10}, {70, 0}, {20, 0}, {20, 50}, {-14, 50}, {-14, 42}}, color = {255, 0, 0}));
  connect(visionSystem.desired_angle, desired_angle) annotation(
    Line(points = {{4, 90}, {20, 90}, {20, 130}}, color = {255, 0, 0}));
  connect(timeTable_heading.y, add.u2) annotation(
    Line(points = {{-119, 50}, {-26, 50}, {-26, 42}}, color = {0, 0, 127}));
  connect(add.y, abs.u) annotation(
    Line(points = {{-20, 20}, {-20, 12}}, color = {0, 0, 127}));
  connect(abs.y, heading_angle_difference) annotation(
    Line(points = {{-20, -10}, {-20, -30}}, color = {0, 0, 127}));
protected
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-180, 120}, {220, -20}})),
    version = "");
end DriverVehiclePath;
