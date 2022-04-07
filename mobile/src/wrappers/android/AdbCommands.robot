Documentation     This file consist variable for ADB commands.
           ...    - User can import this file and execute any ADB commands in the test scripts.


*** Variables ***

###################    ADB REBOOT COMMANDS    #######################
${adb}                            adb
${adbReboot}                      reboot

###################    ADB DEVICES COMMANDS    #######################
${adbRestart}                     usb    # Restarting ADB in USB mode
${getAndroidVersion}              shell getprop ro.build.version.release    # Get device android version
${getAndroidDeviceSerialNum}      get-serialno    # Get device serial number

###################    STATUSBAR ADB COMMANDS    #######################
${openStatusBar}                  shell service call statusbar 1
${closeStatusBar}                 shell service call statusbar 2

###################    ADB KEY EVENT COMMANDS    #######################
${homeButton}                     shell input keyevent 3      # Home button
${backButton}                     shell input keyevent 4      # Back button
${toggleDevice}                   shell input keyevent 26     # Turn Android device ON and OFF. It will toggle device to on/off status.
${openBrowser}                    shell input keyevent 64     # Open Browser
${enterKey}                       shell input keyevent 66     # Enter key
${deleteKey}                      shell input keyevent 67     # Delete (backspace) key
${openContacts}                   shell input keyevent 207    # Open Contacts
${brightnessDown}                 shell input keyevent 220    # Brightness down
${brightnessUp}                   shell input keyevent 221    # Brightness up

###################    OTHER ADB COMMANDS    #######################
${backUp}                         backup -all    # Create a full backup of your phone and save to the computer
