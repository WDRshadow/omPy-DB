# Basic setting
log = True
tempPath = 'temp'
openModelicaPath = 'openModelica'
packagePath = 'openModelica/DriverBehaviourModel/package.mo'
model = 'DriverBehaviourModel.Examples.DriverVehiclePath'
startTime = 0
stopTime = 15
outputVariable = 'heading_angle_difference'
outputFileName = 'DB'
# -------------------------------
# Initial Conditions
inputParameters = {
    'g_p': 3.4,
    'g_c': 0,
    'T_L': 3,
    'T_l': 0.1,
    't_a': 0.03,
    'T_N': 0.1,
    'K_r': 0.3,
    'K_t': 0.4
}
# -------------------------------
