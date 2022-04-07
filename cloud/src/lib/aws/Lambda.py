#!/usr/bin/env python

###########################################################
#
# This Library provides an interface to the AWS Lambda
# In order to invoke different lambda functions.
#
###########################################################

import boto3
import json
import os
import sys
import subprocess
import time
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                '../../../../commonlib')))
from Common import Common


class Lambda:

    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def __init__(self):
        self.objCommonFile = Common()
        self.lambdaClient = None

    def createAwsLambdaSession(self, accessKey, secKey, region):
        """
        Start AWS Lambda Session in order to invoke Lambda Function
        """
        try:
            self.lambdaClient = boto3.client('lambda',
                                         aws_access_key_id=accessKey,
                                         aws_secret_access_key=secKey,
                                         region_name=region
					)
            return True
        except Exception as err:
            print("ERROR: ", err)
            return False
        
    def invokeAwsLambda(self, funcName, Payload, invocType, LogType):
        """
        Invoke AWS Lambda
        """
        try:
            return self.lambdaClient.invoke(
                                FunctionName = str(funcName),
                                InvocationType = str(invocType),
                                LogType = str(LogType),
                                Payload = json.dumps(eval(Payload))
                                )
        except Exception as err:
            print("ERROR: ", err)
            return False

    def startNodeJsServer(self):
        """
        Start Node JS Server in Background
        """
        curDir = os.getcwd()
        os.chdir("{0}/{1}".format(curDir, "plugins/Server"))

        try:
            FNULL = open(os.devnull, 'w')
            output = subprocess.Popen("npm start",
                                      shell=True,
                                      stderr=FNULL,
                                      stdout=subprocess.PIPE
				     )
            while True:
                if "start" in output.stdout.readline().decode("UTF-8"):
                    break
            time.sleep(5)
            return True
        except Exception as err:
            print("Error:", err)
            return False

    def stopNodeJsServer(self, serverPort):
        try:
            if self.objCommonFile.killProcessByPort(serverPort):
                return True
            else:
                return False
        except Exception as err:
            print("ERROR : ", err)
            return False
