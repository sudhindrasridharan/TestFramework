#!/usr/bin/env python

##########################################################################
#
# - MobileSettings Library is used to make a robot file which consists of,
#   Mobile Settings page Locators.
#
##########################################################################

import os
import sys
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                '../../../commonlib')))
from XmlParser import XmlParser

documentation = "Documentation    This File Consists of all Locators for Mobile Settings Page."


class MobileSettings: 

    def __init__(self):
        self.objXmlParser = XmlParser()

    def xmlToRobot(self, FileName, robotFileName):
        """
        Function takes validated XML file and gives Robot File
        Argument : Absolute Path of xml file
        Return : True if robot file successfully created at proper location
        """
        try:
            settingsDataDict = self.objXmlParser.xmlToDict(FileName)
            with open(robotFileName, 'w') as mobileSettingsLocatorsFile:
                mobileSettingsLocatorsFile.write(documentation + '\n' + '\n')
                mobileSettingsLocatorsFile.write("{:*^17s}\n\n".format(" Variables "))
                for key, value in settingsDataDict.items():
                    for dictKeys, dictValues in value.items():
                        mobileSettingsLocatorsFile.write("${%s}    %s\n"  % (dictKeys, dictValues))
            return True
        except Exception as err:
            print("Error :", err)
            return False
