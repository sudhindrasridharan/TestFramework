Documentation     This robot file consist of different locators of Elo android application.

*** Settings ***
Resource        ../CommonClass.robot

*** Variables ***
${parent}	com.elotouch.ic.athens:id


###########Test Mode##########
${testMode}		com.elotouch.ic.athens:id/radio_test
${proceedWithAthens}	com.elotouch.ic.athens:id/radio_normal
${ok}			com.elotouch.ic.athens:id/btn_ok


###########Test Mode##########
${updateApiUrl}		com.elotouch.ic.athens:id/radio_qa
${urlOk}		com.elotouch.ic.athens:id/btn_ok

##########Control Panel#######
${controlPanelTitle}	${xPathPrefix}${linearLayoutClass}[@index='0' and @resource-id='${parent}/linearLayout1']
${passwordTest}		${xPathPrefix}${textViewClass}[@index='2' and @text='Password']
${enterPassword}	${xPathPrefix}${editTextClass}[@index='3' and @resource-id='${parent}/editPass']
${showPassword}		${xPathPrefix}${checkBoxClass}[@index='5' and @text='Show password']
${okControlPanel}	${xPathPrefix}${buttonClass}[@index='1' and @resource-id='${parent}/btn_ok']
${cancelControlPanel}	${xPathPrefix}${buttonClass}[@index='0' and @resource-id='${parent}/btn_cancel']
${homeTitle}		com.elotouch.ic.athens:id/tv_head
${homeIcon}		com.elotouch.ic.athens:id/imageView1
${demoButton}		com.elotouch.ic.athens:id/btn_rundemo
${deviceInfo}		${xPathPrefix}${linearLayoutClass}[@index='1' and @resource-id='${parent}/linearLayout2']
${taskBar}		com.elotouch.ic.athens:id/settingstitle
${brightnessIcon}	com.elotouch.ic.athens:id/brightnessicon
${volumeIcon}		com.elotouch.ic.athens:id/volumeicon
${networkIcon}		${xPathPrefix}${imageViewClass}[@index='0' and @resource-id='${parent}/networkicon']
${appsIcon}		${xPathPrefix}${textViewClass}[@index='1' and @text='Apps']
${regionIcon}		${xPathPrefix}${textViewClass}[@index='1' and @text='Region']
${timerIcon}		${xPathPrefix}${textViewClass}[@index='1' and @text='Timer']
${settingsIcon}		${xPathPrefix}${imageViewClass}[@index='0' and @resource-id='${parent}/settingsicon']
${rebootIcon}		${xPathPrefix}${imageViewClass}[@index='0' and @resource-id='${parent}/rebooticon']


##########Device Brightness##########
${brightnessImage}	com.elotouch.ic.athens:id/title_image
${brightnessTitle}	com.elotouch.ic.athens:id/title_text
${brightnessbar}	${xPathPrefix}${seekbar}[@index='4' and @resource-id='${parent}/slider']	
${low}			com.elotouch.ic.athens:id/txtlow
${high}			com.elotouch.ic.athens:id/txthigh


##########Device Volume##########
${volumeImage}		com.elotouch.ic.athens:id/title_image
${volumeTitle}		com.elotouch.ic.athens:id/title_text
${volumelow}		com.elotouch.ic.athens:id/txtlow
${volumehigh}		com.elotouch.ic.athens:id/txthigh


