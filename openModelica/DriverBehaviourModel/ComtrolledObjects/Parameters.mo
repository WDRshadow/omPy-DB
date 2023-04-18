within DriverBehaviourModel.ComtrolledObjects;

record Parameters
  import Modelica.Units.SI;
  extends Modelica.Icons.Record;
  parameter SI.Velocity vehicleSpeed=24 "Vehicle Speed.";
  parameter SI.Mass vehicleMass=1100 "Velocity mass.";
  parameter Real g_p(unit="1")=3.4 "Preview gain.";
  parameter Real g_c(unit="1")=15 "Human control gain.";
  parameter Real T_L(unit="1")=3 "Lead equalization time constant";
  parameter Real T_l(unit="1")=1 "Lag equalization time constant";
  parameter Real t_a(unit="1")=0.03 "Vision system processing time delay.";
  parameter Real T_N(unit="1")=0.1 "Neuromuscular time constant.";
  parameter Real K_r(unit="1")=0.3 "Torque coefficient.";
  parameter Real K_t(unit="1")=0.5 "Stretch reflex.";
  parameter Real J_s(unit="1")=0.11 "Moment inertia of steering system.";
  parameter Real B_s(unit="1")=0.57 "Damping of steering system.";
  parameter Real K_h(unit="1")=1/17 "Transmission ratio between steering wheel angle and front wheel steering angle.";
  parameter Real l_f(unit = "m") = 1 "Longitudinal position of front wheels to centre of gravity of vehicle;";
  parameter Real l_r(unit = "m") = 1.635 "Longitudinal position of rear wheels to centre of gravity of vehicle";
  parameter Real K_f(unit = "N/rad") = 53300 "Cornering stiffness of front tire";
  parameter Real K_b(unit = "N/rad") = 117000 "Cornering stiffness of rear tire";
  parameter Real I(unit = "kgm2") = 2940 "Yaw moment inertia of vehicle";
  parameter Real E_t(unit = "1") = 0.026 "Sum of pneumatic and castor trail";
  parameter Real K_s(unit = "Nm/rad") = 48510 "Spring constant converted around the kingpin";
  parameter Real t_f(unit = "s") = 1 "Far point time";
  parameter Real t_n(unit = "s") = 0.1 "Near point time";
end Parameters;
