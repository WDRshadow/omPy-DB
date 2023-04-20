within DriverBehaviourModel.ControlledObjects;

model Path
  parameter Real t_f(unit = "s") = 1 "Far point time";
  parameter Real t_n(unit = "s") = 0.1 "Near point time";
  parameter Real v(unit = "m/s") = 24 "Vehicle Speed.";
  Interfaces.AngleRealInput vehicle_side_slip_angle annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vehicle_yaw_rate annotation(
    Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.AngleRealOutput heading_angle annotation(
    Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -70}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput x annotation(
    Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation(
    Placement(visible = true, transformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
initial equation
  vehicle_side_slip_angle = 0;
  vehicle_yaw_rate = 0;
equation
  der(heading_angle) = vehicle_yaw_rate;
  der(y) = v * Modelica.Math.sin(heading_angle);
  der(x) = v * Modelica.Math.cos(heading_angle);
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Rectangle(fillColor = {144, 144, 144}, fillPattern = FillPattern.Solid, extent = {{-100, 60}, {100, -60}}), Rectangle(origin = {-70, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-30, 10}, {30, -10}}), Rectangle(origin = {10, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-30, 10}, {30, -10}}), Rectangle(origin = {80, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-20, 10}, {20, -10}}), Text(origin = {0, 80}, lineColor = {0, 0, 255}, extent = {{-100, 20}, {100, -20}}, textString = "%name", fontSize = 20)}));
end Path;
