#!/usr/bin/env python

########################################################################
#
# - MobileCleanUp Library is used to clean up all the temporary files,
#   stop ADB Server,stop Appium Server.
# - This Library is called after the execution of each test case.
#
########################################################################

import os
import sys
import shutil
import tempfile
from contextlib import contextmanager
from MobileConnection import MobileConnection
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                '../../../commonlib')))
from Common import Common


class MobileCleanUp:

    def __init__(self):
        self.objCommon = Common()

    @contextmanager
    def _tmpDirectory(self, tempDirectory):
        """
        Creates Temporary Directory
        """
        try:
            tempDir = tempfile.mkdtemp(prefix="temp_", dir=tempDirectory)
            yield tempDir
        except Exception as err:
            print("Error :", err)
            return False

    def createTempDir(self, tempDirPath):
        """
        This function uses createTempDir() for creating temp directory and return Path
        """
        with self._tmpDirectory(tempDirPath) as newDirectory:
            return newDirectory

    def cleanUpTempDir(self, tempDir):
        """
        Deletes Temporary Directory
        """
        try:
            if self.objCommon.dirExists(tempDir):
                shutil.rmtree(tempDir)
                return True
        except Exception as err:
            print("Error :", err)
            return False

    @contextmanager
    def _tmpFile(self, temporaryFile):
        """
        Creates Temporary File
        """
        try:
            tempFileInteger, tempFile = tempfile.mkstemp(prefix="temp_", dir=temporaryFile)
            yield tempFile
        except Exception as err:
            print("Error :", err)
            return False

    def createTempFile(self, tempFilePath):
        """
        This function uses createTempFile() for creating new file and return path
        """
        with self._tmpFile(tempFilePath) as newFile:
            return newFile

    def cleanUpTempFile(self, tempFile):
        """
        Deletes the Temporary File
        """
        try:
            if self.objCommon.fileExists(tempFile):
                self.objCommon.deleteFile(tempFile)
                return True
        except Exception as err:
            print("Error :", err)
            return False
