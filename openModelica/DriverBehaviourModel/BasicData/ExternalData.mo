within DriverBehaviourModel.BasicData;

model ExternalData
  parameter String farAngleFile = "" "File where far angle data is stored" annotation(
    Dialog(
      loadSelector(filter="Comma-separated values files (*.csv);;Text files (*.txt)",
      caption="Open file")));
  parameter String nearAngleFile = "" "File where near angle data is stored" annotation(
    Dialog(
      loadSelector(filter="Comma-separated values files (*.csv);;Text files (*.txt)",
      caption="Open file")));
  parameter String headingAngleFile = "" "File where reference heading angle data is stored" annotation(
    Dialog(
      loadSelector(filter="Comma-separated values files (*.csv);;Text files (*.txt)",
      caption="Open file")));
  DriverBehaviourModel.Interfaces.AngleRealInput heading_angle annotation(
    Placement(visible = true, transformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {0, -120}, extent = {{20, -20}, {-20, 20}}, rotation = -90)));
  DriverBehaviourModel.Interfaces.AngleRealOutput far_angle annotation(
    Placement(visible = true, transformation(origin = {110, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.AngleRealOutput near_angle annotation(
    Placement(visible = true, transformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DriverBehaviourModel.Interfaces.AngleRealOutput heading_angle_output annotation(
    Placement(visible = true, transformation(origin = {-110, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {-110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  DriverBehaviourModel.Interfaces.AngleRealOutput heading_angle_reference annotation(
    Placement(visible = true, transformation(origin = {-110, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {-110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  DriverBehaviourModel.Interfaces.AngleRealOutput heading_angle_difference annotation(
    Placement(visible = true, transformation(origin = {-110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {-110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  inner parameter ExternData.CSVFile far(fileName = farAngleFile, nHeaderLines = 1) annotation(
    Placement(visible = true, transformation(origin = {-10, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner parameter ExternData.CSVFile near(fileName = nearAngleFile, nHeaderLines = 1) annotation(
    Placement(visible = true, transformation(origin = {-10, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable timeTable_near(table = near.getRealArray2D(458, 2)) annotation(
    Placement(visible = true, transformation(origin = {70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner parameter ExternData.CSVFile heading(fileName = headingAngleFile, nHeaderLines = 1) annotation(
    Placement(visible = true, transformation(origin = {70, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable timeTable_far(table = far.getRealArray2D(458, 2)) annotation(
    Placement(visible = true, transformation(origin = {30, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.TimeTable timeTable_heading(table = heading.getRealArray2D(458, 2)) annotation(
    Placement(visible = true, transformation(origin = {30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Math.Abs abs annotation(
    Placement(visible = true, transformation(origin = {-50, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Math.Add add(k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {-10, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
equation
  connect(timeTable_near.y, near_angle) annotation(
    Line(points = {{82, 70}, {110, 70}}, color = {0, 0, 127}));
  connect(timeTable_far.y, far_angle) annotation(
    Line(points = {{42, 90}, {110, 90}}, color = {0, 0, 127}));
  connect(timeTable_heading.y, add.u2) annotation(
    Line(points = {{20, -50}, {10, -50}, {10, -44}, {2, -44}}, color = {0, 0, 127}));
  connect(add.y, abs.u) annotation(
    Line(points = {{-20, -50}, {-38, -50}}, color = {0, 0, 127}));
  connect(abs.y, heading_angle_difference) annotation(
    Line(points = {{-60, -50}, {-110, -50}}, color = {0, 0, 127}));
  connect(heading_angle_reference, timeTable_heading.y) annotation(
    Line(points = {{-110, -28}, {10, -28}, {10, -50}, {20, -50}}, color = {255, 0, 0}));
  connect(heading_angle_output, heading_angle) annotation(
    Line(points = {{-110, -10}, {-80, -10}, {-80, -80}, {0, -80}, {0, -120}}, color = {255, 0, 0}));
  connect(heading_angle_output, add.u1) annotation(
    Line(points = {{-110, -10}, {10, -10}, {10, -56}, {2, -56}}, color = {255, 0, 0}));
  annotation(
    Icon(graphics = {Line(points = {{-40, 90}, {-90, 40}, {-90, -90}, {90, -90}, {90, 90}, {-40, 90}}), Polygon(fillPattern = FillPattern.Solid, points = {{-40, 90}, {-40, 40}, {-90, 40}, {-40, 90}}), Text(origin = {0, -40}, lineColor = {186, 196, 200}, extent = {{-80, 40}, {80, -40}}, textString = "%name")}));
end ExternalData;
