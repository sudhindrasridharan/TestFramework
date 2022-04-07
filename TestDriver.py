#!/usr/bin/env python

###########################################################################
#
# - Test Driver Script for Sample
# 
# - Test Driver Script perform following Operations:
#   1. Input data validation
#   2. Test component validation(E.g. Android, iOS, web)
#   3. Initialize test device handler
#   4. Set test execution Prerequisite
#   5. Trigger the execution of test suite
#
############################################################################

import sys
import os
import getopt

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                'commonlib/')))
import Common
import SampleUsage
from TestRailConfig import *

from handler import AndroidHandler
from handler import IosHandler
from handler import CloudHandler
from handler import EmbeddedHandler
from handler import WebHandler

# Global Variables
testSuiteToExec = None
testTagToExec = None
testComponentLst = []
testrailUpdate = None

# Macros
ANDROID = 'android'
IOS = 'ios'
CLOUDFUNCTIONAL = 'cloudfunctional'
CLOUDLOAD = 'cloudload'
WEB = 'web'
EMBEDDED = 'embedded'


class TestDriver:

    def __init__(self):
        self.objCommon = Common.Common()
        self.objUsage = SampleUsage.SampleUsage()

    def _validateTestSuiteFile(self, testSuiteLst):
        """
        Validate test suite file is available at given path
        """
        suiteList = testSuiteLst.split()
        for suite in suiteList:
            if not self.objCommon.fileExists("{0}.robot".format(suite)):
                print("""
                      -----------------------------------------------------
                      Test Suite Script: %s.robot is not available.
                      Please provide proper location of the Test Suite.
                      -----------------------------------------------------
                      """%suite)
                sys.exit(1)

    def cmdLineParser(self, argv):
        """
        command line parsing and validation
        """
        global testSuiteToExec
        global testTagToExec
        global testComponentLst
        global testrailUpdate

        try:
            opts, args = getopt.getopt(argv, 'h:c:s:t:r:', ['component=', 'suite=', 'tag=', 'testrail=', ])
        except getopt.GetoptError:
            self.objUsage.displayUsage()

        for opt, arg in opts:
            if opt in ('-h', '--help'):
                self.objUsage.displayUsage()
            elif opt in ('-c', '--component'):
                testComponentLst = str(arg).split()
                testComponentLst = [elem.lower() for elem in testComponentLst]
            elif opt in ('-t', '--tag'):
                testTagToExec = str(arg)
            elif opt in ('-s', '--suite'):
                testSuiteToExec = str(arg)
            elif opt in ('-r', '--testrail'):
                testrailUpdate = str(arg)
            else:
                self.objUsage.displayUsage()

        if not (testSuiteToExec and testComponentLst):
            print("""
                  -------------------------------------------
                  Test suite name and component is mandatory
                  for Volanium execution.
                  -------------------------------------------""")
            self.objUsage.displayUsage()

        if testSuiteToExec:
            self._validateTestSuiteFile(testSuiteToExec)

    def _validateTestComponent(self):
        """
        Validate input test components
        """
        try:
            for testModule in testComponentLst:
                if ((testModule != ANDROID) and (testModule != IOS)
                     and (testModule != WEB) and (testModule != CLOUDFUNCTIONAL)
                     and (testModule != CLOUDLOAD) and (testModule != EMBEDDED)):
                    print("\n\nYou have selected invalid test component\n\n")
                    self.objUsage.displayUsage()
        except Exception as err:
            print("ERROR: ", err)
            sys.exit(1)

    def _initTestHandler(self):
        """
        Initialize test component's handler
        """
        try:
            if ((ANDROID in testComponentLst)
                    and (IOS in testComponentLst)):
                print("""
                       ------------------------------------------- 
                       Framework does not allow to execute Android
                       and iOS component simuntaneously
                       -------------------------------------------""")
                self.objUsage.displayUsage()
            else:
                if ANDROID in testComponentLst:
                    if (str(sys.platform) != 'linux'):
                        print(""""
                        ---------------------------------------------------
                        You can test Android device with Linux system only.
                        Please connect your Android device with Linux system.
                        ---------------------------------------------------""")
                        sys.exit(1)
                    self.objAndroidHndlr = AndroidHandler.AndroidHandler()
                if IOS in testComponentLst:
                    if (str(sys.platform) != 'darwin'):
                        print(""""
                        ---------------------------------------------------
                        You can test iOS device with Mac system only.
                        Please connect your iPhone device with MAC system.
                        ---------------------------------------------------""")
                        sys.exit(1)
                    self.objIosHndlr = IosHandler.IosHandler()
            if CLOUDFUNCTIONAL in testComponentLst:
                self.objCloudHndlr = CloudHandler.CloudHandler()
            if CLOUDLOAD in testComponentLst:
                self.objCloudHndlr = CloudHandler.CloudHandler()
            if EMBEDDED in testComponentLst:
                self.objEmbeddedHndlr = EmbeddedHandler.EmbeddedHandler()
            if WEB in testComponentLst:
                self.objWebHndlr = WebHandler.WebHandler()
        except Exception as err:
            print("ERROR: ", err)
            sys.exit(1)

    def _setTestPrerequisite(self):
        """
        Set test execution prerequisite for specific component
        """
        try:
            if ANDROID in testComponentLst:
                if not self.objAndroidHndlr.setAndroidPrerequisite(testSuiteToExec, testTagToExec):
                    print("""
                       ----------------------------------------------
                       Failed to set Android prerequisite..
                       Terminating test execution over Android device
                       ----------------------------------------------""")
                    sys.exit(1)
            if IOS in testComponentLst:
                if not self.objIosHndlr.setIosPrerequisite(testSuiteToExec, testTagToExec):
                    print("""
                        --------------------------------------------
                        Failed to set iOS prerequisite..
                        Terminating test execution over iOS device.
                        --------------------------------------------""")
                    sys.exit(1)
            if CLOUDFUNCTIONAL in testComponentLst:
                if not self.objCloudHndlr.setCloudPrerequisite(testSuiteToExec, testTagToExec):
                    print("""
                        ---------------------------------------------
                        Failed to set Cloud Functional prerequisite..
                        Terminating test execution on cloud.
                        ---------------------------------------------""")
                    sys.exit(1)
            if CLOUDLOAD in testComponentLst:
                if not self.objCloudHndlr.setCloudPrerequisite(testSuiteToExec, testTagToExec):
                    print("""
                        ----------------------------------------------
                        Failed to set Cloud Load prerequisite..
                        Terminating test execution on cloud.
                        ----------------------------------------------""")
                    sys.exit(1)
            if EMBEDDED in testComponentLst:
                if not self.objEmbeddedHndlr.setEmbeddedPrerequisite(testSuiteToExec, testTagToExec):
                    print("""
                        ----------------------------------------------
                        Failed to set Embedded Device prerequisite..
                        Terminating test execution on Embedded Device.
                        ----------------------------------------------""")
                    sys.exit(1)
            if WEB in testComponentLst:
                pass
        except Exception as err:
            print("ERROR: ", err)
            sys.exit(1)

    def _triggerTestExecution(self):
        """
        Trigger test suite execution over the perticular device
        """
        os.environ["testRailListnerCmd"] = ""

        if (testrailUpdate != None) and (str(testrailUpdate.lower()) == "yes"):
            os.environ["testRailListnerCmd"] = "--listener {0}:{1}:{2}:{3}:{4}:{5}:{6}".format(
                    "TestRailListener", testRailUrl, testRailUserName, testRailPassword, runId,
                    testRailHttp, testRailUpdate
                    )
        try:
            if ANDROID in testComponentLst:
                if not self.objAndroidHndlr.triggerAndroidTestExecution():
                    print("\n\nFailed to trigger test execution over Android device\n\n")
                    sys.exit(1)
            if IOS in testComponentLst:
                if not self.objIosHndlr.triggerIosTestExecution():
                    print("\n\nFailed to trigger test execution over iOS device\n\n")
                    sys.exit(1)
            if CLOUDFUNCTIONAL in testComponentLst:
                if not self.objCloudHndlr.triggerCloudTestExecution():
                    print("\n\nFailed to trigger test execution on Cloud\n\n")
                    sys.exit(1)
            if CLOUDLOAD in testComponentLst:
                if not self.objCloudHndlr.triggerCloudTestExecution():
                    print("\n\nFailed to trigger test execution on Cloud\n\n")
                    sys.exit(1)
            if EMBEDDED in testComponentLst:
                if not self.objEmbeddedHndlr.triggerEmbeddedTestExecution():
                    print("\n\nFailed to trigger test execution on Embedded Device\n\n")
                    sys.exit(1)
            if WEB in testComponentLst:
                pass
        except Exception as err:
            print("ERROR: ", err)
            sys.exit(1)


# Driver entry point
if __name__ == '__main__':

    objDriver = TestDriver()
    if len(sys.argv) < 5:
        objDriver.objUsage.displayUsage()
    else:
        objDriver.cmdLineParser(sys.argv[1:])

    # Validate input test components
    objDriver._validateTestComponent()

    # Init test component handler
    objDriver._initTestHandler()

    # Set test execution prerequisists
    objDriver._setTestPrerequisite()

    # Trigger test suite execution
    objDriver._triggerTestExecution()
