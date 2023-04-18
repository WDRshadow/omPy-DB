import os
import sys

# Check if all the folders exist.
folder_list = ["temp", "logs"]
for i in folder_list:
    folder = os.path.exists(i)
    if not folder:
        os.makedirs(i)

from module import logger


# error message for wrong commands
def error():
    logger.logger.info("\nCommand list: \n"
                       "1. om - Run openModelica simulation. \n"
                       "2. mdao - Run openMDAO optimization.")


if len(sys.argv) < 2:
    error()
    exit()

# command filter
if str(sys.argv[1]) == "mdao":
    from openMDAO import run as runMDAO

    try:
        runMDAO.run_optimization()
    except Exception as err:
        logger.logger.error(err)

elif str(sys.argv[1]) == "om":
    from openModelica import run as runOM

    try:
        runOM.run_simulation()
    except Exception as err:
        logger.logger.error(err)

else:
    error()
