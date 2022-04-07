*** Settings ***
Documentation    This resorce file consists of keywords for mobile test clean up.
          ...    - This resource file allows the user execute existing keywords of appium library with an alias: http://serhatbolsu.github.io/robotframework-appiumlibrary/AppiumLibrary.html


Library    ${CURDIR}/../src/lib/MobileCleanUp.py

*** Variables ***
${defaultTempDirectoryPath}    ${CURDIR}/../../temp/
${defualtTempFilePath}    ${CURDIR}/../../temp/

*** Keywords ***
Clean Up Application
    [Documentation]    Reset Application, close Current Application
                ...    and close webdriver session and Uninstall from device
#    Reset Application
    Close Application

Create Temporary Directory
    [Arguments]    ${dirPath}=${EMPTY}
    [Documentation]    Creates New Temporary Directory
    ${returnValue}    Run Keyword If    "${dirPath}" == ""    createTempDir    ${defaultTempDirectoryPath}
    ...    ELSE    Run Keyword    createTempDir    ${dirPath}
    [return]    ${returnValue}

Create Temporary File
    [Arguments]    ${filePath}=${EMPTY}
    [Documentation]    Creates New Temporary File
    ${returnValue}    Run Keyword If    "${filePath}" == ""    createTempFile    ${defaultTempDirectoryPath}
    ...    ELSE    Run Keyword    createTempFile    ${filePath}
    [return]    ${returnValue}

Clean Up Temporary Directory
    [Arguments]    ${dirPath}
    [Documentation]    Deletes Created Temporary Directory
    ${returnValue}    cleanUpTempDir    ${dirPath}
    [return]    ${returnValue}

Clean Up Temporary File
    [Arguments]    ${filePath}
    [Documentation]    Deletes Created Temporary Directory
    ${returnValue}    cleanUpTempFile    ${filePath}
    [return]    ${returnValue}
