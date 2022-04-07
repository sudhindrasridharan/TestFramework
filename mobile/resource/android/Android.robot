*** Settings ***
Documentation    This resource file consist keywords for only android mobile app testing.
           ...    - This resource file allows to execute ADB commands and Settings Page Actions.
           ...    - # Note: Argument "deviceId" is mandatory to use Android ADB ketywords.
           ...    - Here Driver will be taken care of "deviceId" so user does not need to define it.
           ...    - So user can use Android Keywords like:
           ...                       1. Uninstall Mobile Application    ${deviceId}
           ...                       \n2. Open Status Bar    ${deviceId}


Resource   ${CURDIR}/../../src/wrappers/android/AdbCommands.robot
Resource   ${CURDIR}/../../src/wrappers/android/SettingsAction.robot
Library    ${CURDIR}/../../src/lib/MobileConnection.py
Library    OperatingSystem


*** Keywords ***
Start ADB Server Connection
    [Arguments]    ${serverPort}
    [Documentation]    Start ADB server
    ${returnValue}    adbStartServer    ${serverPort}
    [return]    ${returnValue}

Stop ADB Server Connection
    [Arguments]    ${serverPort}
    [Documentation]    Stop ADB server
    ${returnValue}    adbStopServer    ${serverPort}
    [return]    ${returnValue}

ADB Reboot
    [Arguments]    ${deviceId}
    [Documentation]    Reboot connected device.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbReboot}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Restart ADB In USB Mode
    [Arguments]    ${deviceId}
    [Documentation]    Restart ADB in usb mode.
    ${rc}    Run And Return RC    ${adb} -s ${deviceId} ${adbRestart}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Get Device Android Version
    [Arguments]    ${deviceId}
    [Documentation]    Return device android version.
    ${rc}    ${version}    Run And Return Rc And Output    ${adb} -s ${deviceId} ${getAndroidVersion}
    Should Be Equal    '${rc}'    '0'
    [return]    ${version}

Get Device Serial Number
    [Arguments]    ${deviceId}
    [Documentation]    Return device serial number.
    ${rc}    ${serialNum}    Run And Return Rc And Output    ${adb} -s ${deviceId} ${getAndroidDeviceSerialNum}
    Should Be Equal    '${rc}'    '0'
    [return]    ${serialNum}

Open Status Bar
    [Arguments]    ${deviceId}
    [Documentation]    Open device status bar.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${openStatusBar}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Close Status Bar
    [Arguments]    ${deviceId}
    [Documentation]    Close device status bar.
    ${rc}    Run And Return RC    ${adb} -s ${deviceId} ${closeStatusBar}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Push File To Device
    [Arguments]    ${deviceId}    ${sourcePath}    ${destinationPath}
    [Documentation]    Copy files from your computer to your phone at given path.
    ${rc}    Run And Return Rc    adb -s ${deviceId} push ${sourcePath} ${destinationPath}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Pull File From Device
    [Arguments]    ${deviceId}    ${sourcePath}    ${destinationPath}
    [Documentation]    Copy files from your phone to your computer at given location.
    ${rc}    Run And Return Rc   adb -s ${deviceId} pull ${sourcePath} ${destinationPath}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Install Mobile Application
    [Arguments]    ${deviceId}    ${apkFilePath}
    [Documentation]    Install ".apk" file in Mobile device
    ${rc}    Run And Return Rc   adb -s ${deviceId} install ${apkFilePath}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Uninstall Mobile Application
    [Arguments]    ${deviceId}    ${apkPackageName}
    [Documentation]    Uninstall ".apk" without deleting data.
    ${rc}    ${output}    Run And Return Rc And Output    adb -s ${deviceId} uninstall ${apkPackageName}
    Should Be Equal    '${rc}'    '0'
    [return]    ${output}

