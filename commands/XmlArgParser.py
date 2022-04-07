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
            --------------------------------------------------------------------------------------
            - XmlParser library will convert xml file into dictionary
            - Input:
                -c : Absolute path of a XML File.
                     This is Mandatory.
                -d : Dictionary Name to store the XML data.
                     This is Mandatory.
            - Return:
                Dictionary is printed on the stdout
            - Syntax:
                python XmlparserCommand.py -c/--config <pathOfConfigfile> -d/--dictname <nameOfDict>                 
            - Example:
                1. python XmlParserCommand.py -c ~/Config.xml -d mobileConfigDict
                2. python XmlParserCommand.py --config ~/Config.xml -dictname mobileConfigDict
                3. python XmlParserCommand.py -d mobileConfigDict -c Config.xml
                4. pyhton XmlParserCommand.py -dictname mobileConfigDict --config Config.xml
            ---------------------------------------------------------------------------------------
        """
    print(usageBuf)
    sys.exit(0)


parser = argparse.ArgumentParser(add_help=False)
parser.add_argument('-h', "--help", action="store_true")
parser.add_argument('-c', "--config", dest="config")
parser.add_argument('-d', "--dictname", dest="dictname")
parser.add_argument('-v', "--verbose", action='count')
try:
    args = parser.parse_args()
except:
    libUsage()

if args.help:
    libUsage()
