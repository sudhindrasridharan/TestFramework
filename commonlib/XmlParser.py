#!/usr/bin/env python

############################################################################
#
# - XML Parser is used to convert xml file into dictionary.
# - XML Parser internally uses xmltodict Library.
# - XML Parser takes the absolute path of configuration file as an input
#   and return dictionary of xml file.
# - XML Parser inside Volanium is use for taking configurations from user.
#
############################################################################

import sys
import json
from Common import Common


class XmlParser:

    def __init__(self):
        self.objCommon = Common()

    def xmlToDict(self, fileName):
        """
        Function takes validated XML file and gives configuration data
        in terms of dictionary.
        Arguments = Absolute path of configuration file.
        Return Value = Configuration data in terms of dictonary.
        """
        try:
            orderedDict = self.objCommon.xmlParser(fileName)
            configJson = json.dumps(orderedDict)
            configDict = json.loads(configJson)
            return configDict
        except Exception as err:
            print("ERROR: ", err)
            return False
