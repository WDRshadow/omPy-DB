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
pop_size = 10
max_gen = 10
# -------------------------------
# Initial Conditions
inputParameters = {
    'g_p': 3.472,
    'g_c': 1.111,
    'T_L': 3,
    'T_l': 1,
    't_a': 0.03,
    'T_N': 0.1,
    'K_r': 0.389,
    'K_t': 0.367
}
# -------------------------------
