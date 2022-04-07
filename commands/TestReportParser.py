#!/usr/bin/env python

#################################################
#
# Argument parser for Command line testing of
# CSV test report generator library
#
#################################################

import argparse
import sys


def libUsage():
    """
    Display Test Report Generator Library Usage
    """

    usageBuf = """

            ------------------------------------------------------------------
            - Test Report Library used to generate CSV report from robot XML
            - Library takes robot XML file as input and generate CSV report

            Syntax:
                python TestReportGenerator.py -X/--xmlPath <xmlFileAbsPath>

            Example:
                1. python TestReportGenerator.py -X output.xml
                2. python TestReportGenerator.py --xmlPath home/usr/test.xml
            -------------------------------------------------------------------

    """
    print(usageBuf)
    sys.exit(0)


def cmdLineArgParser():
    """
    Command Line Argument Parser for Test Report Generator Library
    """
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument('-h', '--help', action='store_true', help='help')
    parser.add_argument('-v', '--verbose', required=False, help='verbose')
    parser.add_argument('-X', '--xmlPath', help='An absolute path to XML, \
                        this is mandatory argument')
    try:
        args = parser.parse_args()
    except:
        libUsage()

    if args.help:
        libUsage()

    return str(args.xmlPath)
