#!/usr/bin/env python

##########################################
#
# This program consists of argument parser
# for Mobile Connection module
#
##########################################

import sys
import argparse


def libUsage():
    """
    Display Mobile Connection Library Usage
    """
    usageBuf = """
            --------------------------------------------------------------------------------------------
            Enter Correct Action Name:

            Android:

            - StartAppiumServer:
                    That will Start Appium Server
            - StopAppiumServer:
                    That will Stop Appium Server
            - GetConnectedDeviceList:
                    That will give a list of connected devices
            - StartADBServer:
                    That will Start ADB Server
            - StopADBServer:
                    That will Stop ADB Server
            - AppiumServerStatus:
                    That will Gives PID of Appium Server Process

            iOS:

            - GetConnectediOSDeviceIdList
                    That will give the list of udid of connected iOS devices
            - GetConnectediOSDeviceNameList
                    That will give the list of names of connected iOS devices
            - GetConnectediOSDeviceVersionList
                    That will give the list of versions of connected iOS devices

            Example:
                1. python MobileConnectionCommand.py -a StartAppiumServer
                2. python MobileConnectionCommand.py --action GetConnectedDeviceList
            --------------------------------------------------------------------------------------------
        """
    print(usageBuf)
    sys.exit(0)


def cmdLineArgParser():
    """
    Command Line Argument Parser for Mobile Connection Library
    """
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument('-h', "--help", action="store_true", help="help")
    parser.add_argument("-v", "--verbose", action="store_true",
                        help="verbose mode")
    parser.add_argument('-a', "--action", dest="action",
                        help="Server action to be perform, this is mandatory")

    try:
        args = parser.parse_args()
    except:
        libUsage()

    if args.help:
        libUsage()
    return args.action
