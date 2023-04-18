# Basic setting
log = True
tempPath = 'temp'
packagePath = ['openModelica/DriverBehaviourModel/package.mo']
model = 'DriverBehaviourModel.Examples.DriverVehiclePath'
startTime = 0
stopTime = 15
outputVariable = 'heading_angle_difference'
# -------------------------------
# Initial Conditions
input_data = {
    'g_p': 3.4,
    'g_c': 15,

}
# -------------------------------
