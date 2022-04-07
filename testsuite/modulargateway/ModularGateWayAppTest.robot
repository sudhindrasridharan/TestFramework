*** Settings ***
Documentation    This is the test file for Modular Gateway Application.
Resource         ../../mobile/resource/Common.robot
Resource         ../../mobile/resource/CleanUp.robot
Resource         ../../mobile/locators/ios/modulargateway/ModularGatewayLocators.robot
Resource         ../../mobile/resource/ios/iOS.robot

#Test Setup    Run Keywords    Start Appium Server Connection    ${AppiumServerPort}    AND    Start Application
#Test Teardown    Run Keywords    Clean Up Application    AND    Stop Appium Server Connection    ${AppiumServerPort}

Test Setup    Start Application
Test Teardown    Clean Up Application

*** Test Cases ***
TC-1:
    [Documentation]    Verify the Volansys Image on Modular Gateway Application Home Screen.
    [Tags]    HomePage    SanityTest
    Wait Until Page Contains Element    ${volansysImage}    100s
    Page Should Contain Element    ${volansysImage}

TC-2:
    [Documentation]    Verify the Modular Gateway Image on Modular Gateway Application Home Screen.
    [Tags]    HomePage    SanityTest
    Wait Until Page Contains Element    ${gatewayImage}    100s
    Page Should Contain Element    ${gatewayImage}

TC-3:
    [Documentation]    Verify the NXP Image on Modular Gateway Application Home Screen.
    [Tags]    HomePage    SanityTest
    Wait Until Page Contains Element    ${nxpImage}    100s
    Page Should Contain Element    ${nxpImage}

TC-4:
    [Documentation]    Verify that Authentication page should open on click of Next button.
    [Tags]    LoginPage    SanityTest
    Wait Until Page Contains Element    ${nextButton}    100s
    Click Element    ${nextButton}
    Wait Until Page Contains Element    ${volansysDetailImage}    100s

TC-5:
    [Documentation]    Verify that user is able to click on remember me checkbox.
    [Tags]    LoginPage    SanityTest
    Wait Until Page Contains Element    ${nextButton}    100s
    Click Element    ${nextButton}
    Wait Until Page Contains Element    ${volansysDetailImage}    100s
    Click Element    ${rememberCheckbox}

TC-6:
    [Documentation]    Verify that user is able to enter login with valid authentication Id.
    [Tags]    LoginPage    SanityTest
    Wait Until Page Contains Element    ${nextButton}    100s
    Click Element    ${nextButton}
    Wait Until Page Contains Element    ${volansysDetailImage}    100s
    Click Element    ${authenticationId}
    Input Text    ${authenticationId}    ${authId}
    Click Element    ${submitButton}
    sleep    30s

TC-7:
    [Documentation]    Verify the error message at the time of empty authentication Id.
    [Tags]    LoginPage    SanityTest
    Wait Until Page Contains Element    ${nextButton}    100s
    Click Element    ${nextButton}
    Wait Until Page Contains Element    ${volansysDetailImage}    100s
    Click Element    ${submitButton}
    Wait Until Page Contains Element    ${okButton}    100s
    Page Should Contain Element    ${okButton}

TC-8:
    [Documentation]    Verify that user is able to open calculator-iOS inbuilt Application.
    [Tags]    SettingsPage    UnitTest
    Close Application
    Open iOS Inbuilt Application    ${calculatorBundleId}
    Start Application

TC-9:
    [Documentation]    Verify that user is able to open iOS mobile settings page.
    [Tags]    SettingsPage    UnitTest
    Close Application
    Open iOS Setting Page
    Start Application

TC-10:
    [Documentation]    Verify that user is able to turn off WiFi.
    [Tags]    SettingsPage1    UnitTest
    Close Application
    Open iOS Setting Page
    Wait Until Element Is Visible    ${WiFiPage}    100s
    Click Element    ${WiFiPage}
    Wait Until Element Is Visible    ${WiFiButton}    100s
    Click Element    ${WiFiButton}
    Start Application
