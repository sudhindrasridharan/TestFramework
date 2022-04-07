*** Settings ***
Documentation    This resource file consist keywords for mobile app testing.
           ...    - This resource file allows the user execute existing keywords of appium library with an alias: http://serhatbolsu.github.io/robotframework-appiumlibrary/AppiumLibrary.html
           ...    - Locator are the input argument for all the KEYWORDS in MobileResource.
           ...    - Locator is a string that describes how to locate an element using a syntax specifying different location strategies.
           ...    - MobileResource uses the Appium Library internally to control mobile Application. See http://appium.io more information about Appium in general.
           ... 	  - It is also possible to specify the approach MobileResource should take to find an element by specifying a lookup strategy with a locator prefix.

Library    ${CURDIR}/../src/wrappers/AppiumWrapper.py    WITH NAME    Mobile
Library    ${CURDIR}/../src/lib/ImageProcess.py
Library    ${CURDIR}/../src/lib/MobileConnection.py
Library    OperatingSystem

*** variables ***
${automationName}   XCUITest
${appiumCmdTimeout}    3000
${wdaPort}    8100
${systemPort}    8200

*** Keywords ***
Start Application
    [Arguments]    ${noReset}=False    ${fullReset}=True
    ${numPort}    Convert To Number    ${wdaPort}
    ${sysPort}    Convert To Number    ${systemPort}

    Run Keyword If    "%{PlatformName}" == "Android" and "%{UITestFramework}" == "uiautomator"    Mobile.Open Application    ${RemoteURL}
               ...    platformName=%{PlatformName}
               ...    udid=${deviceId}
               ...    deviceName=${deviceId}
               ...    app=%{ApkPath}
               ...    appActivity=%{AppActivity}
               ...    appPackage=%{AppPackage}
               ...    newCommandTimeout=${appiumCmdTimeout}
#               ...    noReset=${noReset}
#               ...    fullReset=${fullReset}

               ...    ELSE IF    "%{PlatformName}" == "Android" and "%{UITestFramework}" == "uiautomator2"    Mobile.Open Application    ${RemoteURL}
               ...    platformName=%{PlatformName}
               ...    udid=${deviceId}
               ...    deviceName=${deviceId}
               ...    app=%{ApkPath}
               ...    appActivity=%{AppActivity}
               ...    appPackage=%{AppPackage}
#               ...    systemPort=${sysPort}
#               ...    noSign=True
               ...    automationName=%{UITestFramework}

               ...    ELSE    Mobile.Open Application    ${remoteUrl}
               ...    platformName=%{PlatformName}
               ...    deviceName=${deviceId}
               ...    udid=${deviceId}
               ...    automationName=${automationName}
               ...    agentPath=%{AgentPath}
               ...    bootstrapPath=%{BootstrapPath}
               ...    app=%{ipaPath}
               ...    bundleId=%{ipaBundleId}
               ...    wdaLocalPort=${numPort}
               ...    newCommandTimeout=${appiumCmdTimeout}
               ...    noReset=${noReset}
               ...    fullReset=${fullReset}

Convert Image To String
    [Arguments]    ${imgName}
    [Documentation]    Convert given image into raw data
    ${rawImageData}    imageToStringConverter    imgPath=${imgName}
    [Return]    ${rawImageData}

Start Appium Server Connection
    [Arguments]    ${portNum}
    [Documentation]    Start appium server on specific port
    ${returnValue}    startAppiumServer    ${portNum}
    [return]    ${returnValue}

Stop Appium Server Connection
    [Arguments]    ${serverPort}
    [Documentation]    Stop appium server on specific port
    ${returnValue}    stopAppiumServer    ${serverPort}
    [return]    ${returnValue}
