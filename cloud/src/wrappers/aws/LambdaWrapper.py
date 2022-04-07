#!/usr/bin/env python

#######################################################################
#
# - This File Provide an interface to AWS Lambda library.
# - This Library deliver keywords enhancement for AWS Lambda Library
#
#######################################################################

import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                                             '../../lib/aws')))
from Lambda import Lambda


class LambdaWrapper(Lambda):
   def __init__(self):
        Lambda.__init__(self)
