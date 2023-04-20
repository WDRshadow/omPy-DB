# Basic setting
log = True
tempPath = 'temp'
openModelicaPath = 'openModelica'
packagePath = 'openModelica/DriverBehaviourModel/package.mo'
model = 'DriverBehaviourModel.Examples.DriverVehiclePath'
startTime = 0
stopTime = 15
outputVariable = 'dataProcess.heading_angle_difference'
outputFileName = 'DB'
pop_size = 20
max_gen = 20
# -------------------------------
# Initial Conditions
inputParameters = {
    'g_p': 4.19,
    'g_c': 0.0,
    'T_L': 3,
    'T_l': 1,
    't_a': 0.03,
    'T_N': 0.1,
    'K_r': 0.188,
    'K_t': 0.684
}
# -------------------------------
