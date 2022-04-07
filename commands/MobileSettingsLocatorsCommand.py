#!/usr/bin/env python

########################################################################
#
# - This script will convert XML file in to robot file.
#
#######################################################################

import os
import sys
from MobileSettingsLocatorsParser import *
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                '../mobile/src/lib/')))
from MobileSettings import MobileSettings


def main():
    objMobileSettings = MobileSettings()
    if (args.configfile is None or args.robotfile is None):
        print("Incorrect Option : config_file_path=%s , robot_file_path=%s"
              % (args.configfile, args.robotfile))
        sys.exit(1)
    objMobileSettings.xmlToRobot(args.configfile, args.robotfile)


if __name__ == "__main__":
    main()
