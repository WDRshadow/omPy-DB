import os
import shutil

from module.logger import logger


class FileAPI:
    def __init__(self, path: str, name: str):
        """
        A class of file modified API. This class is used to change, read, move, copy, rename, remove a file in the
        project. \n
        :param path: The relative path of the modified file.
        :param name: The file name.
        """
        self.logger = logger
        self.path = path
        self.name = name

    def __del__(self):
        pass

    def builder(self):
        """
        Get a Builder object for writing several values for a new file in succession. \n
        :return: a Builder object.
        """
        return Builder(self)

    def changer(self):
        """
        Get a Changer object for modifying several values of the same file in succession. \n
        :return: a Changer object.
        """
        return Changer(self)

    def reader(self):
        """
        Get a Reader object for reading several values of the same file in succession. \n
        :return: a Reader object.
        """
        return Reader(self)

    def rename(self, name: str):
        """
        A function to rename this data storage file. \n
        :param name: New name.
        :return: The object.
        """
        try:
            os.rename(os.path.join(self.path, self.name), os.path.join(self.path, name))
            self.name = name
            return self
        except Exception as err:
            self.logger.error("Cannot rename file " + self.name)
            self.logger.error(err)
            exit()

    def move(self, newPath: str):
        """
        A function to move this data storage file to a new path. \n
        :param newPath: The new location for the file.
        :return: The object.
        """
        try:
            shutil.move(os.path.join(self.path, self.name), newPath)
            self.path = newPath
            return self
        except Exception as err:
            self.logger.error("Cannot move file " + self.name + " to " + newPath)
            self.logger.error(err)
            exit()

    def copy(self, newPath: str):
        """
        A function to copy this data storage file to a new path. \n
        :param newPath: The new path for the file.
        :return: A new object for the new file.
        """
        try:
            shutil.copy(os.path.join(self.path, self.name), newPath)
            return FileAPI(newPath, self.name)
        except Exception as err:
            self.logger.error("Cannot copy file " + self.name + " to " + newPath)
            self.logger.error(err)
            exit()

    def remove(self):
        """
        A function to remove the file and delete the object. \n
        :return: void.
        """
        try:
            os.remove(os.path.join(self.path, self.name))
            self.__del__()
        except Exception as err:
            self.logger.error("Cannot remove file " + self.name)
            self.logger.error(err)
            exit()

    def isExist(self):
        """
        A function to check if the file exist. \n
        :return: True if it is exist or, False if it is not.
        """
        return os.path.exists(os.path.join(self.path, self.name))


class Changer:
    def __init__(self, file: FileAPI):
        """
        A changer class for modifying several values of the same file in succession. \n
        :param file: An object of FileAPI class.
        """
        self.file = file
        try:
            self.lines = open(os.path.join(self.file.path, self.file.name), "r").readlines()
        except Exception as err:
            self.file.logger.error("Cannot open file " + self.file.name)
            self.file.logger.error(err)
            exit()

    def change(self, line: int, val_l: int, value: any):
        """
        A function to change a value in this data storage file. \n
        :param line: The line where the changing value is.
        :param val_l: The location of the changing value in the line (divided by a space).
        :param value: Modified values (new).
        :return: Changer object.
        """
        self.lines[line - 1] = self.lines[line - 1].replace(self.lines[line - 1].split()[val_l - 1], str(value))
        return self

    def do(self):
        """
        Confirm and implement the changing. \n
        :return: The class FileAPI object.
        """
        try:
            open(os.path.join(self.file.path, self.file.name), "w").writelines(self.lines)
        except Exception as err:
            self.file.logger.error("Cannot write file " + self.file.name)
            self.file.logger.error(err)
            exit()
        return self.file


class Reader:
    def __init__(self, file: FileAPI):
        """
        A changer class for reading several values of the same file in succession. \n
        :param file: An object of FileAPI class.
        """
        self.value = []
        self.file = file
        try:
            self.lines = open(os.path.join(file.path, file.name), "r").readlines()
        except Exception as err:
            file.logger.error("Cannot open file " + file.name)
            file.logger.error(err)
            exit()

    def read(self, line: int, val_l: int):
        """
        A function to read a value in this data storage file. \n
        :param line: The line where the value is.
        :param val_l: The location of the value in the line (divided by a space).
        :return: Reader object.
        """
        val = self.lines[line - 1].split()[val_l - 1]
        try:
            val = float(val)
        except Exception as war:
            self.file.logger.warning(war)
        self.value.append(val)
        return self

    def read_csv(self, skipLine: int, row: int) -> list:
        """
        A function to read the specific row in this csv file. \n
        :param skipLine: The number of skip heading line.
        :param row: The number of specific row.
        :return: A list recording the data in the row.
        """
        theList = []
        try:
            for line in self.lines[skipLine:]:
                val = line.split(",")[row - 1]
                try:
                    val = float(val)
                except Exception as war:
                    self.file.logger.warning(war)
                theList.append(val)
            return theList
        except Exception as err:
            self.file.logger.error(err)

    def result(self):
        """
        Get the result of all the reading values. \n
        :return: The values.
        """
        return self.value


class Builder:
    def __init__(self, file: FileAPI):
        """
        A changer class for for writing several values for a new file in succession. \n
        :param file: An object of FileAPI class.
        """
        self.file = file
        self.lines = []

    def writeLine(self, line: str):
        """
        A function to write a new line in the new file. \n
        :param line: a line (new).
        :return: Builder object.
        """
        self.lines.append(line + "\n")
        return self

    def write(self):
        """
        Confirm and implement. \n
        :return: The class FileAPI object.
        """
        try:
            open(os.path.join(self.file.path, self.file.name), "w").writelines(self.lines)
        except Exception as err:
            self.file.logger.error("Cannot make a new file " + self.file.name)
            self.file.logger.error(err)
            exit()
        return self.file
