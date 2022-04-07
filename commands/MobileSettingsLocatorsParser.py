#!/usr/bin/env python

##########################################
#
# This script consists of argument parser
#
##########################################

import sys
import argparse


def libUsage():
    usageBuf = """
            ---------------------------------------------------------------------------------------------------
            - MobileSettings library will convert xml file into robot file
            - Input:
                -c : Absolute path of a XML File.
                     This is Mandatory.
                -r : Absolute path of a Robot File.
                     This is Mandatory.
            - Return:
                Robot file which consists of all Mobile settings page locators defined by user in config file
            - Syntax:
                python XmlparserCommand.py -c/--config <pathOfConfigfile>            
            - Example:
                1. python XmlParserCommand.py -c ~/Configfile.xml -r ~/Robotfile.robot
                2. python XmlParserCommand.py --configfile ~/Configfile.xml -robotfile ~/Robotfile.robot
            ----------------------------------------------------------------------------------------------------
        """
    print(usageBuf)
    sys.exit(0)


parser = argparse.ArgumentParser(add_help=False)
parser.add_argument('-h', "--help", action="store_true")
parser.add_argument('-c', "--configfile", dest="configfile")
parser.add_argument('-r', "--robotfile", dest="robotfile")
parser.add_argument('-v', "--verbose", action='count')
try:
    args = parser.parse_args()
except:
    libUsage()

if args.help:
    libUsage()
