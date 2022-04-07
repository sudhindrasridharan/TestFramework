#!/usr/bin/env python

#############################################################
#
# This script used to execute Test Report Generator
# Library(TestReportGenerator.py) from command line.
#
#############################################################

import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                                             '../commonlib')))
from TestReportGenerator import TestReportGenerator
import TestReportParser


# Script Entry Point
if __name__ == '__main__':

    # Create ImageProcess object
    objTestReporter = TestReportGenerator()
    if len(sys.argv) < 2:
        TestReportParser.libUsage()
    try:
        if objTestReporter.generateCsvReport(TestReportParser.cmdLineArgParser()) == True:
            sys.exit(0)
        else:
            print("Error: Failed To Generate CSV report from XML file !!")
            sys.exit(1)
    except Exception as err:
        print("ERROR : ", err)
        sys.exit(1)
