#!/usr/bin/env python

#########################################################################
#
# - MobileConnection Library is used to start/stop appium server,
#   start/stop ADB server.
# - MobileConnection Library is also used to check appium server status
#   and to check connected android devices.
# - MobileConnection Library inside Volanium is use for Mobile App
#   Connection.
#
##########################################################################

import os
import re
import subprocess
import sys
import time

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                '../../../commonlib')))
from Common import Common


class MobileConnection:

    def __init__(self):
        self.data = None
        self.devices = []
        self.objCommonFile = Common()
        self.deviceDataDict = {}

    def _adbDevices(self):
        """
        Gives the list of connected android devices
        """
        return self.objCommonFile.splitLines(subprocess.check_output
                                             (["adb", "devices"])
                                             .decode('utf-8'))

    def _listOfDevices(self):
        """
        Performs string operation on list of devices
        """
        for self.data in self.getdevices[1:]:
            deviceId, deviceStatus = re.split(r'\s+', self.data, maxsplit=1)
            self.deviceDataDict[deviceId] = deviceStatus
        self.devices.append(self.deviceDataDict)
        return self.devices

    def iOSDeviceProductId(self):
        """
        Give the List of UDIDs of connected iPhone Devices
        """
        try:
            iOSDeviceId = subprocess.Popen(["idevice_id", "-l"], stdout=subprocess.PIPE)
            iOSDeviceId = iOSDeviceId.communicate()[0].decode("utf-8").split()
            return iOSDeviceId
        except Exception as err:
            print("Error:", err)
            return False

    def iOSDeviceProductName(self, deviceUDIDList):
        """
        Give the list of name of connected iPhone Devices
        """
        try:
            iOSDeviceNameList = []
            for udid in deviceUDIDList:
                iOSDevice = subprocess.Popen(["ideviceinfo", "-k", "DeviceName", "-u", udid], stdout=subprocess.PIPE)
                iOSDeviceName = iOSDevice.communicate()[0].decode("utf-8").split()[-1]
                iOSDeviceNameList.append(iOSDeviceName)
            return iOSDeviceNameList
        except Exception as err:
            print("Error:", err)
            return False

    def iOSDeviceProductVersion(self, deviceUDIDList):
        """
        Give the list of Product Version of connected iPhone Devices
        """
        try:
            iOSDeviceVersionList = []
            for udid in deviceUDIDList:
                iOSDevice = subprocess.Popen(["ideviceinfo", "-k", "ProductVersion", "-u", udid], stdout=subprocess.PIPE)
                iOSDeviceVersion = iOSDevice.communicate()[0].decode("utf-8").split()[-1]
                iOSDeviceVersionList.append(iOSDeviceVersion)
            return iOSDeviceVersionList
        except Exception as err:
            print("Error:", err)
            return False

    def adbStartServer(self, portNum):
        """
        Start ADB Server on specific port
        """
        try:
            FNULL = open(os.devnull, 'w')
            subprocess.call(["adb", "-P", portNum, "start-server"],
                            stdout=FNULL,
                            stderr=subprocess.STDOUT)
            return True
        except Exception as err:
            print("Error:", err)
            return False

    def adbStopServer(self, portNum):
        """
        Stop ADB Server from specific port
        """
        try:
            if self.objCommonFile.killProcessByPort(portNum):
                return True
            else:
                return False
        except Exception as err:
            print("ERROR : ", err)
            return False

    def checkAppiumServerStatus(self):
        """
        Check that appium server is running or not.
        Return 0 if appium server is running otherwise 1.
        """
        try:
            pid = subprocess.Popen("pgrep [n]ode", shell=True,
                                   stdout=subprocess.PIPE)
            return pid.stdout.readline().decode('utf-8').rstrip()
        except Exception as err:
            print("Error:", err)
            return False

    def checkAndroidDeviceConnection(self, adbPort):
        """
        Gives the list of device IDs of connected android devices.
        Returns None incase of no device found.
        """
        try:
            self.adbStartServer(adbPort)
            self.getdevices = self._adbDevices()
            return self._listOfDevices()
        except Exception as err:
            print("Error:", err)
            return False

    def startAppiumServer(self, portNum):
        """
        Starts the Appium server on specific port
        """
        try:
            FNULL = open(os.devnull, 'w')
            port = int(portNum)
            bootStrapPort = int(portNum) + 1

            if str(os.environ["UITestFramework"]) == "uiautomator2":
                output = subprocess.Popen("appium -p {0}".format(port),
                                          shell=True,
                                          stderr=FNULL,
                                          stdout=subprocess.PIPE)
            else:
                output = subprocess.Popen("appium -p {0} -bp {1}".format(port,
                                      int(bootStrapPort)),
                                      shell=True,
                                      stderr=FNULL,
                                      stdout=subprocess.PIPE)
            while True:
                if "started" in output.stdout.readline().decode("UTF-8"):
                    time.sleep(3)
                    break
            return True
        except Exception as err:
            print("Error:", err)
            return False

    def stopAppiumServer(self, portNum):
        """
        Stops the Appium server from specific port
        """
        try:
            if self.objCommonFile.killProcessByPort(portNum):
                return True
            else:
                return False
        except Exception as err:
            print("ERROR : ", err)
            return False
