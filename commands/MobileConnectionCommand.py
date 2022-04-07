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
import MobileConnectionParser
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                '../mobile/src/lib')))
from MobileConnection import MobileConnection


# Script Entry Point
if __name__ == '__main__':

    # Create MobileConnection object
    objMobileConnection = MobileConnection()
    action = MobileConnectionParser.cmdLineArgParser()

    if action is None:
        print(MobileConnectionParser.libUsage())
        sys.exit(1)

    try:
        if action == "StartAppiumServer":
            returnValue = objMobileConnection.startAppiumServer()
            print(returnValue)
        elif action == "StopAppiumServer":
            returnValue = objMobileConnection.stopAppiumServer()
            print(returnValue)
        elif action == "GetConnectedDeviceList":
            deviceList = objMobileConnection.checkAndroidDeviceConnection()
            print("Connected Device List:", deviceList)
        elif action == "StartADBServer":
            returnValue = objMobileConnection.adbStartServer()
            print(returnValue)
        elif action == "StopADBServer":
            returnValue = objMobileConnection.adbStopServer()
            print(returnValue)
        elif action == "GetConnectediOSDeviceIdList":
            returnValue = objMobileConnection.iOSDeviceProductId()
            print(returnValue)
        elif action == "GetConnectediOSDeviceNameList":
            udid = objMobileConnection.iOSDeviceProductId()
            returnValue = objMobileConnection.iOSDeviceProductName(udid)
            print(returnValue)
        elif action == "GetConnectediOSDeviceVersionList":
            udid = objMobileConnection.iOSDeviceProductId()
            returnValue = objMobileConnection.iOSDeviceProductVersion(udid)
            print(returnValue)
        elif action == "AppiumServerStatus":
            returnValue = objMobileConnection.checkAppiumServerStatus()
            if returnValue == '':
                print("Appium Server is not running")
                sys.exit(1)
            else:
                print("Appium Server running PID is " + str(returnValue))
                sys.exit(0)
        else:
            MobileConnectionParser.libUsage()
    except Exception as err:
        print("Error:", err)
        sys.exit(1)
