#!/usr/bin/env python

#############################################################
#
# This script used to execute Python Image Process
# Library(ImageProcess.py) from command line.
#
#############################################################

import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                                             '../mobile/src/lib')))
from ImageProcess import ImageProcess
import ImageProcessParser

# Script Entry Point
if __name__ == '__main__':

    # Create ImageProcess object
    objImageProcess = ImageProcess()
    if len(sys.argv) < 2:
        ImageProcessParser.libUsage()
    try:
        rawImageData = objImageProcess.imageToStringConverter(
                                ImageProcessParser.cmdLineArgParser())
        if rawImageData == 1:
            sys.exit(1)
        elif rawImageData == 2:
            print("Exception during image to string conversation...")
            sys.exit(1)
        else:
            print(rawImageData)
            sys.exit(0)
    except Exception as err:
        print("ERROR : ", err)
        sys.exit(1)
