#!/usr/bin/env python

#######################################################################
#
# - This File Provide an interface to AWS IOT library.
# - This Library deliver keywords enhancement for AWS IOT Library
#
#######################################################################

import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                                             '../../lib/aws')))
from IotThingLibrary import IotThingLibrary


class IotWrapper(IotThingLibrary):
   def __init__(self):
        IotThingLibrary.__init__(self)

