*** Settings ***
Documentation     This robot file consist of different locators of Modular Gateway iOS Application.
Resource    ../CommonClass.robot

*** Variables ***
###################    HOME PAGE    ####################
${modularText}		${xPathPrefix}${typeStaticTextClass}[@name="Volansys Modular Gateway"]
${connectivityText}     ${xPathPrefix}${typeStaticTextClass}[@name="Supporting Thread & ZigBee Connectivity"]
${gatewayImage}         ${xPathPrefix}${typeImageClass}[@name="img_gateway"]
${volansysImage}        ${xPathPrefix}${typeImageClass}[@name="ic_volansys"]
${nxpImage}             ${xPathPrefix}${typeImageClass}[@name="ic_nxp"]
${nextButton}           ${xPathPrefix}${typeButtonClass}[@name="Next"]


###################    LOGIN PAGE    ###################
${gatewayMgrText}       ${xPathPrefix}${typeStaticTextClass}[@name="Modular Gateway Mgr"]
${authenticationText}   ${xPathPrefix}${typeStaticTextClass}[@name="User Authentication"]
${authenticationId}     ${xPathPrefix}${typeApplicationClass}[@name="Modular Gateway Mgr"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeTextField
${rememberCheckbox}     ${xPathPrefix}${typeButtonClass}[@name="ic check box outline blank whi"]
${submitButton}         ${xPathPrefix}${typeButtonClass}[@name="Submit"]
${noteText}             ${xPathPrefix}${typeStaticTextClass}[@name="Note: Serial Number(SN) is the Authentication id of the gateway. Please follow the label on the back side of your gateway for the Serial Number(SN) as shown in below image."]
${volansysDetailImage}  ${xPathPrefix}${typeImageClass}[@name="sn_detail"]
${authId}               1705000724539
${okButton}             ${xPathPrefix}${typeButtonClass}[@name="Ok"]

###################    SETTINGS PAGE    ###################
${WiFiPage}             ${xPathPrefix}${typeCellClass}[@name="Wi-Fi"]
${WiFiButton}           ${xPathPrefix}${typeSwitchClass}[@name="Wi-Fi"]
