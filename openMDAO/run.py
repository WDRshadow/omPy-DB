import openmdao.api as om

import config
from openMDAO.DBoptimiser import OMOptimise
from module.fileAPI import FileAPI


def run_optimization():
    # initialize the logger and output file Builder.
    counter = FileAPI(config.tempPath, 'optimization.csv').builder()
    counter.writeLine('g_p,g_c,T_L,T_l,t_a,T_N,K_r,K_t,heading_diff_mean,heading_diff_max')

    # check and delete the DB_parameters.dat file.
    f = FileAPI(config.tempPath, 'DB_parameters.dat')
    if f.isExist():
        f.logger.info('Removing the old DB_parameters.dat file.')
        f.remove()

    # initialize the model
    prob = om.Problem()
    model = prob.model

    # register the subsystem
    prob.model.add_subsystem('om_db', OMOptimise(counter))

    # Adding the design variables
    model.add_design_var('om_db.g_p', lower=2.5, upper=5)
    model.add_design_var('om_db.g_c', lower=0, upper=20)
    # model.add_design_var('om_db.T_L', lower=1, upper=5)
    # model.add_design_var('om_db.T_l', lower=0.05, upper=0.15)
    # model.add_design_var('om_db.t_a', lower=0.02, upper=0.05)
    # model.add_design_var('om_db.T_N', lower=0.05, upper=0.15)
    model.add_design_var('om_db.K_r', lower=0.1, upper=0.5)
    model.add_design_var('om_db.K_t', lower=0.3, upper=0.7)

    # Adding the objective functions
    model.add_objective('om_db.heading_diff_max')
    model.add_objective('om_db.heading_diff_mean')

    # Setting the optimisation algorithm to use, in this case a differential evolutionary algorithm
    prob.driver = om.DifferentialEvolutionDriver()
    prob.driver.options['pop_size'] = config.pop_size
    prob.driver.options['max_gen'] = config.max_gen
    prob.driver.options['F'] = 0.5
    prob.driver.options['Pc'] = 0.5

    prob.setup()
    prob.run_driver()

    # Returning variable outputs at the point optimiser completes and save in an output file
    counter.write()

    f = FileAPI(config.tempPath, 'DB_parameters.dat')
    f.logger.info('Run optimization success.')
    if f.isExist():
        f.logger.info('Removing the old DB_parameters.dat file.')
        f.remove()
