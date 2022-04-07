#!/usr/bin/env python

##############################################################################
#
# RequestWrapper is Cloud Application test library for Volanium it
# uses the Request library to perform cloud actions.
#
# This Library deliver keywords enhancement for robotframework requestLibrary.
#
##############################################################################

from RequestsLibrary import RequestsLibrary


class HttpWrapper(RequestsLibrary):
    def __init__(self):
        RequestsLibrary.__init__(self)
