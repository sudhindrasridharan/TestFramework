----------------------------------------------
Selenium & Appium Library Api Conflicts Issue:
----------------------------------------------

Issue-1: Selenium and Appium library has multiple Common API's like Click Element, Input Text, Capture Page Screen shot, etc. So when both library used in a same test script conflicts will rise in robotframework for Mobile or Web.
Resolution: Framework has  seprate resource file for Appium and Selenium library such that user can use simultaneously without any API's conflicts.

Issue-2: Robot Appium and Selenium library has a some conflicts on capture Page Screen shot when fail. 
Resolution: Framework has a enhanced wrapper files to execute the capture Page Screen shot functionalities of robot Appium and Selenium libraries.


--------
Example:
--------

1. Test suite consist of only mobile device test cases:

	*** Settings ***
	Resource    Mobile.robot

	*** test cases ***
	login test case
		input text    <nameFieldLocator>        user1
		input text    <passwordFieldLocator>    password1
		Click Element    LoginButton
		Page Should Contain     LoginPageTitle


2. Test suite consist of mobile device and web browser test cases
	
	*** Settings ***
	Resource    Mobile.robot
	Resource    Web.robot
		
	*** test cases ***
	Mobile App Login test
		Mobile.input text    <nameFieldLocator>        user1
		Mobile.input text    <passwordFieldLocator>    password1
		Mobile.Click Element    LoginButton
		Mobile.Page Should Contain     LoginPageTitle

	Web App Login test
		Web.input text    <nameFieldLocator>        user1
		Web.input text    <passwordFieldLocator>    password1
		Web.Click Element    LoginButton
		Web.Page Should Contain     LoginPageTitle


#Note: From the above two examples 
#1. When user want to test only Mobile App than use mobile resource directly Example keywords like "Click Element", "Click Button", "Capture Page Screenshot", etc.
#2. When user wants to test Mobile and Web App in the same test script, user must use mobile resource keywords like "Mobile.Click Element", "Mobile.Input text", etc and for web resource keywords like "Web.Click Element", "Web.input text"
