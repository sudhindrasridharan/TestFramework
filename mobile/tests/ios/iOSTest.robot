*** Settings ***
Documentation    Example test cases for ios.robot resource file.
           ...    All tests contain a workflow constructed from keywords in ios.robot
           ...    To run this file execute command: 'robot iosTest.robot'


Resource    ../../resource/ios/iOS.robot
Resource    ../../resource/Common.robot

Suite Setup    Start Appium Server Connection    ${AppiumServerPort}
Suite Teardown    Stop Appium Server Connection    ${AppiumServerPort}


*** Test Cases ***
Open Setting Page test
    Open iOS Setting Page
 
Open Setting Page test multiple time
    :FOR    ${index}    IN RANGE    1    10
    \    Open iOS Setting Page
    \    Sleep    1

Open App Store
    Open iOS Inbuilt Application    ${appStoreBundleId}

Open Calculator App
    Open iOS Inbuilt Application    ${calculatorBundleId}

Open Calender App
    Open iOS Inbuilt Application    ${calendarBundleId}

Open Camera App
    Open iOS Inbuilt Application    ${cameraBundleId}

Open Clock App
    Open iOS Inbuilt Application    ${clockBundleId}

Open Compass App
    Open iOS Inbuilt Application    ${compassBundleId}

Open Contacts App
    Open iOS Inbuilt Application    ${contactsBundleId}

Open Face Time App
    Open iOS Inbuilt Application    ${faceTimeBundleId}

Open Health App
    Open iOS Inbuilt Application    ${healthBundleId}

Open iBook App
    Open iOS Inbuilt Application    ${iBooksBundleId}

Open iTune Store
    Open iOS Inbuilt Application    ${iTunesStoreBundleId}

Open Maps App
    Open iOS Inbuilt Application    ${mapsBundleId}

Open Messages App
    Open iOS Inbuilt Application    ${messagesBundleId}

Open Music App
    Open iOS Inbuilt Application    ${musicBundleId}

Open Notes App
    Open iOS Inbuilt Application    ${notesBundleId}

Open Phone App
    Open iOS Inbuilt Application    ${phoneBundleId}

Open Photos App
    Open iOS Inbuilt Application    ${photosBundleId}

Open Reminders App
    Open iOS Inbuilt Application    ${remindersBundleId}

Open Wallet App
    Open iOS Inbuilt Application    ${walletBundleId}

Open Watch App
    Open iOS Inbuilt Application    ${watchBundleId}

Open Weather App
    Open iOS Inbuilt Application    ${weatherBundleId}
