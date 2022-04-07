#!/usr/bin/env python

##################################################################
#
# This Python script provide the keyword enhancement for the
# RobotFramework serial library.
#
##################################################################

from SerialLibrary import SerialLibrary


class SerialWrapper(SerialLibrary):
    def __init__(self):
        SerialLibrary.__init__(self)