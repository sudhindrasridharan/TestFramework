*** Settings ***
Documentation    This Test file tests the basic functionality of Mobile Application of MakeMyTrip.
Resource    ../../mobile/resource/Common.robot
Resource    ../../mobile/resource/android/Android.robot
Resource    ../../mobile/resource/CleanUp.robot
Resource    ../../mobile/locators/android/makemytrip/MakeMyTripLocators.robot
Resource    ../../mobile/locators/android/makemytrip/MakeMyTripLabels.robot

Test Setup    Run Keywords    Start ADB Server Connection    ${AdbServerPort}    AND    Start Appium Server Connection    ${AppiumServerPort}    AND    Start Application    AND    Prerequisite
Test Teardown    Run Keywords    Clean Up Application    AND    Stop Appium Server Connection    ${AppiumServerPort}    AND    Stop ADB Server Connection    ${AdbServerPort}


*** Test Cases ***
TC-1:
    [Documentation]    Verify Home Screen Items
    [Tags]    HomeScreenTC_ID_1    UnitTest
    Page Should Contain Element    ${loginPage}
    Click Element    ${skipButton}
    Page Should Contain Text    ${flight}
    Page Should Contain Text    ${hotels}
    Page Should Contain Text    ${bus}
    Page Should Contain Text    ${holidays}
    Page Should Contain Element    ${runTimeAdd}

TC-2:
    [Documentation]    Open Trips Page When No Internet Connectivity
    [Tags]    NetworkTC_ID_1    UnitTest
    Page Should Contain Element    ${loginPage}
    Click Element    ${skipButton}
    Open WiFi Settings Page    ${deviceId}
    Click Element    ${wifiButton}
    Go One Step Back    ${deviceId}
    Wait Until Element Is Visible    ${tripsButton}    60
    Click Element    ${tripsButton}
    Wait Until Element Is Visible    ${networkError}    60
    Click Element    ${tryAgainButton}
    Go One Step Back    ${deviceId}
    Open WiFi Settings Page    ${deviceId}
    Click Element    ${wifiButton}

TC-3:
    [Documentation]    Verify App Should Stay On Trips Page When Enter Wrong Credential
    [Tags]    TripsPageTC_ID_1    UnitTest
    Page Should Contain Element    ${loginPage}
    Click Element    ${skipButton}
    Wait Until Element Is Visible    ${tripsButton}    60
    Click Element    ${tripsButton}
    Input Text    ${emailEditText}    %{UserName}
    Input Text    ${passwordEditText}    %{Password}
    Sleep    5
    Click Element    ${loginButton}
    Wait Until Element Is Visible    ${tripPage}    60

TC-4:
    [Documentation]    Verify Help Page Functionality
    [Tags]    HelpPageTC_ID_1    UnitTest
    Page Should Contain Element    ${loginPage}
    Click Element    ${skipButton}
    Wait Until Element Is Visible    ${helpButton}    60
    Click Element    ${helpButton}
    Wait Until Element Is Visible    ${helpHeader}    60
    Page Should Contain Element    ${helpHeader}
    Input Text    ${searchEditText}    Offers
    Press Enter Key    ${deviceId}
    Wait Until Element Is Visible    ${searchQueryText}    60
    Click Element    ${searchQueryText}
    Page Should Contain Element    ${searchQueryAns}

TC-5:
    [Documentation]    Verify My Icon Items And Go To My Shortlists
    [Tags]    MyViewPageTC_ID_1    UnitTest
    Page Should Contain Element    ${loginPage}
    Click Element    ${skipButton}
    Wait Until Element Is Visible    ${myButton}    60
    Click Element    ${myButton}
    Wait Until Page Contains    ${loginNow}
    Page Should Contain Text    ${createAccount}
    Page Should Contain Element    ${shortList}
    Page Should Contain Element    ${notification}
    Page Should Contain Element    ${profile}
    Page Should Contain Element    ${contacts}
    Page Should Contain Element    ${coupon}
    Click Text    ${myShortList}
    Wait Until Element Is Visible    ${shortListScreen}    60
    Wait Until Element Is Visible    ${noShortListText}    20

