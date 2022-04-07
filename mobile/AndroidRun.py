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


class AndroidRun:

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
            if os.environ["PlatformName"] != "Android":
                print("ERROR: Please Provide PlatformName As: Android")
                sys.exit(1)
            if self.objCommon.fileExists(os.environ["ApkPath"]) == False:
                print("ERROR: .apk file Does Not Exists over " + str(os.environ["ApkPath"]) + " Path !!")
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
            os.environ["AppPackage"] = configDict["Configuration"]["SetupConfiguration"]["Android"]["AppConfiguration"]["AppPackage"]
            os.environ["AppActivity"] = configDict["Configuration"]["SetupConfiguration"]["Android"]["AppConfiguration"]["AppActivity"]
            userName = configDict["Configuration"]["SetupConfiguration"]["Android"]["AppCredential"]["UserName"]
            if userName != None:
                os.environ["UserName"] = userName
            userPassword = configDict["Configuration"]["SetupConfiguration"]["Android"]["AppCredential"]["Password"]
            if userPassword != None:
                os.environ["Password"] = userPassword

            if str(str(configDict["Configuration"]["SetupConfiguration"]["Android"]["AppConfiguration"]["ApkPath"]).split("/")[0]) == "bin":
                os.environ["ApkPath"] = "mobile/{0}".format(configDict["Configuration"]["SetupConfiguration"]["Android"]["AppConfiguration"]["ApkPath"])
            else:
                os.environ["ApkPath"] = "{0}".format(configDict["Configuration"]["SetupConfiguration"]["Android"]["AppConfiguration"]["ApkPath"])

            if configDict["Configuration"]["SetupConfiguration"]["Android"]["AppConfiguration"]["UITestFramework"] != None:
                if ((str(configDict["Configuration"]["SetupConfiguration"]["Android"]["AppConfiguration"]["UITestFramework"]) != "uiautomator") and
                    (str(configDict["Configuration"]["SetupConfiguration"]["Android"]["AppConfiguration"]["UITestFramework"]) != "uiautomator2")):
                   print(""""
                         ERROR: You have selected invalid Android unit test framework...
                         Framework support only two options:
                                                           1. uiautomator
                                                           2. uiautomator2
                         """)
                   sys.exit(1)
                os.environ["UITestFramework"] = configDict["Configuration"]["SetupConfiguration"]["Android"]["AppConfiguration"]["UITestFramework"]
            else:
                os.environ["UITestFramework"] = uiTestFramework
        except Exception as err:
            print("ERROR: Please Provide Correct AppConfiguration And AppCredential Data To MobileConfig.xml File")
            print("ERROR: ", err)
            sys.exit(1)
        self._configDataValidation()

    def getDeviceSpecConfiguration(self, deviceVersion, configDict):
        """
        Get Android device version specific test data
        """

        try:
            settings = str(configDict["Configuration"]["SetupConfiguration"]["Android"]["{0}{1}".format("AndroidV", deviceVersion)]["MobSettingPageXpathFileName"])
            if settings != 'None':
                settings = settings.split(".")[0]
            else:
                settings = ".defaultSettings"

            currentDir = os.getcwd()
            if int(deviceVersion) <= 5:
                androidCls = currentDir + "/mobile/" + SETTINGS_LOCATOR_FILE_PATH + "AndroidV5Class"
            else:
                androidCls = currentDir + "/mobile/" + SETTINGS_LOCATOR_FILE_PATH + "AndroidV7AndGreaterClass"

            dataFile = str(configDict["Configuration"]["SetupConfiguration"]["Android"]["{0}{1}".format("AndroidV", deviceVersion)]["DataFilePath"])
            if dataFile != 'None':
                if self.objCommon.fileExists(dataFile) == False:
                    print("ERROR: Android Lable file Does Not Exists over " + str(dataFile) + " Path !!")
                    sys.exit(1)
                dataFile = dataFile.split(".")[0]
            else:
                dataFile = ".defaultData"

            return (settings, androidCls, dataFile)
        except Exception as err:
            print("ERROR: ", err)
            sys.exit(1)

    def robotSuiteExecutor(self, deviceId, remoteUrl, serverPort,
                           adbServerPort, settings, androidCls, labels, sysPort):
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
                robotRunCmd = "{0} -v remoteURL:'{1}' -v deviceId:{2} -v appiumServerPort:{3} -v adbServerPort:{4} \
                        -v settingsPageElem:{5} -v androidCls:{6} -v labels:{7} -v systemPort:{8}".format(robotRunCmd, remoteUrl,
                                                                           deviceId, serverPort, adbServerPort,
                                                                           settings, androidCls, labels, sysPort)

                # Add only selected test in execution
                if execTest:
                    tagsList = execTest.split()
                    for tag in tagsList:
                        includedTag += '--include {0} '.format(tag)
                    robotRunCmd = "{0} {1}".format(robotRunCmd, includedTag)

                if os.environ["testRailListnerCmd"] != "":
                    robotRunCmd = "{0} {1}".format(robotRunCmd, os.environ["testRailListnerCmd"])

                robotRunCmd = '{0} {1}.robot'.format(robotRunCmd, str(testSuite))

            # Auto Generate setting page locators file
            settingsXmlPath = "mobile/{0}/{1}.xml".format(
                               str(CFG_FILE_PATH.split("/")[0]),
                               settings
                               )

            settingLocatorFile = "mobile/{0}{1}.{2}".format(
                                  SETTINGS_LOCATOR_FILE_PATH,
                                  settings,
                                  ROBOT_EXT
                                  )

            if not self.objMobileSettings.xmlToRobot(
                         settingsXmlPath, settingLocatorFile):
                    sys.exit(1)

            # Trigger to test suite execution
            if self.objCommon.startRobotExec(robotRunCmd):
                # Generate CSV report
                self.objTestReport.generateCsvReport(robotXml, CSV_REPORT_FILE_NAME)

    def getAndroidVersion(self, deviceSerialId):
        """
        Get Android Device Version
        """
        try:
            androidVersion = subprocess.check_output(["adb", "-s", deviceSerialId, "shell", "getprop", "ro.build.version.release"])
            return androidVersion.decode("UTF-8").split(".")[0]
        except Exception as err:
            print("ERROR: ", err)
            return False
