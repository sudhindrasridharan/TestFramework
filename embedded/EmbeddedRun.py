#!/usr/bin/env python

##################################################
#
# This Python file is entry point for embedded module
#
# Script performs below actions:
#
#    1. Reads Configuration data from config file
#       and pass it to the test suite.
#    2. Triggers Test script with required parameters
#    3. Generates Test Result Report and save at
#       perticular location.
#    4. Creates CSV Resut Report
#
##################################################

import sys
import os
import getopt
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                '../commonlib/')))
import Common
from CommonVariables import *
import TestReportGenerator


class EmbeddedRun:

    def __init__(self):
        self.objCommon = Common.Common()
        self.objTestReport = TestReportGenerator.TestReportGenerator()

    def robotSuiteExecutor(self):
        """
        Configure environment as per test suite and start test execution
        """
        global logReportDir
        global includedTag

        allSuiteList = str(execSuite).split()

        for testSuite in allSuiteList:
            # prepare cmd to trigger the robot execution
            robotRunCmd = ROBOT_EXT

            # get current date-time to dump logs at appropriate location
            execStartTime = self.objCommon.getCurrentTime("%Y%m%d%H%M%S")
            if execStartTime:
                logReportDir = 'logs/{0}/{1}/{2}/'.format(str(execStartTime[:4]),
                                                          str(execStartTime[4:6]),
                                                          str(execStartTime[6:8])
                                                          )
                os.environ['logDir'] = logReportDir
                robotRunCmd = '{0} -o {1}output_{2}.xml -l {1}log_{2}.html -r {1}report_{2}.html'.format(
                                                                                            robotRunCmd,
                                                                                            logReportDir,
                                                                                            execStartTime
                                                                                            )

                robotXml = '{0}output_{1}.xml'.format(str(logReportDir), str(execStartTime))

                # Add only selected test in execution
                if execTest:
                    tagsList = execTest.split()
                    for tag in tagsList:
                        includedTag += '--include {0} '.format(tag)
                    robotRunCmd = "{0} {1}".format(robotRunCmd, includedTag)

                if os.environ["testRailListnerCmd"] != "":
                    robotRunCmd = "{0} {1}".format(robotRunCmd, os.environ["testRailListnerCmd"])

                robotRunCmd = '{0} {1}.robot'.format(robotRunCmd, str(testSuite))

            # Trigger to test suite execution
            if self.objCommon.startRobotExec(robotRunCmd):
                # Generate csv report
                self.objTestReport.generateCsvReport(robotXml, CSV_REPORT_FILE_NAME)
