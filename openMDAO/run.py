import openmdao.api as om

import config
from openMDAO.DBoptimiser import FWOptimise
from module.fileAPI import FileAPI
from module.logger import logger


def run_optimization():
    # initialize the logger and output file Builder.
    log = logger

    counter = FileAPI(config.tempPath, 'optimization.out').builder()
    counter\
        .writeLine('parameters                      output_data')\
        .writeLine('g_p g_c T_L T_l t_a T_N K_r K_t heading_angle_difference')

    # check and delete the input.dat file.
    f = FileAPI(config.tempPath, 'DB_parameters.dat')
    if f.isExist():
        f.logger.info('Removing the old DB_parameters.dat file.')
        f.remove()

    # initialize the model
    prob = om.Problem()
    model = prob.model

    # register the subsystem
    prob.model.add_subsystem('om_db', FWOptimise(counter))

    # Adding the design variables
    model.add_design_var('om_db.g_p', upper=2.5, lower=5)
    model.add_design_var('om_db.g_c', upper=0, lower=20)
    model.add_design_var('om_db.T_L', upper=1, lower=5)
    model.add_design_var('om_db.T_l', upper=0.5, lower=1.5)
    model.add_design_var('om_db.t_a', upper=0.02, lower=0.05)
    model.add_design_var('om_db.T_N', upper=0.05, lower=0.15)
    model.add_design_var('om_db.K_r', upper=0.1, lower=0.5)
    model.add_design_var('om_db.K_t', upper=0.3, lower=0.7)

    # Adding the objective functions
    model.add_objective('om_db.heading_diff')

    # Setting the optimisation algorithm to use, in this case a differential evolutionary algorithm
    prob.driver = om.DifferentialEvolutionDriver()
    prob.driver.options['pop_size'] = 10
    prob.driver.options['max_gen'] = 10
    prob.driver.options['F'] = 0.5
    prob.driver.options['Pc'] = 0.5

    prob.setup()
    prob.run_driver()

    # Returning variable outputs at the point optimiser completes and save in an output file
    counter.write()
    log.info('Run optimization success.')
