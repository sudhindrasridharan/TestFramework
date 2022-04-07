#!/usr/bin/env python

#################################################
#
# - Test Handler for Cloud automation
# - Cloud Handler is a intermediate stage between
#   Test Driver and cloud Test Executor
#
# - Cloud Handler performs below operations:
#   1. Initialize Cloud Test Executor
#   2. Trigger Test execution on cloud
#
#################################################

import sys
import os
from multiprocessing import Process
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                '../cloud/')))
import CloudRun


class CloudHandler:
	
    def __init__(self):
        self.objCloudRun = CloudRun.CloudRun()
	
    def setCloudPrerequisite(self, testSuite, testTag):
        """
        Set Prerequisite to Start Cloud Functional/Load Execution
        """
        # update suite to be excute
        CloudRun.execSuite = testSuite
        # Update test tags to e execute
        CloudRun.execTest = testTag
        return True

    def triggerCloudTestExecution(self):
        """
        Trigger Functional/Cloud Test Execution on Cloud
        """
        self.objCloudRun.robotSuiteExecutor()
        return True
