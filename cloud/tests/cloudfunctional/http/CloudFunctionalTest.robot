*** Settings ***
Documentation    Test file contains all basic cloud method functional tests
Library          Collections
Resource         ../../../resource/cloudfunctional/http/HttpRequestResource.robot


*** Test Cases ***
TC-1:
    [Documentation]    To Create Session
    [Tags]    TCID_1    Sanity
    Create Session    alias=github    url=http://api.github.com     max_retries=5

TC-2:
    [Documentation]    To Delete Session
    [Tags]    TCID_2    Sanity
    Create Session    alias=github    url=http://api.github.com 
    Delete Request    alias=github    uri=http://api.github.com

TC-3:
    [Documentation]    Get Request 
    [Tags]    TCID_3    Sanity
    Create Session    alias=google    url=http://www.google.com    max_retries=5
    ${resp}= 	Get Request 	alias=google    uri=/ 	
    Log To Console    \n\r=>Response Code : ${resp}
    
TC-4:
    [Documentation]    Post Request
    [Tags]    TCID_4    Sanity
    Create Session    alias=httpbin    url=http://httpbin.org
    &{params}=   Create Dictionary   key=value     key2=value2
    ${resp}=    Post Request    alias=httpbin    uri=/post    params=${params}
    Log To Console    \n\r=>Response Code : ${resp}
    
TC-5:
    [Documentation]    Put Request
    [Tags]    TCID_5    Sanity
    Create Session    alias=httpbin    url=http://httpbin.org
    ${resp}=    Put Request    alias=httpbin    uri=/put
    Log To Console    \n\r=>Response Code : ${resp}
    
TC-6:
    [Documentation]     Head Request
    [Tags]    TCID_6    Sanity
    Create Session    alias=httpbin    url=http://httpbin.org
    ${resp}=    Head Request    alias=httpbin    uri=/headers
    Log To Console    \n\r=>Response Code : ${resp}

TC-7:
    [Documentation]    Option Request
    [Tags]    TCID_7    Sanity
    Create Session    alias=httpbin    url=http://httpbin.org
    ${resp}=    Options Request    alias=httpbin    uri=/headers
    Log To Console    \n\r=>Response Code : ${resp}

TC-8:
    [Documentation]    Delete Request
    [Tags]    TCID_8    Sanity
    Create Session    alias=httpbin    url=http://httpbin.org    debug=3
    &{data}=    Create Dictionary    name=bulkan    surname=evcimen
    ${resp}=    Delete Request    alias=httpbin    uri=/delete    data=${data}
    Log To Console    \n\r=>Response Code : ${resp}

TC-9:
    [Documentation]    Patch Request
    [Tags]    TCID_9    Sanity
    Create Session    alias=httpbin    url=http://httpbin.org
    &{data}=    Create Dictionary    latitude=30.496346    longitude=-87.640356
    ${resp}=  Patch Request    alias=httpbin    uri=/patch    data=${data}
    Log To Console    \n\r=>Response Code : ${resp}

TC-10:
     [Documentation]    To Delete all sessions
     [Tags]    TCID_10    Sanity
     Create Session    alias=github    url=http://api.github.com 	
     Create Session    alias=google    url=http://www.google.com
     Delete All Sessions 	
