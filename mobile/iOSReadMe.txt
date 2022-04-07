********************************************************************************
                    Volanium Test Framework - iOS Module
                              ReadMe.txt
                              Version 0.1
                              04/07/2018
         Copyright © 2018-2019 Volansys Technologies: All rights reserved.
********************************************************************************

1. INTRODUCTION
===============
 
 -> Volanium Test Framework Mobile Module is use to test Individual Mobile
    Application and as a component of whole IOT Eco-system with different 
    iOS Versions and with different iphones.


2. PREREQUISITES
================
 
 -> mac OS >= 10.13.04 
 -> System RAM >= 4.0 GB
 -> Xcode Version - 9.4(Depend upon your iPhone OS)
    - If Not installed, find the steps to install it
      - Go to App Store
      - Search for Xcode-9.4
      - Install Xcode-9.4 by clicking "Get" button 
      - Move Xcode-9.4 into Application Directory
      - Launch Xcode by double clicking on it's icon in Application directory
 -> Application ipa file
 -> Application BundleId
 -> Application Provision profile file
 -> Application Certificate
    - This is application dependent, add this by double clicking on it 
 -> iPhone device(device in which test will be conducted)should be registered in application's account
 -> Python - 3.4
 -> Python package management system(pip) compatible with python 3.4 should be installed in the system.

3. INSTALLATION
===============

 -> Run the ios_install.sh script.
    $ chmod +x ios_install.sh
    $ ./ios_install.sh
              
 -> Installation of Appium-Desktop Application
    - Refer below link for installation of Appium Desktop 
       https://github.com/appium/appium-desktop


4. STEPS TO BUILD Xcode FOR SPECIFIC APPLICATION - ONE TIME EFFORT
==================================================================

 -> Connect your iPhone device with the test system
 -> Add all required details in WebDriverAgent.xcodeproj file
    - Go to this Location : /usr/local/lib/node_modules/appium/node_modules/appium-xcuitest-driver/WebDriverAgent
    - Open the WebDriverAgent.xcodeproj file with Xcode-9.4
    - Change the file access permission if needed, refer link to change the file permission,  
      https://stackoverflow.com/questions/32900750/xcodeproj-file-permissions
    - Go to Project Field, where you can find below files:
      WebDriverAgentLib
      WebDriverAgent Runner
      UnitTests
      IntegrationTest_1
      IntegrationTest_2
      IntegrationTest_3
      IntegrationApp
 -> Go to IntegrationApp and add application BundleId and import provision file in all above file where it is required.
 -> Build the Xcode using "Run" icon available at left most corner.      
 -> Open the terminal after successful build and go to location - /usr/local/lib/node_modules/appium/node_modules/appium-xcuitest-driver/WebDriverAgent
 -> Run below commands :
    - bash Scripts/bootstrap.sh -d
    - mkdir -p Resources/WebDriverAgent.bundle
    - xcodebuild -project WebDriverAgent.xcodeproj -scheme WebDriverAgentRunner -destination 'id=<udid of device>' test
      Kill the above process after WebDriverAgent is installed in the iPhone


5. STEPS TO FETCH LOCATORS OF UI ELEMENTS OF AN iOS APPLICATION 
===============================================================

  -> After the succesful Xcode build,Open Appium Desktop Application
  -> Start Inspector Session
  -> Give application specific desired capability and Start the session, 
     Eg.     
     {
      "deviceName": "Volansys's iPhone",
      "platformName": "iOS",
      "platformVersion": "11.2.1",
      "automationName": "XCUITest",
      "udid": "61c8f098f6319e9e6d66dd44e5435b86386a096b",
      "bundleId": "com.volansys.mgr",
      "bootstrapPath": "/usr/local/lib/node_modules/appium/node_modules/appium-xcuitest-driver/WebDriverAgent",
      "app": "/Users/mahesh.velani/Downloads/modular.ipa",
      "agentPath": "/usr/local/lib/node_modules/appium/node_modules/appium-xcuitest-driver/WebDriverAgent/WebDriverAgent.xcodeproj"
     }


6. STEPS TO USE iOS MODULE OF VOLANIUM - TEST AUTOMATION FRAMEWORK
==================================================================

 -> Download the Repository of Volanium Test Framework from below link:
    - git clone http://gitlab.volansys.com/gitrepo/Volanium.git
 
 -> Go to mobile module.
    - $ cd Volanium
    - $ cd mobile

 -> Add details in Configuration file.
    - $ cd config
    - Open Config.xml file and fill-up all details in that file.
      - Add following details:
        1) ipaPath - Absolute file path of IPA File, This is Mandatory
        2) ipaBundleId - BundleId of an application to be tested, This is Mandatory
        3) UserName - Credentials of an application to be tested, This is Optional
        4) Password - Credentials of an application to be tested, This is Optional
        5) BootstrapPath - Absolute Bootstrap path, This is Mandatory
        6) AgentPath - Absolute Agent path, This is Mandatory 
    
 -> Add Application.ipa file.
    - Go to "bin" directory and add you application.ipa file into it.
      $ cd bin
       e.g. Volanium/mobile/bin/ModularGateWay.ipa

 -> Add Required Application Locators.
    - Go to "locators" directory.
      $ cd locators
    - Make a individual folder for you application here and add all locators
      in robot file.
      e.g. Volanium/mobile/locators/iOS/ModularGateWay/ModularGateWayLocators.robot
 
 -> Information related to Available keywords
    - Go to "help" directory.
      $ cd help
      e.g. Volanium/mobile/help/iOS.html

 -> Add your Application Test Suite and write different test script.
    - Go to "testsuite" directory and make a Test Suite for Application Test
      e.g. Volanium/testsuite/ModularGateWayAppTestSuite
    - Make a Application Test Script in test suite.
      e.g. Volanium/testsuite/ModularGateWayAppTestSuite/ModularGateWayLoginTest.robot
    - To Use Mobile related, iOS related and Clean-Up related Keywords
      in Test Script import Mobile.robot(Volanium/mobile/resource/Mobile.robot),
      import iOS.robot(Volanium/mobile/resource/iOS/iOS.robot) and
      import MobileCleanUp.robot(Volanium/mobile/resource/MobileCleanUp.robot)
      file in your Test Script.


7. HOW TO RUN TEST SUITE USING VOLANIUM TEST FRAMEWORK
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
        It will execute same test suites over all the connected devices regardless of versions
        OS and model of phone.

8. TEST RESULT OF EXECUTED TEST SUITE/SPECIFIC TEST CASE
========================================================

 -> VOLANIUM Test Framework creates test execution result in csv format.
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


9. TEST LOGS OF EXECUTED TEST SUITE/SPECIFIC TEST CASE
====================================================== 

 -> Volanium Test Framework generates test execution resultant logs in html format.
 -> Framework uses log tracking mechanism like - year/month/date/time.
 -> To Show resultant logs, Go to "logs" directory.
    - cd logs
      e.g. Volanium/logs/2018(year)/05(month)/31(date)/log_20180531161428.html


10. BUILT-IN VARIABLES
=====================
-> User can directly use following builtin variables into test script.
   1. ${deviceId}
   2. ${appiumServerPort}
   3. %{UserName}
   4. %{Password}
