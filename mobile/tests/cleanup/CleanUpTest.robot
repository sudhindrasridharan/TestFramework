*** Settings ***
Documentation    Example test cases for MobileCleanUp.robot resource file.
           ...    All tests contain a workflow constructed from keywords in MobileCleanUp.robot
           ...    To run this file execute command: 'robot CleanUpTest.robot'


Resource    ../../resource/CleanUp.robot

*** Variables ***
${tempCreateDirPath}    ${CURDIR}/../../../../ 
${tempCreateFilePath}    ${CURDIR}/../../../../
${tempDeleteDirPath}    ${CURDIR}/../../../../../../deletetest/temp/1/2/3/
${tempDeleteFilePath}    ${CURDIR}/../../../../../../deletetest/temp/1/2/file.txt

*** Test Cases ***
Create Temporary Directory at user specific location
    ${returnValue}    Create Temporary Directory    ${tempCreateDirPath}
    Log to console    ${returnValue}

Create Temporary Directory at default location
    ${returnValue}    Create Temporary Directory
    Log to console    ${returnValue}

Create Temporary File at user specific location
    ${returnValue}    Create Temporary File    ${tempCreateFilePath}
    Log to console    ${returnValue}

Create Temporary File at default location
    [Tags]            default
    ${returnValue}    Create Temporary File
    Log to console    ${returnValue}

Clean Up Temporary Directory at perticular location
    ${returnValue}    Clean Up Temporary Directory    ${tempDeleteDirPath}
    Log to console    ${returnValue}

Clean Up Temporary File at perticular location
    [Tags]            temp
    ${returnValue}    Clean Up Temporary File    ${tempDeleteFilePath}
    Log to console    ${returnValue}
    
