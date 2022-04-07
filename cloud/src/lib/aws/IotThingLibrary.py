#!/usr/bin/env python

#################################################################
#
# This libray provide interface to IOT Things in order to
# Update Thing Shadow and get shadow details.
#
#################################################################

import boto3
import json
import ast


class IotThingLibrary:

    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def __init__(self):
        self.iotClient = None

    def createAwsIotSession(self, accessKey, secKey, region):
        """
        Start New AWS IOT session
        """
        try:
            self.iotClient = boto3.client('iot-data',
                                      aws_access_key_id=accessKey,
                                      aws_secret_access_key=secKey,
                                      region_name=region
				     )
            return True
        except Exception as err:
            print("ERROR: ", err)
            return False

    def updateThingShadow(self, thingNameStr, payload):
        """
        Updates the thing shadow for the specified thing.
        """
        try:
            return self.iotClient.update_thing_shadow(
                thingName = thingNameStr,
                payload=json.dumps(eval(payload))
                )
        except Exception as err:
            print("ERROR: ", err)
            return False

    def getThingShadow(self, thingNameStr):
        """
        Gets the thing shadow for the specified thing.
        """
        try:
            shadowData = self.iotClient.get_thing_shadow(
                                 thingName = thingNameStr
                                )
            byteData = shadowData["payload"].read()
            return json.loads(byteData.decode("utf-8").replace("'",'"'))
        except Exception as err:
            print("ERROR: ", err)
            return False