Update Mobile Application
    [Arguments]    ${deviceId}    ${apkFilePath}
    [Documentation]    Update Mobile Application.
    ${rc}    Run And Return Rc    adb -s ${deviceId} install -r ${apkFilePath}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Get List Of Connected Android Device
    [Documentation]    Retun list of connected android devices.
    ${deviceList}    checkAndroidDeviceConnection    ${deviceId}
    [return]    ${deviceList}

Go To Home Page
    [Arguments]    ${deviceId}
    [Documentation]    Return to home button.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${homeButton}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Go One Step Back
    [Arguments]    ${deviceId}
    [Documentation]    Go to previous step.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${backButton}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

On Off Device Screen
    [Arguments]    ${deviceId}
    [Documentation]    Turn android device ON and OFF.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${toggleDevice}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Web Browser
    [Arguments]    ${deviceId}
    [Documentation]    Open web browser in device.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${openBrowser}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Press Enter Key
    [Arguments]    ${deviceId}
    [Documentation]    Press enter key in keyboard.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${enterKey}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Press Delete Key
    [Arguments]    ${deviceId}
    [Documentation]    Press delete key in keyboard.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${deleteKey}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Contacts
    [Arguments]    ${deviceId}
    [Documentation]    Open device contacts.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${openContacts}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Brightness Down
    [Arguments]    ${deviceId}
    [Documentation]    Brightness down.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${brightnessDown}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Brightness Up
    [Arguments]    ${deviceId}
    [Documentation]    Brightness up.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${brightnessUp}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Create Backup
    [Arguments]    ${deviceId}
    [Documentation]    Create a full backup of your phone and save to the computer.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${backUp}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Restore Backup
    [Arguments]    ${deviceId}    ${backupFilePath}
    [Documentation]    Restore a backup to your phone.
    ${rc}    Run And Return Rc    adb -s ${deviceId} restore ${backupFilePath}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Settings Accessibility Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings for accessibility modules.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${accessibilitySettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Airplane Mode Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings to allow entering/exiting airplane mode.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${airplaneModeSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Application Development Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings to allow configuration of application development-related settings.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${applicationDevelopmentSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Application Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings to allow configuration of application-related settings.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${applicationSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Battery Saver Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show battery saver settings.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${batterySaverSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Bluetooth Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings to allow configuration of Bluetooth.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${bluetoothSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Data Roaming Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings for selection of 2G/3G etc.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${dataRoamingSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Date And Time Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings to allow configuration of date and time.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${dateSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Device Info Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show general device information settings.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${deviceInfoSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Display Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings to allow configuration of display.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${displaySettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Internal Storage Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings for internal storage.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${internalStorageSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Location Source Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings to allow configuration of current location sources.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${locationSourceSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Manage Default Apps Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show Default apps settings.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${manageDefaultAppsSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Memory Card Storage Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings for memory card storage.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${memoryCardSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open NFC Sharing Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show NFC Sharing settings.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${nfcSharingSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open NFC Payment Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show NFC Tap & Pay settings.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${nfcPaymentSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open NFC Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show NFC settings.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${nfcSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Privacy Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings to allow configuration of privacy options.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${privacySettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Security Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings to allow configuration of security.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${securitySettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show system settings.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${settings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Sound Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings to allow configuration of sound and volume.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${soundSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Sync Settings Page
    [Arguments]    ${deviceId} 
    [Documentation]    Show settings to allow configuration of sync settings.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${syncSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open VPN Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings to allow configuration of VPN.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${vpnSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open WiFi Advanced Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings to allow configuration of Wi-Fi.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${wifiIpSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open WiFi Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings to allow Wi-Fi connection.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${wifiSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}

Open Wireless Settings Page
    [Arguments]    ${deviceId}
    [Documentation]    Show settings to allow configuration of wireless controls.
    ${rc}    Run And Return Rc    ${adb} -s ${deviceId} ${adbCmd}${wirelessSettings}
    Should Be Equal    '${rc}'    '0'
    [return]    ${rc}
