Documentation     This robot file consist of different locators of NSC Entrematic android application.

*** Settings ***
Resource        ../CommonClass.robot

*** Variables ***
${parent}	com.gtoaccess.entrematic:id
${id}		narendrasinh.dodiya@nortekcontrol.com
${code}		test123
${signInX}	539
${signInY}	779


###############Welcome Screen###########
${WelcomeLogo}		${xPathPrefix}${imageViewClass}[@index='0' and @resource-id='${parent}/imageView']
${Welcometext}		${xPathPrefix}${textViewClass}[@index='0'and @resource-id='${parent}/lbl_image']
${welcomeOK}		${xPathPrefix}${buttonClass}[@resource-id='${parent}/notes_ok_button']

###############Login Dashboard###########
${logo}		        ${xPathPrefix}${imageViewClass}[@index='0' and @resource-id='${parent}/iv_logo']
${welcome}		${xPathPrefix}${textViewClass}[@resource-id='${parent}/lbl_title']
${description}		${xPathPrefix}${textViewClass}[@resource-id='${parent}/lbl_description']
${enterEmail}		${xPathPrefix}${editTextClass}[@resource-id='${parent}/txt_email']
${enterPassword}	${xPathPrefix}${editTextClass}[@resource-id='${parent}/txt_password']
${forgotPassword}	${xPathPrefix}${textViewClass}[@resource-id='${parent}/lbl_forgot_password']
${logInToggle}		${xPathPrefix}${switchClass}[@resource-id='${parent}/cb_remember_me']	
${keepMeLogin}		${xPathPrefix}${textViewClass}[@index='1' and @text='Keep me logged in']
${createAccount}	${xPathPrefix}${buttonClass}[@resource-id='${parent}/btn_create_account']	
${logIn}		${xPathPrefix}${buttonClass}[@index='1' and @resource-id='${parent}/btn_login']


###############Home Screen###########
${HomeLogo}		${xPathPrefix}${imageViewClass}[@index='1']
${instructions}		${xPathPrefix}${imageViewClass}[@index='0'and @resource-id='${parent}/lbl_image']
${places}		${xPathPrefix}${textViewClass}[@resource-id='${parent}/my_places_button']
${settingsButton}	${xPathPrefix}${imageViewClass}[@resource-id='${parent}/drawer_button']
${addDevice}		${xPathPrefix}${textViewClass}[@index='0' and @text='Add Device']
${screenLight}		${xPathPrefix}${viewClass}[@index='0'and @resource-id='${parent}/bv_light_device']
${offLineLightText}	${xPathPrefix}${textViewClass}[@index='1' and @text='Offline']
${onlineLightOn}	${xPathPrefix}${viewClass}[@index='0'and @resource-id='${parent}/bv_light_device']
##${onlineLightOff}	${xPathPrefix}${viewClass}[@index='0'and @resource-id='${parent}/bv_light_device']
${dviceInfo}		${xPathPrefix}${textViewClass}[@index='0'and @resource-id='${parent}/txt_device_name_operate']
${devicename}		${xPathPrefix}${linearLayoutClass}[@index='0'and @resource-id='${parent}/layoutSiteName']
${renameDevice}		${xPathPrefix}${textViewClass}[@text='Rename Your Place'and @resource-id='android:id/alertTitle']
${editName}		${xPathPrefix}${editTextClass}[@resource-id='${parent}/txt_site_name']
${okName}		${xPathPrefix}${buttonClass}[@index='1' and @resource-id='android:id/button1']
${deviceDoor}		${xPathPrefix}${viewClass}[@index='0'and @resource-id='${parent}/bv_gdo_device']
${noDeviceConnected}	${xPathPrefix}${imageViewClass}[@index='0']


###########Device Details##############
${deviceDetailsTitle}	${xPathPrefix}${textViewClass}[@index='1'and @resource-id='${parent}/lbl_title']
${OpenDevice}		${xPathPrefix}${textViewClass}[@text='Open'and @resource-id='${parent}/lbl_device_status']
${closeDevice}		${xPathPrefix}${textViewClass}[@text='Closed'and @resource-id='${parent}/lbl_device_status']
${OnLight}		${xPathPrefix}${textViewClass}[@text='On - dimmed to 90%'and @resource-id='${parent}/lbl_connected_device_status']
${OffLight}		${xPathPrefix}${textViewClass}[@text='Off'and @resource-id='${parent}/lbl_connected_device_status']
${clickOffLight}	${xPathPrefix}${viewClass}[@resource-id='${parent}/bv_connected_operable_device']
${activity}		${xPathPrefix}${frameLayoutClass}[@index='1'and @resource-id='${parent}/action_activity']
${removeDevice}		${xPathPrefix}${buttonClass}[@text='Remove Device'and @resource-id='${parent}/btn_remove_device']
${confirmRmDeviceTitle}		${xPathPrefix}${textViewClass}[@text='Remove Device?' and @resource-id='android:id/alertTitle']
${okRemove}		${xPathPrefix}${buttonClass}[@text='REMOVE' and @resource-id='android:id/button1']
${okCancel}		${xPathPrefix}${buttonClass}[@text='CANCEL' and @resource-id='android:id/button2']
${controls}		${xPathPrefix}${frameLayoutClass}[@index='0'and @resource-id='${parent}/action_controls']	



###########Activity Details##############
${recentActivity}	${xPathPrefix}${textViewClass}[@text='RECENT ACTIVITIES'and @index='0']










