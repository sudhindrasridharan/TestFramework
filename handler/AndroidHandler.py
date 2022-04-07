#!/usr/bin/env python

#####################################################
#
# - Test Handler for ANDROID device automation
# - Test Handler is a intermediate stage between
#   Test Driver and ANDROID Test Executor
#
# - Test Handler Performs below operations:
#   1. Initialize ANDROID Test Executor
#   2. Set ANDROID device prerequisite
#   3. Trigger Test execution over ANDROID device
#
#######################################################

import sys
import os
from multiprocessing import Process
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                '../mobile/')))
import AndroidRun


class AndroidHandler:

    def __init__(self):
        self.objAndroidRun = AndroidRun.AndroidRun()

    def setAndroidPrerequisite(self, testSuite, testTag):
        """
        Set Prerequsite to start Android device execution
        """
        try:
            # Get Connected Mobile Device List
            self.objAndroidRun.deviceIdList = \
                self.objAndroidRun.objMobileConnection.checkAndroidDeviceConnection(str(AndroidRun.adbServerPort))
            if len(self.objAndroidRun.deviceIdList[0]) == 0:
                print(""""
                        --------------------------------------------
                        Device Not Connected
                        Please connect your device with test system
                        --------------------------------------------""")
                return False
            for device in self.objAndroidRun.deviceIdList:
                value = list(device.values())[0]
                if value != 'device':
                    print(""""
                        ---------------------------------------------
                        Device Is In Offline Mode
                        Please reconnect your device with test system
                        ---------------------------------------------""")
                    return False
        except Exception as err:
            print("ERROR: ", err)
            return False

        # Validate config file availability
        if not self.objAndroidRun.objCommon.fileExists("mobile/{0}".format(AndroidRun.CFG_FILE_PATH)):
            print("Config file not present at location : ", AndroidRun.CFG_FILE_PATH)
            return False

        # update suite to be excute
        AndroidRun.execSuite = testSuite
        # Update test tags to e execute
        AndroidRun.execTest = testTag

        # 1. Convert Config XML to dictionary 2. Set Environment variable for config XML data
        try:
            getCfgDict = self.objAndroidRun.objXmlParesr.xmlToDict("mobile/{0}".format(AndroidRun.CFG_FILE_PATH))
            self.objAndroidRun.getConfigData(getCfgDict)
            return True
        except Exception as err:
            print("ERROR: ", err)
            return False

    def triggerAndroidTestExecution(self):
        """
        Trigger test execution over android device
        """
        appiumPortNum = 4723
        adbServerPort = 5037
        systemPort = 8200

        if (isinstance(self.objAndroidRun.deviceIdList, list)):
            for deviceName in self.objAndroidRun.deviceIdList:
                for index, device in enumerate((list(deviceName.keys()))):
                    # Get Android Device Version
                    androidVersion = self.objAndroidRun.getAndroidVersion(device)

                    # Get device Specific credentials
                    (settings, androidCls, labels) = \
                        self.objAndroidRun.getDeviceSpecConfiguration(str(androidVersion),
                        self.objAndroidRun.objXmlParesr.xmlToDict("mobile/{0}".format(AndroidRun.CFG_FILE_PATH)))

                    appiumPortNum = int(appiumPortNum) + 5
                    adbServerPort = int(adbServerPort) + 5
                    systemPort = int(systemPort) + 5

                    globals()['process%s' % index] = Process(target=self.objAndroidRun.robotSuiteExecutor,
                        args=(self.objAndroidRun.objCommon.removeWhiteSpace(device), self.objAndroidRun._getRemoteUrl(appiumPortNum),
                        self.objAndroidRun._getServerPort(self.objAndroidRun._getRemoteUrl(appiumPortNum)), adbServerPort,
                        settings, androidCls, labels, systemPort))
                    globals()['process%s' % index].start()
        else:
            print("\nConnnected Android Device not found...\n")
            return False

        # Wait till forked process completion
        [globals()['process%s' % index].join() for index, device in enumerate(list(self.objAndroidRun.deviceIdList))]
        return True
