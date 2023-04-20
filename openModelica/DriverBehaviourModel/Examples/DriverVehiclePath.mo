within DriverBehaviourModel.Examples;

model DriverVehiclePath
  extends Modelica.Icons.Example;
  DriverBehaviourModel.ControlledObjects.VehicleDynamic vehicleDynamic(E_t = parameters.E_t, I = parameters.I, K_b = parameters.K_b, K_f = parameters.K_f, K_h = parameters.K_h, K_s = parameters.K_s, l_f = parameters.l_f, l_r = parameters.l_r,m = parameters.vehicleMass, v = parameters.vehicleSpeed)  annotation(
    Placement(visible = true, transformation(origin = {140, 10}, extent = {{30, -30}, {-30, 30}}, rotation = 0)));
  DriverBehaviourModel.ControlledObjects.Path path(t_f = parameters.t_f, t_n = parameters.t_n, v = parameters.vehicleSpeed)  annotation(
    Placement(visible = true, transformation(origin = {10, 10}, extent = {{30, -30}, {-30, 30}}, rotation = 0)));
  DriverBehaviourModel.DriverBehaviour.VisionSystem visionSystem(T_L = parameters.T_L, T_l = parameters.T_l, g_c = parameters.g_c, g_p = parameters.g_p, t_a = parameters.t_a, v = parameters.vehicleSpeed)  annotation(
    Placement(visible = true, transformation(origin = {-40, 90}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  DriverBehaviourModel.DriverBehaviour.NeuromuscularSystem neuromuscularSystem(K_r = parameters.K_r, K_t = parameters.K_t, T_N = parameters.T_N, v = parameters.vehicleSpeed)  annotation(
    Placement(visible = true, transformation(origin = {50, 90}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  DriverBehaviourModel.ControlledObjects.SteeringSystem steeringSystem(B_s = parameters.B_s, J_s = parameters.J_s, K_h = parameters.K_h)  annotation(
    Placement(visible = true, transformation(origin = {140, 90}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  BasicData.Parameters parameters(K_r= 0.188 ,K_t= 0.684 ,g_c= 0 ,g_p= 4.9 )annotation(
    Placement(visible = true, transformation(origin = {-170, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DriverBehaviourModel.BasicData.ExternalData dataProcess(farAngleFile = "C:/Users/WDRshadow/OneDrive - University of Edinburgh/2022-23-SMS2/final/Final_Project/data/far1.csv", headingAngleFile = "C:/Users/WDRshadow/OneDrive - University of Edinburgh/2022-23-SMS2/final/Final_Project/data/heading1.csv", nearAngleFile = "C:/Users/WDRshadow/OneDrive - University of Edinburgh/2022-23-SMS2/final/Final_Project/data/near1.csv")  annotation(
    Placement(visible = true, transformation(origin = {-130, 50}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
equation
  connect(steeringSystem.aligning_torque, vehicleDynamic.aligning_torque) annotation(
    Line(points = {{140, 66}, {140, 24}}));
  connect(vehicleDynamic.side_slip_angle, path.vehicle_side_slip_angle) annotation(
    Line(points = {{113, 19}, {46, 19}}, color = {255, 0, 0}));
  connect(vehicleDynamic.yaw_rate, path.vehicle_yaw_rate) annotation(
    Line(points = {{113, 1}, {46, 1}}, color = {0, 0, 127}));
  connect(visionSystem.desired_angle, neuromuscularSystem.desired_angle) annotation(
    Line(points = {{-7, 90}, {32, 90}}, color = {255, 0, 0}));
  connect(neuromuscularSystem.torque_output, steeringSystem.torque_input) annotation(
    Line(points = {{71, 90}, {113, 90}}));
  connect(path.heading_angle, dataProcess.heading_angle) annotation(
    Line(points = {{10, -11}, {10, -16}, {-130, -16}, {-130, 14}}, color = {255, 0, 0}));
  connect(steeringSystem.steering_wheel_angle, neuromuscularSystem.steering_wheel_angle) annotation(
    Line(points = {{107, 75}, {50, 75}, {50, 82}}, color = {255, 0, 0}));
  connect(steeringSystem.front_wheel_angle, vehicleDynamic.front_wheel_angle) annotation(
    Line(points = {{164, 90}, {180, 90}, {180, 10}, {170, 10}}, color = {255, 0, 0}));
  connect(dataProcess.far_angle, visionSystem.far_angle) annotation(
    Line(points = {{-98, 76}, {-90, 76}, {-90, 102}, {-76, 102}}, color = {255, 0, 0}));
  connect(dataProcess.near_angle, visionSystem.near_angle) annotation(
    Line(points = {{-98, 70}, {-86, 70}, {-86, 78}, {-76, 78}}, color = {255, 0, 0}));
protected
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-180, 120}, {180, -20}})),
    version = "");
end DriverVehiclePath;