TC-6:
    [Documentation]    Search Indigo Flight From Ahmedabad To Mumbai For 2 Travellers
    [Tags]    FlightPageTC_ID_1    UnitTest
    Page Should Contain Element    ${loginPage}
    Click Element    ${skipButton}
    Wait Until Element Is Visible    ${flightButton}    60
    Click Element    ${flightButton}
    Wait Until Element Is Visible    ${flightPage}    60
    Click Text    ${from}
    Input Text    ${enterCityName}    ${ahmedabadText}
    Press Enter Key    ${deviceId}
    Wait Until Element Is Visible    ${selectAmd}    60
    Click Element    ${selectAmd}
    Wait Until Element Is Visible    ${flightPage}    60
    Click Text    ${travellers}
    Wait Until Element Is Visible    ${travellersPage}    60
    Click Element    ${adults}
    Element Should Contain Text    ${verifyAdultsNum}    ${two}
    Click Text    ${done}
    Wait Until Element Is Visible    ${flightPage}    60
    Click Text    ${search}
    Wait Until Element Is Visible    ${filterButton}    60
    Click Element    ${filterButton}
    Click Text    ${filters}
    Sleep    3
    Swipe    474    1478    495    790
    Click Element    ${filterPath}
    Click Element    ${applyButton}
    Page Should Contain Element    ${indigoFilter}
    Go One Step Back    ${deviceId}
    Go One Step Back    ${deviceId}

TC-7:
    [Documentation]    Verify Holiday Page Image Text
    [Tags]    HolidayPageTC_ID_1    UnitTest
    Page Should Contain Element    ${loginPage}
    Click Element    ${skipButton}
    Wait Until Element Is Visible    ${holidayButton}    60
    Click Element    ${holidayButton}
    Wait Until Element Is Visible    ${holidayPage}    60
    Wait Until Element Is Visible    ${holidayImg}     60
    Sleep    10
    Capture Page ScreenShot    HolidayPage.png
    ${holidayPageStr}    Convert Image To String    %{logDir}/HolidayPage.png
    Should Contain    ${holidayPageStr}    BALI
    Go One Step Back    ${deviceId}

TC-8:
    [Documentation]    Enter Invalid Referral Code And Verify Error Msg
    [Tags]    ReferralCodePageTC_ID_1    UnitTest
    Page Should Contain Element    ${loginPage}
    Click Element    ${skipButton}
    Wait Until Element Is Visible    ${tripsButton}    60
    Click Element    ${tripsButton}
    Wait Until Element Is Visible    ${referralCode}    60
    Click Element    ${referralCode}
    Wait Until Element Is Visible    ${referralCodePage}    60
    Input Text    ${referralEdit}    ABC001
    Click Element    ${referralApply}
    Wait Until Element Is Visible    ${referralCodeError}    60
    Element Should Contain Text    ${referralCodeError}    ${invalidCode}

TC-9:
    [Documentation]    Book a Cab from current location
    [Tags]    CabPageTC_ID_1    UnitTest
    Page Should Contain Element    ${loginPage}
    Click Element    ${skipButton}
    Wait Until Element Is Visible    ${flightButton}    60
    Click Element    ${cabPage}
    Wait Until Element Is Visible    ${currentLocationText}    60
    Click Element    ${currentLocationText}
    Wait Until Element Is Visible    ${goAheadText}    60
    Click Element    ${goAheadText}
    Wait Until Element Is Visible    ${allowButton}    60
    Click Element    ${allowButton}
    Wait Until Element Is Visible    ${dropAdress}    60
    Click Element    ${dropAdress}
    Input Text    ${dropAdress}    ${bopalArea}
    Wait Until Element Is Visible    ${destLocation}    60
    Click Element    ${destLocation}
    Wait Until Element Is Visible    ${searchButton}    60
    Click Element    ${searchButton}
    Wait Until Element Is Visible    ${gotTtButton}    60
    Click Element    ${gotTtButton}  
    Wait Until Element Is Visible    ${pickUpDate}    60
    Wait Until Element Is Visible    ${pickUpTime}    60

Tc-10:
    [Documentation]    Uninstall MakeMyTrip Application
    [Tags]    UninstallAppTC_ID_1    UnitTest
    [Teardown]    Run Keywords    Stop ADB Server Connection    ${AdbServerPort}    AND    Stop Appium Server Connection    ${AppiumServerPort}
    Uninstall Mobile Application    ${DeviceId}    %{AppPackage}

*** Keywords ***
Prerequisite
    Open WiFi Settings Page    ${deviceId}
    ${value}=    Get Element Attribute    ${wifiButton}    checked
    Run Keyword If    '${value}'=='false'    Click Element    ${wifiButton}
    Open Location Source Settings Page    ${deviceId}
    ${value}=    Get Element Attribute    ${locationButton}    checked
    Run Keyword If    '${value}'=='false'    Click Element    ${locationButton}
    Go Back
    Go Back
