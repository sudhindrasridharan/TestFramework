*** Settings ***
Documentation     This robot file consist of a common class variable for ios device App testing.
           ...    - User can use that variable to create locator.
           ...    - Example:
           ...            ${xPathPrefix}${typeStaticTextClass}[@label="Label to be verified"]

*** Variable ***
###################    COMMON VARIABLE    ############################
${xPathPrefix}                          //

###################    COMMON XCUIELEMENT CLASS    ###################
${typeButtonClass}                      XCUIElementTypeButton
${typeStaticTextClass}                  XCUIElementTypeStaticText
${typeApplicationClass}                 XCUIElementTypeApplication
${typeOtherClass}                       XCUIElementTypeOther
${typeNavigationBarClass}               XCUIElementTypeNavigationBar
${typeSwitchClass}			            XCUIElementTypeSwitch
${typeTextFieldClass}                   XCUIElementTypeTextField
${typeSecureTextFieldClass}      	    XCUIElementTypeSecureTextField
${typeTableClass}                       XCUIElementTypeTable
${typeCellClass}                        XCUIElementTypeCell
${typeImageClass}                       XCUIElementTypeImage
