#!/usr/bin/env python

############################################################################
#
# AppiumWrapper is Mobile Application test library for Volanium it
# uses the Appium library to control the Mobile App actions.
#
# This Library deliver keywords enhancement for robotframework AppiumLibrary
# and its used to execute test actions on mobile device/simulator.
#
############################################################################

from AppiumLibrary import AppiumLibrary


class AppiumWrapper(AppiumLibrary):

    def __init__(self):
        AppiumLibrary.__init__(self, timeout=5, run_on_failure='Nothing')

    def wait_until_element_is_visible(self, locator, timeout=None, error=None):
        """ Deprecated wait_until_element_is_visible API
        with wait_until_page_contains_element"""
        self.wait_until_page_contains_element(locator, timeout, error)
