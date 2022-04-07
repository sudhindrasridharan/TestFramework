********************************************************************************
                      Volanium Test Framework - Android Module
                                ReadMe.txt
                               Version 0.1
                               31/05/2018
         Copyright © 2018-2019 Volansys Technologies: All rights reserved.
********************************************************************************

1. INTRODUCTION
===============
 
 -> Volanium Test Framework Mobile Module is use to test Individual Mobile 
    Application and as a component of whole IOT Eco-system with different 
    Android Versions and with different Android phones.


2. PREREQUISITES
================
 
 -> Linux Ubuntu-14.04 
 -> System RAM >= 4.0 GB
 -> Python - 3.4.3
 -> Python package management system(pip) should be installed in the system.


3. INSTALLATION
=======================

 -> Installation of android-sdk
    - Download android studio from "https://developer.android.com/studio/index.html"
        - Go to Downloads folder and unzip the installed android-studio package
        - Go to android-studio/bin folder and run "./studio.sh" it will open Android Studio
        - Click on "Configure" and select SDK Manager it will open Android SDK installation page
        - In Android SDK Location provide where you want to keep your android-sdk (Ex: /home/<userName>/android-sdk)
        - Select android sdk package to be install and click on OK
        - It will Install android-sdk over given location

  -> Run the ubuntu_install.sh script.
    $ chmod +x ubuntu_install.sh
    $ ./ubuntu_install.sh <path to Android SDK>
    e.g: ./ubuntu_install.sh /home/<user>/android-sdk
 
      
4. STEPS TO USE MOBILE MODULE OF VOLANIUM - TEST AUTOMATION FRAMEWORK
====================================================================

 -> Download the Repository of Volanium Test Framework from below link:
    - git clone http://gitlab.volansys.com/gitrepo/Volanium.git
 
 -> Go to mobile module.
    - $ cd Volanium
    - $ cd mobile

 -> Add details in Configuration file.
    - $ cd config
    - Open Config.xml file and fill-up all details in that file.
      - Add following details:
        1) PlatformName - Add Name of platform (Android/ios)
        2) ApkPath - Add Absolute path of .apk file (e.g. bin/Amazon.apk)
        3) AppPackage - Add Package of Application
        4) AppActivity - Add Application Activity
        5) UserName - Add Registered User Name for Login Activity
        6) Password - Add Registered Password for Login Activity
        7) MobSettingPageXpathFileName - Add the name of mobile settings xml file which is
                               going to use to take Mobile Settings page Locators.
        8) DataFilePath - Give the absolut path of special case locator/label file.
        9) UITestFramework - Add Android UI testing framework
        
    - Open MobileSettings.xml and fill-up all required locators of phone
      on which test is going to conduct.
      - This file is updatable as per requirement.
      - Some common mobile settings page tags are available in file.
        e.g. WifiToggleSwitch - Add locator of toggle button which can enable and 
                                disable wifi connection.
             MobileDataToggleSwitch - Add locator of toggle button which can enable
                                and disable mobile data connection. 
    
 -> Add Application.apk file.
    - Go to "bin" directory and add you application.apk file into it.
      $ cd bin
       e.g. Volanium/mobile/bin/Amazon.apk

 -> Add Required Application Locators.
    - Go to "locators" directory.
      $ cd locators
    - Make a individual folder for you application here and add all locators
      in robot file.
      e.g. Volanium/mobile/locators/Amazon/AmazonLocators.robot
 
 -> Information related to Available keywords
    - Go to "help" directory.
      $ cd help
      e.g. Volanium/mobile/help/Android.html

 -> Add your Application Test Suite and write different test script.
    - Go to "testsuite" directory and make a Test Suite for Application Test
      e.g. Volanium/testsuite/AmazonAppTestSuite
    - Make a Application Test Script in test suite.
      e.g. Volanium/testsuite/AmazonAppTestSuite/AmazonLoginTest.robot
    - To Use Mobile related, Android related and Clean-Up related Keywords
      in Test Script import Mobile.robot(Volanium/mobile/resource/Mobile.robot), 
      import Android.robot(Volanium/mobile/resource/Android.robot) and 
      import MobileCleanUp.robot(Volanium/mobile/resource/MobileCleanUp.robot)
      file in your Test Script.


5. HOW TO RUN TEST SUITE USING VOLANIUM TEST FRAMEWORK
=====================================================

 -> Execute TestDriver.py File with required arguments.

    Below is the CLI options to run Volanium:

        -c/--component - Execute specific Components(e.g. Android, ios, web, cloud) test
                       - This flag can take components arguments as an input
                         (Execution of Android and iOS components can not be possible at the same time)
                       - this is mandatory.
                       - Framework Support Following Test component:
                         (a) Android
                         (b) iOS
                         (c) Cloud - Not supported in current release
                         (d) Web - Not supported in current release
                         (e) Embedded - Not supported in current release

        -s/--suite     - Absolute path of the robot test suite.
                       - This flag can take one or multiple test suite as
                         an input argument.
                       - this is mandatory.

        -t/--tag       - This flag allow to execute selected test categories from the test suites.
                         this is an optional.

        Examples:
        ---------
               1. Run single test suite from test driver
                  a) Android : Run single test suite with ALL test cases:
                     Syntax  : python TestDriver.py -c <Test Component> -s '<suite name>'
                     Example : python TestDriver.py -c Android -s 'demoSuite'

                  b) iOS     : Run single test suite with ALL test cases:
                     Syntax  : python TestDriver.py -c <Test Component> -s '<suite name>'
                     Example : python TestDriver.py -c ios -s 'demoSuite'

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

# Note: Framework Also support parallel device execution. if user has connected multiple device
        It will execute same test suites over all the connected devices regardless of android versions
        and model of phone.

6. TEST RESULT OF EXECUTED TEST SUITE/SPECIFIC TEST CASE
========================================================

 -> Volanium Test Framework creates test execution result in csv format.
 -> CSV file contains below sections:
    - Name of Test suite
    - Name of Test Case
    - Test case ID
    - Test Case category
    - Start time of test case excecution
    - End time of test case execution
    - Test status and any required comment section
    - Total Number of Test cases
    - Total Number of Test cases passed
    - Total Number of Test cases failed 
 -> To show Result, Go to "results" directory.
    - cd results
      e.g. Volanium/results/TestReport_AmazonLoginTest_1527508216.csv
      - Name of resultant csv file contains TestSuiteName and Epoch time.


7. TEST LOGS OF EXECUTED TEST SUITE/SPECIFIC TEST CASE
====================================================== 

 -> Volanium Test Framework generates test execution resultant logs in html format.
 -> Framework uses log tracking mechanism like - year/month/date/time.
 -> To Show resultant logs, Go to "logs" directory.
    - cd logs
      e.g. Volanium/logs/2018(year)/05(month)/31(date)/log_20180531161428.html


8. BUILT-IN VARIABLES
=====================
-> User can directly use following builtin variables into test script.
   1. ${remoteURL}
   2. ${deviceId}
   3. ${appiumServerPort}
   4. ${adbServerPort}
   5. %{UserName}
   6. %{Password}
