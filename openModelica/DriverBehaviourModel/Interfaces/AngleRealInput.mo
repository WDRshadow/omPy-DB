within DriverBehaviourModel.Interfaces;

connector AngleRealInput = input Real "'input Real' as connector" annotation (
  defaultComponentName="u",
  Icon(graphics={Polygon(lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})},
    coordinateSystem(extent={{-100, -100},{100, 100}},
      preserveAspectRatio=true,
      initialScale=0.2)),
  Diagram(
    coordinateSystem(preserveAspectRatio=true,
      initialScale=0.2,
      extent={{-100, -100},{100, 100}}),
      graphics={Polygon(lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}),
    Text(lineColor = {0, 0, 127}, extent = {{-10, 60}, {-10, 85}}, textString = "%name")}),
  Documentation(info="<html>
<p>
Connector with one input signal of type Real.
</p>
</html>"));
