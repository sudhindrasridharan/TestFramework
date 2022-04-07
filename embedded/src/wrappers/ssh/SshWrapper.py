#!/usr/bin/env python

##################################################################
#
# This Python script provide the keyword enhancement for the
# RobotFramework SSH library.
#
##################################################################

from SSHLibrary import SSHLibrary


class SshWrapper(SSHLibrary):
    def __init__(self):
        SSHLibrary.__init__(self)