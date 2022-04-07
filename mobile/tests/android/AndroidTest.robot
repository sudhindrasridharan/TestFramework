*** Settings ***
Documentation    Example test cases for Android.robot resource file.
           ...    All tests contain a workflow constructed from keywords in Android.robot
           ...    To run this file execute command: 'robot AndroidTest.robot'


Resource    ../../resource/android/Android.robot
Resource    ../../resource/Common.robot
Resource    TestData.robot
Library    Collections
Library    AppiumLibrary


Suite Setup    Start Appium Server Connection    ${AppiumServerPort}
Suite Teardown    Stop Appium Server Connection    ${AppiumServerPort}


*** Test Cases ***
Start ADB Server
    ${startServer}    Start ADB Server Connection    ${AdbServerPort}
    Should Be Equal    '${startServer}'    'True'

Stop ADB Server When It's Running
    ${stopServer}    Stop ADB Server Connection    ${AdbServerPort}
    Should Be Equal    '${stopServer}'    'True'

Stop ADB Server When It's Not Running
    ${stopServer}    Stop ADB Server Connection    ${AdbServerPort}
    Should Be Equal    '${stopServer}'    'False'

Reboot Device
    ${return}    ADB Reboot    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    180

Restart Device In USB Mode
    ${return}    Restart ADB In USB Mode    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    30

Get Android Version
    ${version}    Get Device Android Version    ${deviceId}
    Should Be Equal    ${version}    ${versionExData}

Get Device Serial Number
    ${serialNum}    Get Device Serial Number    ${deviceId}
    Should Be Equal    ${serialNum}    ${serialNumExData}

Open Status Bar
    ${return}    Open Status Bar    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    5

Open Status Bar When It's Open
    ${return}    Open Status Bar    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    5

Close Status Bar
    ${return}    Close Status Bar    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    5

Close Status Bar When It's Not Open
    ${return}    Close Status Bar    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    5

Push File To Device
   ${return}    Push File To Device    ${deviceId}    ${apkPath}    ${storagePath}
   Should Be Equal    '${return}'    '0'

Pull File From Device
    ${return}    Pull File From Device    ${deviceId}    ${storagePath}/${pullFilePath}    .
    Should Be Equal    '${return}'    '0'

Install Application
    ${return}    Install Mobile Application    ${deviceId}    ${apkPath}
    Should Be Equal    '${return}'    '0'
    Sleep    5

Update Application
    ${return}    Update Mobile Application    ${deviceId}    ${apkPath}
    Should Be Equal    '${return}'    '0'

List Of Connected Device
    ${returnList}    Get List Of Connected Android Device
    Log To Console    ${returnList}

On Off Device Screen
    ${return}    On Off Device Screen    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    5
    ${return}    On Off Device Screen    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    5

Open Web Browser
    ${return}    Open Web Browser    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    20

Go To Home Page
    ${return}    Go To Home Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    5

Open Contacts
    ${return}    Open Contacts    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    10

Go One Step Back
    ${return}    Go One Step Back    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    5

Press Enter Key
    ${return}    Press Enter Key    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    5

Press Delete Key
    ${return}    Press Delete Key    ${deviceId}
    Should Be Equal    '${return}'    '0'

Brightness Down
    ${return}    Brightness Down    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    5

Brightness Up
    ${return}    Brightness Up    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    5

Create Backup
    ${return}    Create Backup    ${deviceId}
    Should Be Equal    '${return}'    '0'

Restore Backup
    ${return}    Restore Backup    ${deviceId}    ${backupFilePath}
    Should Be Equal    '${return}'    '0'

Open Date And Time Settings Page
    Open Test Application
    ${return}    Open Date And Time Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${dateText}

Open Data Roaming Settings Page
    Open Test Application
    Sleep    3
    ${return}    Open Data Roaming Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${dataRomingText}

Open Settings Accessibility Page
    Open Test Application
    ${return}    Open Settings Accessibility Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${accessibilityText}

Open Airplane Mode Settings Page
    Open Test Application
    ${return}    Open Airplane Mode Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${airplaneText}

Open Application Development Settings Page
    Open Test Application
    ${return}    Open Application Development Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${developerText}

Open Application Settings Page
    Open Test Application
    ${return}    Open Application Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${applicationText}

Open Battery Saver Settings Page
    Open Test Application
    ${return}    Open Battery Saver Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${batteryText}

Open Bluetooth Settings Page
    Open Test Application
    ${return}    Open Bluetooth Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${bluetoothText}

Open Device Info Settings Page
    Open Test Application
    ${return}    Open Device Info Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${aboutText}

Open Display Settings Page
    Open Test Application
    ${return}    Open Display Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${displayText}

Open Internal Storage Settings Page
    Open Test Application
    ${return}    Open Internal Storage Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${storageText}

Open Location Source Settings Page
    Open Test Application
    ${return}    Open Location Source Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${locationText}

Open Manage Default Apps Settings Page
    Open Test Application
    ${return}    Open Manage Default Apps Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${defaultText}

Open Memory Card Storage Settings Page
    Open Test Application
    ${return}    Open Memory Card Storage Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${storageText}

Open NFC Sharing Settings Page
    Open Test Application
    ${return}    Open NFC Sharing Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${nfcText}

Open NFC Payment Settings Page
    Open Test Application
    ${return}    Open NFC Payment Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${nfcText}

Open NFC Settings Page
    Open Test Application
    ${return}    Open NFC Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${nfcText}

Open Privacy Settings Page
    Open Test Application
    ${return}    Open Privacy Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${privacyText}

Open Security Settings Page
    Open Test Application
    ${return}    Open Security Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${securityText}

Open Settings Page
    Open Test Application
    ${return}    Open Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${settingsText}

Open Sound Settings Page
    Open Test Application
    ${return}    Open Sound Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${soundText}

Open Sync Settings Page
    Open Test Application
    ${return}    Open Sync Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${syncText}

Open VPN Settings Page
    Open Test Application
    ${return}    Open VPN Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${vpnText}

Open WiFi Advanced Settings Page
    Open Test Application
    ${return}    Open WiFi Advanced Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${wifiText}

Open WiFi Settings Page
    Open Test Application
    ${return}    Open WiFi Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${wifiText}

Open Wireless Settings Page
    Open Test Application
    ${return}    Open Wireless Settings Page    ${deviceId}
    Should Be Equal    '${return}'    '0'
    Sleep    3
    Mobile.Page Should Contain Text    ${wirelessText}

Uninstall Application
    ${return}    Uninstall Mobile Application    ${deviceId}    ${apkPackageName}
    Should Be Equal    '${return}'    'Success'
    Sleep    5


*** Keywords ***
Open Test Application
    Start Application
