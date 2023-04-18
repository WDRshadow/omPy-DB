import openmdao.api as om

import config
from openMDAO.FWoptimiser import FWOptimise
from module.fileAPI import FileAPI
from module.logger import logger


def run_optimization():
    # initialize the logger and output file Builder.
    log = logger

    counter = FileAPI(config.tempPath, 'optimization.out').builder()
    counter.writeLine('draft column23_mass PtfmSway PtfmSurge PtfmHeave PtfmRoll PtfmPitch PtfmYaw')

    # check and delete the input.dat file.
    f = FileAPI(config.tempPath, 'input.dat')
    if f.isExist():
        f.logger.info('Removing the old input.dat file.')
        f.remove()

    # initialize the model
    prob = om.Problem()
    model = prob.model

    # register the subsystem
    prob.model.add_subsystem('semi_sub', FWOptimise(counter))

    # Adding the design variables
    model.add_design_var('semi_sub.column1_mass', upper=4.5, lower=2.5)
    model.add_design_var('semi_sub.draft', upper=0.4, lower=0.2)  # the limitation should be corrected

    # Adding the objective functions
    model.add_objective('semi_sub.B1Sway')
    model.add_objective('semi_sub.B1Surge')
    model.add_objective('semi_sub.B1Heave')
    model.add_objective('semi_sub.B1Roll')
    model.add_objective('semi_sub.B1Pitch')
    model.add_objective('semi_sub.B1Yaw')

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

    column1_mass = prob.get_val('semi_sub.column1_mass')
    draft = prob.get_val('semi_sub.draft')

    log.info('The results are shown below.')
    log.info(f'column1_mass {column1_mass}')
    log.info(f'draft {draft}')

    FileAPI(config.tempPath, 'optimization_result.dat').builder() \
        .writeLine(f'draft {draft}') \
        .writeLine(f'column1_mass {column1_mass}') \
        .write() \
        .logger.info(f'The optimization result has been saved in the file optimization_result.dat in temp folder.')
