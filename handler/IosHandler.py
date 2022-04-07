#!/usr/bin/env python

#####################################################
#
# - Test Handler for iOS device automation
# - Test Handler is a intermediate stage between
#   Test Driver and iOS Test Executor
#
# - Test Handler Performs below operations:
#   1. Initialize iOS Executor
#   2. Set iOS device prerequisite
#   3. Trigger Test execution over iOS device
#
#######################################################

import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                '../mobile/')))
from multiprocessing import Process
import iOSRun


class IosHandler:

    def __init__(self):
        self.objIosRun = iOSRun.IosRun()

    def setIosPrerequisite(self, testSuite, testTags):
        """
        Set Prerequsite to start iOS device execution
        """
        try:
            # Get Connected Mobile Device List
            self.objIosRun.deviceIdList = self.objIosRun.objMobileConnection.iOSDeviceProductId()

            # Get connected mobile devivce Name List
            self.objIosRun.iOSDeviceNameList = self.objIosRun.objMobileConnection.iOSDeviceProductName(self.objIosRun.deviceIdList)

            # Validate IOS device is connected with system
            if not self.objIosRun.deviceIdList:
                print('\n' + "!" * 60 + '\n' + "!\t\t\t Warning !!!\t\t\t   !" + '\n' + "!\t\t Device Not Found .....\t\t\t   !" + '\n' + "!\t Please connect iOS device with test system \t   !" + '\n' + "!" * 60 + '\n')
                return False
        except Exception as err:
            print("ERROR: ", err)
            return False

        # Validate config file availability
        if not self.objIosRun.objCommon.fileExists("mobile/{0}".format(iOSRun.CFG_FILE_PATH)):
            print("Config file not present at location : ", iOSRun.CFG_FILE_PATH)
            return False

        # update suite to be excute
        iOSRun.execSuite = testSuite
        # Update test tags to e execute
        iOSRun.execTest = testTags

        # 1. Convert Config XML to dictionary 2. Set Environment variable for config XML data
        try:
            getCfgDict = self.objIosRun.objXmlParesr.xmlToDict("mobile/{0}".format(iOSRun.CFG_FILE_PATH))
            self.objIosRun.getConfigData(getCfgDict)
            return True
        except Exception as err:
            print("ERROR: ", err)
            return False

    def triggerIosTestExecution(self):
        """
        Trigger test execution over iOS device
        """
        appiumPortNum = 4723
        wdaPort = 8100

        if (isinstance(self.objIosRun.deviceIdList, list)):
            try:
                for index, deviceName in enumerate(self.objIosRun.deviceIdList):
                        appiumPortNum = int(appiumPortNum) + 5
                        wdaPort = int(wdaPort) + 1
                        globals()['process%s' % index] = Process(target=self.objIosRun.robotSuiteExecutor,
                                                                 args=(self.objIosRun.objCommon.removeWhiteSpace(deviceName), self.objIosRun._getRemoteUrl(appiumPortNum),
                                                                       self.objIosRun._getServerPort(self.objIosRun._getRemoteUrl(appiumPortNum)), wdaPort))
                        globals()['process%s' % index].start()
            except Exception as err:
                print("ERROR: ", err)
                return False
        else:
            print("\nConnnected iOS Device not found...\n")
            return False

        # Wait till forked process completion
        [globals()['process%s' % index].join() for index, device in enumerate(self.objIosRun.iOSDeviceNameList)]

        return True
