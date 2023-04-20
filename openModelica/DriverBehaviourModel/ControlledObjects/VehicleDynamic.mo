within DriverBehaviourModel.ControlledObjects;

model VehicleDynamic
  parameter Real m(unit = "kg") = 1100 "Vehicle mass;";
  parameter Real v(unit = "m/s") = 24 "Vehicle speed;";
  parameter Real l_f(unit = "m") = 1 "Longitudinal position of front wheels to centre of gravity of vehicle;";
  parameter Real l_r(unit = "m") = 1.635 "Longitudinal position of rear wheels to centre of gravity of vehicle";
  parameter Real K_f(unit = "N/rad") = 53300 "Cornering stiffness of front tire";
  parameter Real K_b(unit = "N/rad") = 117000 "Cornering stiffness of rear tire";
  parameter Real I(unit = "kgm2") = 2940 "Yaw moment inertia of vehicle";
  parameter Real E_t(unit = "1") = 0.026 "Sum of pneumatic and castor trail";
  parameter Real K_s(unit = "Nm/rad") = 48510 "Spring constant converted around the kingpin";
  parameter Real K_h(unit = "1") = 1 / 17 "Transmission ratio between steering wheel angle and front wheel steering angle";
  Real K_a(unit = "kgm2") "Cornering stiffness of self-aligning aligning_torque";
  Modelica.Blocks.Interfaces.RealOutput yaw_rate annotation(
    Placement(visible = true, transformation(origin = {110, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.AngleRealOutput side_slip_angle annotation(
    Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.AngleRealInput front_wheel_angle annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.TorqueRealOutput aligning_torque annotation(
    Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {0, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
initial equation
  der(side_slip_angle) = 0;
  der(yaw_rate) = 0;
equation
  m * v * der(side_slip_angle) + 2 * (K_f + K_b) * side_slip_angle + (m * v + 2 / v * (l_f * K_f - l_r * K_b)) * yaw_rate = 2 * K_f * front_wheel_angle;
  2 * (l_f * K_f - l_r * K_b) * side_slip_angle + I * der(yaw_rate) + 2 * (l_f ^ 2 * K_f + l_r ^ 2 * K_b) * yaw_rate / v = 2 * l_f * K_f * front_wheel_angle;
  aligning_torque = K_a * (side_slip_angle + l_f * yaw_rate / v - front_wheel_angle);
  K_a = 2 * E_t * K_f * K_h * (1 / (1 + 2 * E_t * K_f / K_s));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Rectangle(origin = {70, 50}, rotation = 15, fillColor = {144, 144, 144}, fillPattern = FillPattern.VerticalCylinder, extent = {{-30, 10}, {30, -10}}), Line(origin = {1, 0}, points = {{-71, 0}, {71, 0}, {71, 0}}, thickness = 1), Rectangle(origin = {-70, 50}, fillColor = {144, 144, 144}, fillPattern = FillPattern.VerticalCylinder, extent = {{-30, 10}, {30, -10}}), Rectangle(origin = {70, -50}, rotation = 15, fillColor = {144, 144, 144}, fillPattern = FillPattern.VerticalCylinder, extent = {{-30, 10}, {30, -10}}), Rectangle(origin = {-70, -50}, fillColor = {144, 144, 144}, fillPattern = FillPattern.VerticalCylinder, extent = {{-30, 10}, {30, -10}}), Line(origin = {-70, 0}, points = {{0, 40}, {0, -40}, {0, -40}}, thickness = 1), Line(origin = {72, 0}, points = {{0, 40}, {0, -40}, {0, -40}}, thickness = 1), Text(origin = {0, -80}, lineColor = {0, 0, 255}, extent = {{-100, 20}, {100, -20}}, textString = "%name", fontSize = 20), Rectangle(fillColor = {186, 196, 200}, fillPattern = FillPattern.Solid, borderPattern = BorderPattern.Raised, extent = {{-80, 50}, {80, -50}}, radius = 5), Polygon(origin = {34, 0}, fillColor = {144, 144, 144}, fillPattern = FillPattern.Solid, points = {{0, 32}, {10, 20}, {10, -20}, {0, -32}, {-16, -20}, {-16, 20}, {0, 32}, {0, 32}}), Polygon(origin = {10, 26}, fillColor = {144, 144, 144}, fillPattern = FillPattern.Solid, points = {{20, 6}, {4, -6}, {-20, -6}, {-20, 6}, {-20, 6}, {20, 6}}), Polygon(origin = {10, -25}, fillColor = {144, 144, 144}, fillPattern = FillPattern.Solid, points = {{20, -7}, {4, 5}, {-20, 5}, {-20, -7}, {-20, -7}, {20, -7}}), Rectangle(origin = {-43, 0}, lineColor = {144, 144, 144}, fillPattern = FillPattern.HorizontalCylinder, extent = {{31, 32}, {-31, -32}}), Polygon(origin = {62, 0}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, points = {{-18, 20}, {18, 14}, {18, -14}, {-18, -20}, {-18, 20}, {-18, 20}}), Polygon(origin = {-1, 43}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-31, 7}, {31, 7}, {21, -7}, {-23, -7}, {-31, 7}, {-31, 7}}), Polygon(origin = {0, -43}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-30, -7}, {30, -7}, {22, 7}, {-24, 7}, {-30, -7}, {-30, -7}})}));
end VehicleDynamic;
