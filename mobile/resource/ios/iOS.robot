*** Settings ***
Documentation    This resource file consist keywords for only ios mobile app testing.
                 ...    - This resource file allows to open iOS inbuilt application and Settings Page.
                 ...    - # Note: Argument "bundleId" is mandatory to use "Open iOS Inbuilt Application" ketyword.
                 ...    - # Note: Bundle Id list is available under "Volanium/mobile/src/wrappers/ios".

Resource   ${CURDIR}/../../src/wrappers/ios/InBuiltAppBundleId.robot


*** Keywords ***
Open iOS Setting Page
    [Documentation]    Open iOS setting page
    ${numPort}    Convert To Number	${wdaPort}
    Mobile.Open Application    ${RemoteURL}
        ...     platformName=%{PlatformName}
        ...     deviceName=${deviceId}
        ...     automationName=XCUITest
        ...     udid=${deviceId}
        ...     bundleId=${settingPageBundleId}
        ...     wdaLocalPort=${numPort}
    Sleep    2

Open iOS Inbuilt Application
    [Arguments]    ${bundleId}
    [Documentation]    Open suitable application as per given bundle id
    ${numPort}    Convert To Number    ${wdaPort}
    Mobile.Open Application    ${RemoteURL}
        ...     platformName=%{PlatformName}
        ...     deviceName=${deviceId}
        ...     automationName=XCUITest
        ...     udid=${deviceId}
        ...     bundleId=${bundleId}
        ...     wdaLocalPort=${numPort}
    Sleep    2
