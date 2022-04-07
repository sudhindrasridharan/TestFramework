#!/usr/bin/env python

####################################################################
#
# - This python script is an Entry point for Volanium.
#
# - This script will perform below operations:
#
#   1. Check Mobile Device connection with system.
#   2. Read Config data XML file and pass config data to test suite.
#   3. Trigger robot script with required parameters.
#   4. Dump XML and HTML report at Year/month/date/time location.
#   5. Generate CSV report.
#   # Note: This script consist of statement "sys.exit(1)" multiple time
#           and Later on it will be replace by statement "return False".
#
####################################################################

import time
import os
import sys
import subprocess
import getopt
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                'src/lib/')))
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                '../commonlib/')))
import MobileConnection
import Common
from CommonVariables import *
import TestReportGenerator
import XmlParser
import MobileSettings
from multiprocessing import Process


class IosRun:

    def __init__(self):
        self.objCommon = Common.Common()
        self.objXmlParesr = XmlParser.XmlParser()
        self.objMobileConnection = MobileConnection.MobileConnection()
        self.objTestReport = TestReportGenerator.TestReportGenerator()
        self.objMobileSettings = MobileSettings.MobileSettings()
        self.deviceIdList = None
        self.cfgDict = {}

    def _getRemoteUrl(self, portNum):
        """
        Prepare Remote URL of Appium Server
        """
        try:
            return "http://localhost:{0}/wd/hub".format(str(portNum))
        except Exception as err:
            print("ERROR : ", err)
            return False

    def _getServerPort(self, urlStr):
        """
        Get Appium Server Running Port
        """
        try:
            return str(urlStr).split(":")[2].split("/")[0].strip().rstrip()
        except Exception as err:
            print("ERROR: ", err)
            return False

    def _configDataValidation(self):
        """
        Validate given configuration data
        """
        try:
            if os.environ["PlatformName"] != "iOS":
                print("ERROR: Please Provide PlatformName As: iOS")
                sys.exit(1)

            if self.objCommon.fileExists(os.environ["ipaPath"]) == False:
                print("ERROR: .IPA file does not exists: " + str(os.environ["ipaPath"]))
                sys.exit(1)

            if os.environ["ipaBundleId"] == "None":
                print("ERROR: Please Provide Application BundleId")
                sys.exit(1)

            if self.objCommon.dirExists(os.environ["BootstrapPath"]) == False:
                print("ERROR: BootstrapPath - Directory does not exists: " + str(os.environ["BootstrapPath"]))
                sys.exit(1)

            if self.objCommon.dirExists(os.environ["AgentPath"]) == False:
                print("ERROR: AgentPath - Directory does not exists: " + str(os.environ["AgentPath"]))
                sys.exit(1)

        except Exception as err:
            print("ERROR: ", err)
            return False

    def getConfigData(self, configDict):
        """
        Parse config data from Config dict
        """
        try:
            os.environ["PlatformName"] = configDict["Configuration"]["SetupConfiguration"]["PlatformConfiguration"]["PlatformName"]
            if str(str(configDict["Configuration"]["SetupConfiguration"]["iOS"]["iOSAppConfiguration"]["ipaPath"]).split("/")[0]) == 'bin':
                os.environ["ipaPath"] = "mobile/{0}".format(str(configDict["Configuration"]["SetupConfiguration"]["iOS"]["iOSAppConfiguration"]["ipaPath"]))
            else:
                os.environ["ipaPath"] = "{0}".format(str(configDict["Configuration"]["SetupConfiguration"]["iOS"]["iOSAppConfiguration"]["ipaPath"]))
            os.environ["ipaBundleId"] = configDict["Configuration"]["SetupConfiguration"]["iOS"]["iOSAppConfiguration"]["ipaBundleId"]
            userName = configDict["Configuration"]["SetupConfiguration"]["iOS"]["iOSAppCredentials"]["UserName"]
            if userName != None:
                os.environ["UserName"] = userName
            userPassword = configDict["Configuration"]["SetupConfiguration"]["iOS"]["iOSAppCredentials"]["Password"]
            if userPassword != None:
                os.environ["Password"] = userPassword
            os.environ["BootstrapPath"] = configDict["Configuration"]["SetupConfiguration"]["iOS"]["CommonSettings"]["BootstrapPath"]
            os.environ["AgentPath"] = configDict["Configuration"]["SetupConfiguration"]["iOS"]["CommonSettings"]["AgentPath"]
        except Exception as err:
            print("ERROR: Please Provide Correct Information For iOS In Configuration File - MobileConfig.xml")
            sys.exit(1)

        self._configDataValidation()

    def robotSuiteExecutor(self, deviceId, remoteUrl, serverPort, wdaPort):
        """
        Configure environment as per test suite and start test execution
        """
        global logReportDir
        global includedTag

        allSuiteList = str(execSuite).split()

        for testSuite in allSuiteList:
            # prepare cmd to trigger the robot execution
            robotRunCmd = ROBOT_EXT

            # get current date-time to dump logs at appropriate location
            execStartTime = self.objCommon.getCurrentTime("%Y%m%d%H%M%S")
            if execStartTime:
                logReportDir = 'logs/{0}/{1}/{2}/{3}/'.format(str(execStartTime[:4]),
                                                                 str(execStartTime[4:6]),
                                                                 str(execStartTime[6:8]),
                                                                 str(deviceId)
                                                                 )

                os.environ['logDir'] = logReportDir
                robotRunCmd = '{0} -o {1}output_{2}.xml -l {1}log_{2}.html -r {1}report_{2}.html'.format(
                                                                                            robotRunCmd,
                                                                                            logReportDir,
                                                                                            execStartTime
                                                                                            )

                robotXml = '{0}output_{1}.xml'.format(str(logReportDir), str(execStartTime))
                robotRunCmd = "{0} -v remoteURL:'{1}' -v deviceId:{2} -v appiumServerPort:{3} -v wdaPort:{4}".format(robotRunCmd, remoteUrl, deviceId, serverPort, wdaPort)
                # Add only selected test in execution
                if execTest:
                    tagsList = execTest.split()
                    for tag in tagsList:
                        includedTag += '--include {0} '.format(tag)
                    robotRunCmd = "{0} {1}".format(robotRunCmd, includedTag)
                robotRunCmd = '{0} {1}.robot'.format(robotRunCmd, str(testSuite))

            # Trigger to test suite execution
            if self.objCommon.startRobotExec(robotRunCmd):
                # Generate csv report
                self.objTestReport.generateCsvReport(robotXml, CSV_REPORT_FILE_NAME)
