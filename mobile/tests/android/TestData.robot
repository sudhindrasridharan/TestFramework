Documentation     This file consist Test Data for AndroidTest.robot test case file.
           ...    With Below Android device and version combination we have tested AndroidTest.robot file.
           ...    Uncomment suiteble test data or user can create same for different device and version combination.


*** Variables ***

######### Common #########
${remoteUrl}    http://localhost:4723/wd/hub
${app}    ${CURDIR}/EriBank.apk
${apkPath}    ${CURDIR}/EriBank.apk
${apkPackageName}    com.experitest.ExperiBank
${apkActivity}    .LoginActivity
${backupFilePath}    ${CURDIR}/backupfile.ab
${pullFilePath}    EriBank.apk

######### LG Q6+ with 7.1.1 Android Version #########
${versionExData}    7.0
${serialNumExData}    LGM400RWKJDYVOSWBY
${storagePath}    /sdcard
${deviceId}    LGM700ac82c6e7
${accessibilityText}    Accessibility
${airplaneText}    Airplane
${developerText}    Developer
${applicationText}    Apps
${settingsText}    Settings
${batteryText}    Battery
${bluetoothText}    Bluetooth
${dataRomingText}    Mobile networks
${dateText}    Date
${aboutText}    About
${displayText}    Display
${storageText}    storage
${locationText}    Location
${defaultText}    Configure
${nfcText}    NFC    # Not Supported
${privacyText}    Backup
${securityText}    Security
${soundText}    Sound
${syncText}    sync
${vpnText}    VPN
${wifiText}    Wi-Fi
${wirelessText}    Tethering

######### ASUS_X008DA Model with 7.0 Android Version #########
#${versionExData}    7.0
#${serialNumExData}    GAAXGY14C010N2J
#${storagePath}    /sdcard
#${deviceId}    GAAXGY14C010N2J
#${accessibilityText}    Accessibility
#${airplaneText}    Airplane
#${developerText}    Developer
#${applicationText}    Apps
#${settingsText}    Settings
#${batteryText}    Battery
#${bluetoothText}    Bluetooth
#${dataRomingText}    Cellular network settings
#${dateText}    Date
#${aboutText}    Device status
#${displayText}    Display
#${storageText}    storage
#${locationText}    Location
#${defaultText}    Default
#${nfcText}    NFC    # Not Supported
#${privacyText}    Backup
#${securityText}    Security
#${soundText}    Sound
#${syncText}    Accounts
#${vpnText}    VPN
#${wifiText}    Wi‑Fi
#${wirelessText}    Tethering

######### Mi A1 Model with 8.0.0 Android Version #########
#${versionExData}    8.0.0
#${serialNumExData}    0c77d3010504
#${storagePath}    /sdcard
#${deviceId}    0c77d3010504
#${accessibilityText}    Accessibility
#${airplaneText}    Airplane
#${developerText}    Developer
#${applicationText}    App info
#${settingsText}    Settings
#${batteryText}    Battery
#${bluetoothText}    Bluetooth
#${dataRomingText}    Mobile network
#${dateText}    Date
#${aboutText}    Phone status
#${displayText}    Display
#${storageText}    Storage
#${locationText}    Location
#${defaultText}    Default
#${nfcText}    NFC    # Not Supported
#${privacyText}    Backup
#${securityText}    Security
#${soundText}    Sound
#${syncText}    accounts
#${vpnText}    VPN
#${wifiText}    Wi‑Fi
#${wirelessText}    Network

######### GiONEE M5_lite Model with 5.1 Android Version #########
#${versionExData}    5.1
#${serialNumExData}    79T4SW7T99999999
#${storagePath}    /sdcard
#${deviceId}    79T4SW7T99999999
#${accessibilityText}    Accessibility
#${airplaneText}    Airplane
#${developerText}    Developer
#${applicationText}    Apps
#${settingsText}    Settings
#${batteryText}    Battery
#${bluetoothText}    Bluetooth
#${dataRomingText}    Cellular network settings
#${dateText}    Date
#${aboutText}    Phone status
#${displayText}    Display
#${storageText}    Storage
#${locationText}    Location
#${defaultText}    Default    # Not Supported
#${nfcText}    NFC    # Not Supported
#${privacyText}    Backup
#${securityText}    Security
#${soundText}    Sound
#${syncText}    Accounts
#${vpnText}    VPN    # Not Supported
#${wifiText}    WLAN
#${wirelessText}    networks
