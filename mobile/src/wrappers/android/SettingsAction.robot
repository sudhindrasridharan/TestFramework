Documentation     This file consist variable for Settings Action.
           ...    - User can import this file and use Settings Action to launch activity.
           ...    - Reference: "https://developer.android.com/reference/android/provider/Settings"


*** Variables ***
${adbCmd}                                 shell am start -a android.settings.

###################    SETTINGS ACTION    #######################
${accessibilitySettings}                  ACCESSIBILITY_SETTINGS    # Show settings for accessibility modules
${airplaneModeSettings}                   AIRPLANE_MODE_SETTINGS    # Show settings to allow entering/exiting airplane mode
${applicationDevelopmentSettings}         APPLICATION_DEVELOPMENT_SETTINGS    # Show settings to allow configuration of application development-related settings
${applicationSettings}                    APPLICATION_SETTINGS    # Show settings to allow configuration of application-related settings
${batterySaverSettings}                   BATTERY_SAVER_SETTINGS  # Show battery saver settings
${bluetoothSettings}                      BLUETOOTH_SETTINGS    # Show settings to allow configuration of Bluetooth
${dataRoamingSettings}                    DATA_ROAMING_SETTINGS    # Show settings for selection of 2G/3G etc
${dateSettings}                           DATE_SETTINGS    # Show settings to allow configuration of date and time
${deviceInfoSettings}                     DEVICE_INFO_SETTINGS    # Show general device information settings
${displaySettings}                        DISPLAY_SETTINGS    # Show settings to allow configuration of display
${internalStorageSettings}                INTERNAL_STORAGE_SETTINGS    # Show settings for internal storage
${locationSourceSettings}                 LOCATION_SOURCE_SETTINGS    # Show settings to allow configuration of current location sources
${manageDefaultAppsSettings}              MANAGE_DEFAULT_APPS_SETTINGS    # Show Default apps settings
${memoryCardSettings}                     MEMORY_CARD_SETTINGS    # Show settings for memory card storage
${nfcSharingSettings}                     NFCSHARING_SETTINGS    # Show NFC Sharing settings
${nfcPaymentSettings}                     NFC_PAYMENT_SETTINGS    # Show NFC Tap & Pay settings
${nfcSettings}                            NFC_SETTINGS    # Show NFC settings
${privacySettings}                        PRIVACY_SETTINGS    # Show settings to allow configuration of privacy options
${securitySettings}                       SECURITY_SETTINGS    # Show settings to allow configuration of security
${settings}                               SETTINGS    # Show system settings
${soundSettings}                          SOUND_SETTINGS    # Show settings to allow configuration of sound and volume
${syncSettings}                           SYNC_SETTINGS    # Show settings to allow configuration of sync settings
${vpnSettings}                            VPN_SETTINGS    # Show settings to allow configuration of VPN
${wifiIpSettings}                         WIFI_IP_SETTINGS    # Show settings to allow configuration of a static IP address for Wi-Fi
${wifiSettings}                           WIFI_SETTINGS    # Show settings to allow configuration of Wi-Fi
${wirelessSettings}                       WIRELESS_SETTINGS    # Show settings to allow configuration of wireless controls
