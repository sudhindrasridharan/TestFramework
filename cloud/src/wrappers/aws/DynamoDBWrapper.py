#!/usr/bin/env python

#######################################################################
#
# - This File Provide an interface to AWS Dynamo DB library.
# - This Library deliver keywords enhancement for DynamoDB Library
#
#######################################################################

import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__),
                                             '../../lib/aws')))
from DynamoDBLibrary import DynamoDBLibrary


class DynamoDBWrapper(DynamoDBLibrary):
    def __init__(self):
        DynamoDBLibrary.__init__(self)
