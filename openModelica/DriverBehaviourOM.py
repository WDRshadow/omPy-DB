import os
from OMPython import OMCSessionZMQ

import config
from module.fileAPI import FileAPI
from module.logger import logger


class OMModel:
    def __init__(self):
        """
        This is the Model class for running the openModelica simulation process. \n
        """
        self.logger = logger
        self.omc = OMCSessionZMQ()
        self.packagePath = config.packagePath
        self.model = config.model
        self.startTime = config.startTime
        self.stopTime = config.stopTime
        self.outputVariable = config.outputVariable
        self.outputFileName = config.outputFileName
        # load and initialize the instance
        self.logger.info('loadModel(Modelica):{}'.format(self.omc.sendExpression('loadModel(Modelica)')))
        self.logger.info('loadFile(\"{}\"):{}'
                         .format(self.packagePath, self.omc.sendExpression(f'loadFile(\"{self.packagePath}\")')))

    def update(self, updateData: dict):
        """
        Update the input files of openModelica from the parameter.\n
        :param updateData: a dict that recording the updating data.
        :return: the self Model object.
        """
        self.logger.info('Updating openModelica files.')
        FileAPI(os.path.join(config.openModelicaPath, 'DriverBehaviourModel', 'Examples'),
                'DriverVehiclePath.mo').changer() \
            .change(37, 3, updateData['K_r']) \
            .change(37, 5, updateData['K_t']) \
            .change(37, 7, updateData['T_L']) \
            .change(37, 9, updateData['T_N']) \
            .change(37, 11, updateData['T_l']) \
            .change(37, 13, updateData['g_c']) \
            .change(37, 15, updateData['g_p']) \
            .change(37, 17, updateData['t_a']) \
            .do()
        return self

    def run(self):
        """
        This is the main function to run the openModelica. \n
        :return: the self Model object.
        """
        self.logger.info('Running openModelica.')
        cmds = [
            f'cd(\"{config.tempPath}\")',
            f'simulate('
            f'{self.model}, '
            f'startTime={self.startTime}, '
            f'stopTime={self.stopTime}, '
            f'outputFormat="csv", '
            f'variableFilter=\"{self.outputVariable}\", '
            f'fileNamePrefix=\"{self.outputFileName}\"'
            f')',
            f'plot({self.outputVariable})'
        ]
        for cmd in cmds:
            answer = self.omc.sendExpression(cmd)
            self.logger.info("{}:{}".format(cmd, answer))
        self.logger.info(f'Run completed. The output files have been saved in folder {config.tempPath}.')
        return self

    @classmethod
    def read_input(cls) -> dict:
        """
        Get the initial input data from config file or temp folder. \n
        :return: a dict that recording the simulation input data.
        """
        parameters = config.inputParameters
        outputFile = FileAPI(config.tempPath, 'DB_parameters.dat')
        if outputFile.isExist():
            inputData = outputFile.reader() \
                .read(1, 2).read(2, 2).read(3, 2).read(4, 2) \
                .read(5, 2).read(6, 2).read(7, 2).read(8, 2) \
                .result()
            parameters['g_p'] = inputData[0]
            parameters['g_c'] = inputData[1]
            parameters['T_L'] = inputData[2]
            parameters['T_l'] = inputData[3]
            parameters['t_a'] = inputData[4]
            parameters['T_N'] = inputData[5]
            parameters['K_r'] = inputData[6]
            parameters['K_t'] = inputData[7]
            return inputData
        else:
            return parameters

    @classmethod
    def read_output(cls) -> dict:
        """
        Get the output data. \n
        :return: a dict that recording the simulation output data.
        """
        file_reader = FileAPI(config.tempPath, f'{config.outputFileName}_res.csv').reader()
        return {
            'time': file_reader.read_csv(1, 1),
            'heading_angle_difference': file_reader.read_csv(1, 2)
        }
