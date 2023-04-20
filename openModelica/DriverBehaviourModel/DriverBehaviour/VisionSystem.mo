within DriverBehaviourModel.DriverBehaviour;

model VisionSystem
  parameter Real g_p(unit="1")=3.4 "Preview gain.";
  parameter Real g_c(unit="1")=15 "Human control gain.";
  parameter Real T_L(unit="1")=3 "Lead equalization time constant";
  parameter Real T_l(unit="1")=1 "Lag equalization time constant";
  parameter Real t_a(unit="1")=0.03 "Vision system processing time delay.";
  parameter Real v(unit="m/s")=24 "Vehicle speed.";
  Modelica.Blocks.Math.Gain gain_preview(k = g_p)  annotation(
    Placement(visible = true, transformation(origin = {-70, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction transfer_function_compensatory(a = {T_l, 1}, b = {T_L, 1})  annotation(
    Placement(visible = true, transformation(origin = {-30, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_compensatory(k = g_c / v)  annotation(
    Placement(visible = true, transformation(origin = {-70, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add_vision annotation(
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction vision_delay(a = {0.5 * t_a, 1}, b = {-0.5 * t_a, 1})  annotation(
    Placement(visible = true, transformation(origin = {54, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.AngleRealInput near_angle annotation(
    Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.AngleRealInput far_angle annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.AngleRealOutput desired_angle annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(gain_compensatory.y, transfer_function_compensatory.u) annotation(
    Line(points = {{-58, -40}, {-42, -40}}, color = {0, 0, 127}));
  connect(gain_preview.y, add_vision.u1) annotation(
    Line(points = {{-59, 40}, {-2, 40}, {-2, 6}}, color = {0, 0, 127}));
  connect(transfer_function_compensatory.y, add_vision.u2) annotation(
    Line(points = {{-18, -40}, {-2, -40}, {-2, -6}}, color = {0, 0, 127}));
  connect(add_vision.y, vision_delay.u) annotation(
    Line(points = {{22, 0}, {42, 0}}, color = {0, 0, 127}));
  connect(far_angle, gain_preview.u) annotation(
    Line(points = {{-120, 40}, {-82, 40}}, color = {255, 0, 0}));
  connect(near_angle, gain_compensatory.u) annotation(
    Line(points = {{-120, -40}, {-82, -40}}, color = {255, 0, 0}));
  connect(desired_angle, vision_delay.y) annotation(
    Line(points = {{110, 0}, {66, 0}}, color = {255, 0, 0}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Text(origin = {0, -80}, lineColor = {0, 0, 255}, extent = {{-100, 20}, {100, -20}}, textString = "%name", fontSize = 20), Ellipse(origin = {0, -1}, fillColor = {153, 163, 170}, fillPattern = FillPattern.Solid, extent = {{-80, 41}, {80, -41}}), Ellipse(origin = {0, -1}, fillPattern = FillPattern.Solid, extent = {{-30, 31}, {30, -31}}), Line(origin = {-50.46, 0}, points = {{-49.5358, 40}, {50.4642, 0}, {-49.5358, -40}, {-49.5358, -40}}, color = {255, 0, 0}, pattern = LinePattern.Dash, thickness = 0.75), Line(origin = {90, 0}, points = {{-10, 0}, {10, 0}, {10, 0}}, color = {255, 0, 0}, thickness = 0.75)}),
  Diagram);
end VisionSystem;
