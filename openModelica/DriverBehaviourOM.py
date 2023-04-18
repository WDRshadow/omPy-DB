from OMPython import OMCSessionZMQ

import config
from module.logger import logger


class Model:
    def __init__(self):
        self.omc = OMCSessionZMQ()
        self.packagePath = config.packagePath
        self.model = config.model
        self.startTime = config.startTime
        self.stopTime = config.stopTime
        self.outputVariable = config.outputVariable
        # load and initialize the instance
        logger.info('loadModel(Modelica):\n{}'.format(self.omc.sendExpression('loadModel(Modelica)')))
        for package in self.packagePath:
            logger.info('loadFile(\"{}\"):\n{}'.format(package, self.omc.sendExpression(f'loadFile(\"{package}\")')))

    def update(self):
        pass

    def run(self):
        cmds = [
            f'cd(\"{config.tempPath}\")',
            f'simulate({self.model}, startTime={self.startTime},stopTime={self.stopTime}, outputFormat="csv", variableFilter=\"{self.outputVariable}\")',
            f'plot({self.outputVariable})'
        ]
        for cmd in cmds:
            answer = self.omc.sendExpression(cmd)
            logger.info("{}:\n{}".format(cmd, answer))

    @classmethod
    def read_output(cls):
        pass
