*** Settings ***
Documentation    Example test cases for Mobile.robot resource file.
           ...    All tests contain a workflow constructed from keywords in Mobile.robot
           ...    To run this file execute command: 'robot MobileTest.robot'


Resource    ../../resource/Common.robot


*** Variables ***
${imagePath}    ${CURDIR}/../testimage.jpg
${wrongImagePath}    testimage.jpg


*** Test Cases ***
Convert Image To String When Image Is Present
    ${stringData}    Convert Image To String    ${imagePath}
    Should Contain    ${stringData}    basic test example

Convert Image To String When Image Is Not Present
    ${stringData}    Convert Image To String    ${wrongImagePath}
    Should Be Equal    '${stringData}'    'False'

Appium Server Connection
    ${startServer}    Start Appium Server Connection    ${AppiumServerPort}
    Should Be Equal    '${startServer}'    'True'
    ${stopServer}    Stop Appium Server Connection    ${AppiumServerPort}
    Should Be Equal    '${stopServer}'    'True'
