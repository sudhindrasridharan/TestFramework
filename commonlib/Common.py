#!/usr/bin/env python

##################################################################
#
# Common Library includes all common functions used by Framework
#
##################################################################

import datetime
import time
import os
import re
import xmltodict
import xml.dom.minidom as dom


class Common:

    def fileExists(self, fileName):
        """
        This function checks whether file exists or not
        Argument : Absolute file path
        Return : True if Success, else False
        """
        try:
            if os.path.isfile(fileName):
                return True
            else:
                return False
        except Exception as err:
            print("Error : ", err)
            return False

    def dirExists(self, dirName):
        """
        This function checks whether directory exists or not
        Argument : Absolute directory path
        Return : True if success, else False
        """
        try:
            if os.path.isdir(dirName):
                return True
            else:
                return False
        except Exception as err:
            print("Error : ", err)
            return False

    def xmlValidator(self, fileName):
        """
        This function validates the syntax of a XML file
        Argument : Absolute file path with file name
        Return : True if Success, else False
        """
        if self.fileExists(fileName):
            with open(fileName) as f:
                try:
                    dom.parse(fileName)
                    return True
                except Exception as err:
                    print("Error : XML File format is incorrect !!", err)
                    return False
        else:
            return False

    def xmlParser(self, fileName):
        """
        This function Converts the given xml file into ordered dictionary
        Argument : Absolute file path with file name
        Return : Dictionary if xml parser is success, else false.
        """
        if self.xmlValidator(fileName):
            try:
                with open(fileName) as f:
                    dictData = xmltodict.parse(f.read())
                    return dictData
            except Exception as err:
                print("Error :", err)
                return False
        else:
            return False

    def getCurrentTime(self, timeFormatRequired='%H:%M:%S'):
        """
        This function get the current system time.
        Argument : Required Time Format. Default is '%H:%M:%S')
        Return: Current time in requested format or default format.
        """
        try:
            timeStr = time.strftime(timeFormatRequired)
            return timeStr
        except Exception as err:
            print("Error:", err)
            return False

    def getTodayDate(self, dateFormatRequired='%d:%m:%Y'):
        """
        This function get the system today's date.
        Argument : Required date Format. Default is '%d:%m:%Y')
        Return: Current date in requested format or default format.
        """
        try:
            dateStr = time.strftime(dateFormatRequired)
            return dateStr
        except Exception as err:
            print("Error:", err)
            return False

    def getCurrentEpochTime(self):
        """
        This function get the current EpochTime of the system.
        Return: Current Epoch time , False when exception.
        """
        try:
            temp = datetime.datetime.now()
            currentEpochTime = int(time.mktime(temp.timetuple()))
            return currentEpochTime
        except Exception as err:
            print("Error:", err)
            return False

    def splitLines(self, lineToSplit):
        """
        Splits the lines and removes the white spaces
        Argument : Line to split
        Return : List of splited line
        """
        try:
            return re.split(r'[\r\n]+', lineToSplit.rstrip())
        except Exception as err:
            print("Error:", err)
            return False

    def deleteFile(self, fileName):
        """
        This function deletes the file
        Argument : Absolute path of file
        Return : Ture if deleted, False if not deleted
        """
        if self.fileExists(fileName):
            try:
                os.remove(fileName)
                return True
            except Exception as err:
                print("Error:", err)
                return False
        else:
            return False

    def openFile(self, fileName, fileMode='a'):
        """
        Open File at given path
        Argument: File Name and file open mode
        Return: File pointer
        """
        try:
            filePtr = open(fileName, fileMode)
            return filePtr
        except Exception as err:
            print("ERROR : ", err)
            return False

    def closeFile(self, filePtr):
        """
        Close File
        Argument: File pointer
        Return: True on successful close
        """
        try:
            filePtr.close()
            return True
        except Exception as err:
            print("ERROR: ", err)
            return False

    def getFileSize(self, fileName):
        """
        This function gives file size
        Argument : File Name
        Return : Size of file in bytes
        """
        if self.fileExists(fileName):
            try:
                size = os.stat(fileName)
                return size.st_size
            except Exception as err:
                print("ERROR: ", err)
                return False
        else:
            return False

    def killProcessByPort(self, portNum):
        """
        Kill the process over specific port
        Argument: port_number
        Return: "True" if process over given port terminated succesfuuly
        """
        try:
            killCmd = 'kill -9 $(lsof -t -i:{0} -sTCP:LISTEN)'. \
                                             format(int(portNum))
            retCode = os.system(killCmd + "> /dev/null 2>&1")
            if int(retCode) != 0:
                return False
            return True
        except Exception as err:
            print("ERROR : ", err)
            return False

    def removeWhiteSpace(self, inputStr):
        """
        Remove White Space of device name
        """
        try:
            return inputStr.strip().rstrip()
        except Exception as err:
            print("ERROR: ", err)
            return False

    def startRobotExec(self, robotExecCmd):
        """
        start execution of robot framework
        """
        try:
            os.system(robotExecCmd)
            return True
        except Exception as err:
            print("ERROR: ", err)
            return False
