import os
import sys

# Check if all the folders exist.
folder_list = ["temp", "logs"]
for i in folder_list:
    folder = os.path.exists(i)
    if not folder:
        os.makedirs(i)

from module.logger import logger


# error message for wrong commands
def error():
    logger.info("\nCommand list: \n"
                "1. om - Run openModelica simulation. \n"
                "2. mdao - Run openMDAO optimization. \n"
                "3. help - Get command list.")


if len(sys.argv) < 2:
    error()
    exit()

# command filter
if str(sys.argv[1]) == "mdao":
    from openMDAO.run import run_optimization

    try:
        run_optimization()
    except Exception as err:
        logger.error(err)

elif str(sys.argv[1]) == "om":
    from openModelica.DriverBehaviourOM import OMModel

    try:
        OMModel().update(OMModel.read_input()).update(OMModel.read_input()).run()
    except Exception as err:
        logger.error(err)

else:
    error()
