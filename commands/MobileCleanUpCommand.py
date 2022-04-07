#!/usr/bin/env python

################################################################
#
# This script is used to execute Python MobileConnection
# Library(MobileConnection.py) from command line.
#
################################################################

import sys
import os
import time
import MobileCleanUpParser
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                '../mobile/src/lib')))
from MobileCleanUp import MobileCleanUp
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                '../../../commonlib')))
from Common import Common

tempDir = None

# Script Entry Point
if __name__ == '__main__':

    # Create Mobilecleanup object
    objMobileCleanUp = MobileCleanUp()
    objCommon = Common()
    action = MobileCleanUpParser.cmdLineArgParser()

    if action is None:
        print(MobileCleanUpParser.libUsage())
        sys.exit(1)

    try:
        if action == "CreateTempDirectory":
            tempDir = input("Enter Path:")
            if tempDir == '':
                tempDir = "../temp"
            else:
                pass
            newTempDir = objMobileCleanUp.createTempDir(tempDir)
            print("Temporary Directory Created:", newTempDir)
        elif action == "CleanUpTempDirectory":
            returnValue = objMobileCleanUp.cleanUpTempDir(input("Enter Path:"))
            print(returnValue)
        elif action == "CreateTempFile":
            tempFile = input("Enter Path:")
            if tempFile == '':
                tempFile = "../temp"
            else:
                pass
            newTempFile = objMobileCleanUp.createTempFile(tempFile)
            print("Temporary File Created:", newTempFile)
        elif action == "CleanUpTempFile":
            returnValue = objMobileCleanUp.cleanUpTempFile(input("Enter Path:"))
            print(returnValue)
        else:
            print(MobileCleanUpParser.libUsage())
    except Exception as err:
        print("Error:", err)
        sys.exit(1)
