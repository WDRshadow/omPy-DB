"""
FWoptimiser is a component that used for optimize the offshore wind turbine.

@author: angusrobertson
"""

import openmdao.api as om

import config
from module.logger import logger
from module.fileAPI import FileAPI, Builder
from openModelica.DriverBehaviourOM import OMModel


class FWOptimise(om.ExternalCodeComp):
    def __init__(self, counter: Builder, **kwargs):
        super().__init__(**kwargs)
        # Specifying pre-existing input & output files
        self.output_file = 'wow_main.out'
        self.input_file = 'input.dat'
        self.counter = counter

    def setup(self):
        self.add_input('column1_mass', val=config.input_data['column1_mass'])
        self.add_input('draft', val=config.input_data['draft'])

        # add outputs here: Sway, Surge, Heave, Roll, Pitch, Yaw
        self.add_output('B1Sway', val=0.0)  # PtfmSway
        self.add_output('B1Surge', val=0.0)  # PtfmSurge
        self.add_output('B1Heave', val=0.0)  # PtfmHeave
        self.add_output('B1Roll', val=0.0)  # PtfmRoll
        self.add_output('B1Pitch', val=0.0)  # PtfmPitch
        self.add_output('B1Yaw', val=0.0)  # PtfmYaw

        # This calls an external python script containing the Python-FAST interface
        self.options['command'] = 'python run.py run'

    def compute(self, inputs, outputs):
        # Get from config file because the parameters do not change in the optimization
        column_radius = config.input_data['column_radius']
        column_height = config.input_data['column_height']
        platform_mass = config.input_data['platform_mass']
        tower_height = config.input_data['tower_height']
        plt_d = config.input_data['plt_d']
        hp_radius = config.input_data['hp_radius']
        turbine_mass = config.input_data['turbine_mass']
        connection_bars = config.input_data['connection_bars']
        tower_mass = config.input_data['tower_mass']
        ballast_height_1 = config.input_data['ballast_height_1']
        ballast_height_23 = config.input_data['ballast_height_23']
        depth = config.input_data['depth']
        if config.flag == "small":
            E_mooringline = config.input_data['E_mooringline']
            D_mooringline = config.input_data['D_mooringline']
            rou_mooringline = config.input_data['rou_mooringline']
        else:
            E_mooringline, D_mooringline, rou_mooringline = 0, 0, 0

        # Get from input variables
        draft = inputs['draft'][0]
        column1_mass = inputs['column1_mass'][0]
        column23_mass = (column1_mass + tower_mass + turbine_mass) * 2

        # save the input data into a file
        FileAPI(config.tempPath, self.input_file).builder() \
            .writeLine(f'column_radius {column_radius}') \
            .writeLine(f'column_height {column_height}') \
            .writeLine(f'platform_mass {platform_mass}') \
            .writeLine(f'tower_height {tower_height}') \
            .writeLine(f'plt_d {plt_d}') \
            .writeLine(f'draft {draft}') \
            .writeLine(f'hp_radius {hp_radius}') \
            .writeLine(f'turbine_mass {turbine_mass}') \
            .writeLine(f'column1_mass {column1_mass}') \
            .writeLine(f'column23_mass {column23_mass}') \
            .writeLine(f'connection_bars {connection_bars}') \
            .writeLine(f'tower_mass {tower_mass}') \
            .writeLine(f'ballast_height_1 {ballast_height_1}') \
            .writeLine(f'ballast_height_23 {ballast_height_23}') \
            .writeLine(f'depth {depth}') \
            .writeLine(f'E_mooringline {E_mooringline}') \
            .writeLine(f'D_mooringline {D_mooringline}') \
            .writeLine(f'rou_mooringline {rou_mooringline}') \
            .write()

        # run simulation
        logger.info(f'\n----------------------------------------------------------------- \n'
                    f'Running simulation with variable \'draft\'  {draft}. \n'
                    f'and \'column1_mass\' {column1_mass}. \n'
                    f'-----------------------------------------------------------------')
        try:
            super().compute(inputs, outputs)
        except Exception as err:
            logger.error("Run simulation fail. Exiting the process.")
            logger.error(err)
            exit()

        output_data = OMModel.read_output()
        # output_data = Main(Main.read_input()).run().read_output()

        # raed and save the simulation output data, each variable will be a list.
        outputs['B1Sway'] = max(list(map(abs, output_data['PtfmSway'])))
        outputs['B1Surge'] = max(list(map(abs, output_data['PtfmSurge'])))
        outputs['B1Heave'] = max(list(map(abs, output_data['PtfmHeave'])))
        outputs['B1Roll'] = max(list(map(abs, output_data['PtfmRoll'])))
        outputs['B1Pitch'] = max(list(map(abs, output_data['PtfmPitch'])))
        outputs['B1Yaw'] = max(list(map(abs, output_data['PtfmYaw'])))

        # record the data in this simulation

        self.counter.writeLine('{} {} {} {} {} {} {} {}'.format(str(draft), str(column23_mass),
                                                                str(outputs['B1Sway'][0]), str(outputs['B1Surge'][0]),
                                                                str(outputs['B1Heave'][0]), str(outputs['B1Roll'][0]),
                                                                str(outputs['B1Pitch'][0]), str(outputs['B1Yaw'][0])))

        logger.info('-----------------------------------------------------------------')
        logger.info(f'The simulation results are shown below:')
        logger.info('Max PtfmSway: {}'.format(outputs['B1Sway']))
        logger.info('Max PtfmSurge: {}'.format(outputs['B1Surge']))
        logger.info('Max PtfmHeave: {}'.format(outputs['B1Heave']))
        logger.info('Max PtfmRoll: {}'.format(outputs['B1Roll']))
        logger.info('Max PtfmPitch: {}'.format(outputs['B1Pitch']))
        logger.info('Max PtfmYaw: {}'.format(outputs['B1Yaw']))
        logger.info('-----------------------------------------------------------------')
