import openmdao.api as om

import config
from module.logger import logger
from module.fileAPI import FileAPI, Builder
from openModelica.DriverBehaviourOM import OMModel


class OMOptimise(om.ExternalCodeComp):
    def __init__(self, counter: Builder, **kwargs):
        super().__init__(**kwargs)
        # Specifying pre-existing input & output files
        self.output_file = f'{config.outputFileName}_res.csv'
        self.input_file = 'DB_parameters.dat'
        self.counter = counter

    def setup(self):
        # add inputs here
        self.add_input('g_p', val=config.inputParameters['g_p'])
        self.add_input('g_c', val=config.inputParameters['g_c'])
        # self.add_input('T_L', val=config.inputParameters['T_L'])
        # self.add_input('T_l', val=config.inputParameters['T_l'])
        # self.add_input('t_a', val=config.inputParameters['t_a'])
        # self.add_input('T_N', val=config.inputParameters['T_N'])
        self.add_input('K_r', val=config.inputParameters['K_r'])
        self.add_input('K_t', val=config.inputParameters['K_t'])

        # add outputs here
        self.add_output('heading_diff_mean', val=0.0)
        self.add_output('heading_diff_max', val=0.0)

        # This calls an external python script containing the Python-FAST interface
        self.options['command'] = 'python run.py om'

    def compute(self, inputs, outputs):
        # Get from config file because the parameters do not change in the optimization
        ...
        # Get from input variables
        g_p = round(inputs['g_p'][0], 3)
        g_c = round(inputs['g_c'][0], 3)
        T_L = round(inputs['T_L'][0], 3)
        T_l = round(inputs['T_l'][0], 3)
        t_a = round(inputs['t_a'][0], 3)
        T_N = round(inputs['T_N'][0], 3)
        K_r = round(inputs['K_r'][0], 3)
        K_t = round(inputs['K_t'][0], 3)

        # save the input data into a file
        FileAPI(config.tempPath, self.input_file).builder() \
            .writeLine(f'g_p {g_p}') \
            .writeLine(f'g_c {g_c}') \
            .writeLine(f'T_L {T_L}') \
            .writeLine(f'T_l {T_l}') \
            .writeLine(f't_a {t_a}') \
            .writeLine(f'T_N {T_N}') \
            .writeLine(f'K_r {K_r}') \
            .writeLine(f'K_t {K_t}') \
            .write()

        # run simulation
        logger.info(f'\n----------------------------------------------------------------- \n'
                    f'Running simulation with variable {g_p} {g_c} {T_L} {T_l} {t_a} {T_N} {K_r} {K_t}. \n'
                    f'-----------------------------------------------------------------')
        try:
            super().compute(inputs, outputs)
        except Exception as err:
            logger.error("Run simulation fail. Exiting the process.")
            logger.error(err)
            exit()

        # raed and save the simulation output data, each variable will be a list.
        output_diff_max, output_diff_mean = OMModel.read_output()
        outputs['heading_diff_mean'] = output_diff_mean
        outputs['heading_diff_max'] = output_diff_max

        # record the data in this simulation

        self.counter.writeLine(f'{g_p},{g_c},{T_L},{T_l},{t_a},{T_N},{K_r},{K_t},{output_diff_mean},{output_diff_max}')

        logger.info(f'\n----------------------------------------------------------------- \n'
                    f'The simulation results are shown below: \n'
                    f'Max heading angle difference: {output_diff_max} \n'
                    f'Average heading angle difference: {output_diff_mean} \n'
                    f'-----------------------------------------------------------------')
