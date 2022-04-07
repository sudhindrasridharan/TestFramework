#!/usr/bin/env python

#################################################
#
# Test Handler for Embedded device automation
#
#################################################

import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                '../embedded/')))
import EmbeddedRun


class EmbeddedHandler:

    def __init__(self):
        self.objEmbeddedRun = EmbeddedRun.EmbeddedRun()

    def setEmbeddedPrerequisite(self, testSuite, testTag):
        """
        Set Prerequisite to Start Embedded device Execution
        """
        # update suite to be execute
        EmbeddedRun.execSuite = testSuite
        # Update test tags to be execute
        EmbeddedRun.execTest = testTag
        return True

    def triggerEmbeddedTestExecution(self):
        """
        Trigger Test Execution over Embedded Device
        """
        self.objEmbeddedRun.robotSuiteExecutor()
        return True