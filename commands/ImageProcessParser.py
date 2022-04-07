#!/usr/bin/env python

#################################################
#
# Argument Parser for Command line testing of
# Image Process Library
#
#################################################

import argparse
import sys


def libUsage():
    """
    Display Image Process Library Usage
    """

    usageBuf = """

            -------------------------------------------------------------------
            - An ImageProcess library is used to convert image into text
            - This library takes an image file as an input and return text data

            Syntax:
                python ImageProcessor.py -I/--imagePath <ImageFilePath>

            Example:
                1. python ImageProcessor.py -I ~/test.png
                2. python ImageProcessor.py --imagePath ~/test.png
            -------------------------------------------------------------------

    """
    print(usageBuf)
    sys.exit(0)


def cmdLineArgParser():
    """
    Command Line Argument Parser for Image Process Library
    """
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument('-h', '--help', action='store_true', help='help')
    parser.add_argument('-v', '--verbose', required=False, help='verbose')
    parser.add_argument('-I', '--imagePath', help='An absolute path to image, \
                        this is mandatory argument')
    try:
        args = parser.parse_args()
    except:
        libUsage()

    if args.help:
        libUsage()

    return str(args.imagePath)
