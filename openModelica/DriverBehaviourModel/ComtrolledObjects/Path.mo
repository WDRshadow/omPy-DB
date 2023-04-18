within DriverBehaviourModel.ComtrolledObjects;

model Path
  parameter Real t_f(unit = "s") = 1 "Far point time";
  parameter Real t_n(unit = "s") = 0.1 "Near point time";
  Interfaces.AngleRealInput vehicle_side_slip_angle annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vehicle_yaw_rate annotation(
    Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Interfaces.AngleRealOutput near_angle annotation(
    Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.AngleRealOutput far_angle annotation(
    Placement(visible = true, transformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.AngleRealOutput heading_angle annotation(
    Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
initial equation
  vehicle_side_slip_angle = 0;
  vehicle_yaw_rate = 0;
equation
  der(far_angle) = sin(vehicle_side_slip_angle) / t_f + vehicle_yaw_rate;
  der(near_angle) = sin(vehicle_side_slip_angle) / t_n + vehicle_yaw_rate;
  der(heading_angle) = vehicle_yaw_rate;
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Rectangle(fillColor = {144, 144, 144}, fillPattern = FillPattern.Solid, extent = {{-100, 60}, {100, -60}}), Rectangle(origin = {-70, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-30, 10}, {30, -10}}), Rectangle(origin = {10, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-30, 10}, {30, -10}}), Rectangle(origin = {80, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}}), Text(origin = {0, 80}, lineColor = {0, 0, 255}, extent = {{-100, 20}, {100, -20}}, textString = "%name")}));
end Path;
