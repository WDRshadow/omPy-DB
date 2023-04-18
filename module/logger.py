import logging

import config

# just in case if someone set config.log = "False" :(
if config.log is True:
    # Generate the logger
    logger = logging.getLogger('omPy-DB')
    logger.setLevel(logging.INFO)
    consoleHandler = logging.StreamHandler()
    consoleHandler.setLevel(logging.INFO)
    fileHandler = logging.FileHandler('logs/omPy-DB.log', mode='a', encoding='UTF-8')
    fileHandler.setLevel(logging.NOTSET)
    formatter = logging.Formatter('[%(name)s] [%(asctime)s] [%(levelname)s]: %(message)s')
    consoleHandler.setFormatter(formatter)
    fileHandler.setFormatter(formatter)
    logger.addHandler(consoleHandler)
    logger.addHandler(fileHandler)

else:
    class NoneLogger:
        def info(self, something) -> None: ...

        def warning(self, something) -> None: ...

        def error(self, something) -> None: ...


    logger = NoneLogger()
