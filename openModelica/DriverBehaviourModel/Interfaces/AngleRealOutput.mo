within DriverBehaviourModel.Interfaces;

connector AngleRealOutput = output Real "'output Real' as connector" annotation (
  defaultComponentName="y",
  Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100, -100},{100, 100}}),
      graphics={Polygon(lineColor = {255, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}),
  Diagram(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100, -100},{100, 100}}),
      graphics={Polygon(lineColor = {255, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}),
    Text(lineColor = {0, 0, 127}, extent = {{30, 60}, {30, 110}}, textString = "%name")}),
  Documentation(info="<html>
<p>
Connector with one output signal of type Real.
</p>
</html>"));
