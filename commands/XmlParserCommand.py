#!/usr/bin/env python

########################################################################
#
# - This script will convert XML data in to Dictionary.
#   Dictionary name is provided by User in command line
#
#######################################################################

import os
import sys
from XmlArgParser import *
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                '../commonlib')))
from XmlParser import XmlParser

def main():
    objDictConverter = XmlParser()
    if (args.config is None or args.dictname is None):
        print("Incorrect Option : config_file=%s , dictionary_name=%s"
              % (args.config, args.dictname))
        sys.exit(1)
    args.dictname = objDictConverter.xmlToDict(args.config)
    if args.dictname:
        print(args.dictname)
        sys.exit(0)
    else:
        sys.exit(1)

if __name__ == "__main__":
    main()
