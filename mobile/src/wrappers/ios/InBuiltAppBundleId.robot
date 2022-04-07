Documentation     This file consist Bundle Id for iOS inbuilt applications.
           ...    - User can import this file and use any variable to open application using "Open iOS Inbuilt Application" keyword,
           ...      present under "iOS.robot" resource file. For more information go through iOS.html help file.
           ...    - NOTE: User can find bundle id of all application for connected device using command: "ideviceinstaller -l -o list_all"


*** Variables ***

###################    ADB REBOOT COMMANDS    #######################
${settingPageBundleId}            com.apple.Preferences
${appStoreBundleId}               com.apple.AppStore
${calculatorBundleId}             com.apple.calculator
${calendarBundleId}               com.apple.mobilecal
${cameraBundleId}                 com.apple.camera
${clockBundleId}                  com.apple.mobiletimer
${compassBundleId}                com.apple.compass
${contactsBundleId}               com.apple.MobileAddressBook
${faceTimeBundleId}               com.apple.facetime
${healthBundleId}                 com.apple.Health
${iBooksBundleId}                 com.apple.iBooks
${iTunesStoreBundleId}            com.apple.MobileStore
${mapsBundleId}                   com.apple.Maps
${messagesBundleId}               com.apple.MobileSMS
${musicBundleId}                  com.apple.Music
${notesBundleId}                  com.apple.mobilenotes
${phoneBundleId}                  com.apple.mobilephone
${photosBundleId}                 com.apple.mobileslideshow
${remindersBundleId}              com.apple.reminders
${walletBundleId}                 com.apple.Passbook
${watchBundleId}                  com.apple.Bridge
${weatherBundleId}                com.apple.weather