###########Device WiFi#########
#${networkImage}		${xPathPrefix}${imageViewClass}[@index='0']
#${networkTitle}		${xPathPrefix}${textViewClass}[@index='1' and @text='Network']
#${wifiText}		${xPathPrefix}${textViewClass}[@index='0' and @text='WIFI']
#${lanText}		${xPathPrefix}${textViewClass}[@index='1' and @text='LAN']
#${addNetwork}		${xPathPrefix}${imageButtonClass}[@index='0' and @resource-id='${parent}/img_btn_add_network']
#${refreshNetwork}	${xPathPrefix}${imageButtonClass}[@index='1' and @resource-id='${parent}/img_btn_scan']
#
#
###########Device App##########
#${networkImage}		${xPathPrefix}${imageViewClass}[@index='0' and @resource-id='${parent}/imageView1']
#${networkTitle}		${xPathPrefix}${textViewClass}[@index='1' and @text='Apps']
#
#
###########Device Region##########
#${regionImage}		${xPathPrefix}${imageViewClass}[@index='0' and @resource-id='${parent}/img_region']
#${regionTitle}		${xPathPrefix}${textViewClass}[@index='1' and @text='Region']
#
#
###########Device Timer##########
#${TimerImage}		${xPathPrefix}${imageViewClass}[@index='0' and @resource-id='${parent}/img_region']
#${TimerTitle}		${xPathPrefix}${textViewClass}[@index='1' and @text='Display Timer']
#${displayOnText}	${xPathPrefix}${textViewClass}[@index='0' and @text='Display On']
#${TimeOnText}		${xPathPrefix}${textViewClass}[@index='1' and @resource-id='${parent}/text_display_on']
#${displayOffText}	${xPathPrefix}${textViewClass}[@index='0' and @text='Display Off']
#${TimeOffText}		${xPathPrefix}${textViewClass}[@index='1' and @resource-id='${parent}/text_display_off']
#${saveChangesIcon}	${xPathPrefix}${imageViewClass}[@index='5' and @resource-id='${parent}/imageView_set_time']
#
#
###########Device Settings##########
#${SettingsImage}	${xPathPrefix}${imageViewClass}[@index='0']
#${SettingsTitle}	${xPathPrefix}${textViewClass}[@index='1' and @text='System Update']
#${bspVersion}		${xPathPrefix}${textViewClass}[@index='0' and @text='BSP Version']
#${apkVersion}		${xPathPrefix}${textViewClass}[@index='0' and @text='APK Version']
#${productVersion}	${xPathPrefix}${textViewClass}[@index='0' and @text='Product Version']
#${androidpVersion}	${xPathPrefix}${textViewClass}[@index='0' and @text='Android Version']
#${deviceUpdate}		${xPathPrefix}${buttonClass}[@index='5' and @resource-id='${parent}/check_update']
#${dataReset}		${xPathPrefix}${buttonClass}[@index='6' and @resource-id='${parent}/data_reset']
#
#
###########Data Reset##########
#${dataResetTitle}	${xPathPrefix}${textViewClass}[@index='0' and @text='DATA RESET']
#${confirmationMessage}	${xPathPrefix}${textViewClass}[@resource-id='${parent}/textView2']
#${rebootingMessageTitle}	${xPathPrefix}${textViewClass}[@index='0' and @text='Rebooting Device']
#${rebootingMessage1}	${xPathPrefix}${textViewClass}[@index='0' and @text='Please do not turn off the power.']
#${rebootingMessage2}	${xPathPrefix}${textViewClass}[@index='0' and @text='Device will Reboot in..']
#${rebootingMessage3}	${xPathPrefix}${textViewClass}[@index='1' and @resource-id='${parent}/text_sec']
#
#
#
###########Device Reboot##########
#${rebootImage}		${xPathPrefix}${imageViewClass}[@index='0']
#${rebootTitle}		${xPathPrefix}${textViewClass}[@index='1' and @text='Reboot']
#${lastReboot}		${xPathPrefix}${textViewClass}[@index='0' and @text='Last Reboot']
#${rebootDevicebutton}	${xPathPrefix}${buttonClass}[@index='2' and @resource-id='${parent}/btn_reboot']
#${deviceRebootTitle}	${xPathPrefix}${textViewClass}[@index='0' and @text='Are you sure you want to reboot?']
#${no}			${xPathPrefix}${buttonClass}[@index='0' and @resource-id='${parent}/reboot_btn_no']
#${yes}			${xPathPrefix}${buttonClass}[@index='1' and @resource-id='${parent}/reboot_btn_yes']
#
#
###########Launcher Screen##########
#${screen1}		${xPathPrefix}${textViewClass}[@index='1' and @text='Appium Settings']
#${screen2}		${xPathPrefix}${textViewClass}[@index='1' and @text='Settings']
#${screen3}		${xPathPrefix}${textViewClass}[@index='1' and @text='DCAndroidClient']













