#!/usr/bin/env python

##########################################
#
# This program consists of argument parser
# for Mobile test clean up module.
#
##########################################

import sys
import argparse


def libUsage():
    """
    Display Mobile Test Cleanup Library Usage
    """
    usageBuf = """
            ----------------------------------------------------------------------------
            - Input:
                -a: Actions To Be Perform
                    This is Mandatory
            - Actions :
                - CreateTempDirectory:
                    That will create Temporary Directory
                - CleanUpTempDirectory:
                    That will delete Temporary Directory
                - CreateTempFile:
                    That will create Temporary File
                - CleanUpTempFile:
                    That will delete Temporary File
            - Return:
                Return based upon the action function
            - Syntax:
                python MobileCleanUpCommand.py -a/--action <action to be perform>

            Example:
                1. python MobileCleanUpCommand.py -a CleanUpTempDirectory
                2. python MobileCleanUpCommand.py --action CleanUpTempDirectory
            ----------------------------------------------------------------------------
        """
    print(usageBuf)
    sys.exit(0)


def cmdLineArgParser():
    """
    Command Line Argument Parser for Mobile Connection Library
    """
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument('-h', "--help", action="store_true")
    parser.add_argument('-v', "--verbose", action="store_true")
    parser.add_argument('-a', "--action", dest="action")

    try:
        args = parser.parse_args()
    except:
        libUsage()

    if args.help:
        libUsage()
    return args.action
