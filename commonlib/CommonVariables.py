#!/usr/bin/env python

###########################################################
#
# This Library consist of Global variables and Macros used
# across the multiple libraries of Sample.
#
###########################################################

# Macrors
ROBOT_EXT = 'robot'
CFG_FILE_PATH = "config/MobileConfig.xml"
SETTINGS_LOCATOR_FILE_PATH = "locators/android/"
CSV_REPORT_FILE_NAME = "results/TestReport"

# Global variables
execTest = None
execSuite = None
logReportDir = None
appiumPortNum = 4723
adbServerPort = 5037
wdaPort = 8100
execLogList = []
includedTag = ''
uiTestFramework = "uiautomator"

# SAMPLE Framework usage buffer
SAMPLE_USAGE = '''

        SAMPLE usage:
        ----------------------------------------------------------------------

        Below is the CLI options to run Sample:

        -c/--component - Execute specific Components(e.g. Android, iOS, web) test
                       - this is mandatory.
                       - Framework Support Following Test component:
                         (a) Android/android/ANDROID
                         (b) iOS/ios/IOS
                         (c) CloudLoad/cloudload
                         (d) CloudFunctional/cloudfunctional
                         (e) Web -> Not Supported
                         (f) Embedded -> Not Supported

        -s/--suite     - Absolute path of the robot test suite.
                       - This flag can take one or multiple test suite as
                         an input argument.
                       - this is mandatory.

        -t/--tag       - This flag allow to execute selected test categories from the test suites.
                         this is an optional.

        -r/--testrail  - This Flag allow you to update test result over testrail
                       - Flag Value should be "yes" if user want to update result over testrail

        ++++++++++++++++++++
        SAMPLE Run Command:
        ++++++++++++++++++++

        python TestDriver.py -c <TEST COMPONENT> -t <TEST TAG NAME> -s <TEST SUITE NAME>
        
        ---------
        Examples:
        ---------
               1. Run single test suite from test driver
                  a) Android : Run single test suite with ALL test cases:
                     Syntax  : python TestDriver.py -c <Test Component> -s '<suite name>'
                     Example : python TestDriver.py -c Android -s 'demoSuite'

                  b) iOS     : Run single test suite with ALL test cases:
                     Syntax  : python TestDriver.py -c <Test Component> -s '<suite name>'
                     Example : python TestDriver.py -c ios -s 'demoSuite'

                  c) CloudFunctional : Run Single test suite with ALL test cases :
                     Syntax          : python TestDriver.py -c <Test Component> -s '<suite name>'
                     Example         : python TestDriver.py -c cloudfunctional -s 'demoSuite'

                  d) CloudLoad : Run Single test suite with ALL test case :
                     Syntax    : pyhton TestDriver.py -c <Test Component> -s '<suite name>'
                     Example   : python TestDriver.py -c cloudload -s 'demoSuite'

               2. Run multiple test suite with ALL test cases:
                  Syntax  : python TestDriver.py -c <Test Component> -s '<suite1> <suite2> <suite3>'
                  Example : python TestDriver.py -c Android -s 'demoSuite1 demoSuite2 demoSuite3'
                  [Note]: there must be a single space between two suite name

               3. Run single test suite with selective test cases:
                  Syntax  : python TestDriver.py -c <Test Component> -s '<suite name>' -t '<test tag name>'
                  Example : python TestDriver.py -c ios -s 'demoSuite' -t 'smoke_test'

               4. Run multiple test suite with selective test cases:
                  Syntax  : python TestDriver.py -c <Test Component> -s '<suite1> <suiteN>' -t '<test tag name>'
                  Example : python TestDriver.py -c Android -s 'demoSuite1 demoSuite2' -t 'smoke_test'
                  [Note]: there must be a single space between two suite name

               5. Execute only sanity and smoke test from test suite
                  Syntax  : python TestDriver.py -c <Test Component> -s '<suite name>' -t '<test tag name1> <test tag name2>'
                  Example : python TestDriver.py -c -s 'demoSuite' -t 'sanity_test smoke_test'
                  [Note]: There must be a single space between two tag name

                  [Note]: Before start execution of selected test cases from suite,
                          Make sure that your robot script must consist of Tags.

        ----------------------------------------------------------------------

        '''
