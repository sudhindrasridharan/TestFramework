*** Settings ***
Documentation    Example test cases for CloudCommon.robot resource file.
           ...    All tests contain a workflow constructed from keywords in CloudCommon.robot
           ...    To run this file execute command: 'robot CommonTest.robot'
Library          RequestsLibrary
Resource    ../../resource/CloudCommon.robot


*** Variables ***
${jsonPath}    dict:args,dict:key
${xmlPath}    dict:GeocodeResponse,dict:result,dict:address_component,list:2,dict:type,list:0


*** Test Cases ***
JSON Response Validation
    Create Session  httpbin     http://httpbin.org
    &{params}=   Create Dictionary   key=value     key2=value
    ${resp}=     Get Request  httpbin  /get    params=${params}
    Should Be Equal As Strings  ${resp.status_code}  200
    ${jsonData}=  To Json  ${resp.content}
    ${response}    Cloud Response Validation    json    ${jsonData}   ${jsonPath}
    Should Be Equal As Strings  ${response}  value

XML Response Validation
    Create Session  httpbin     http://maps.googleapis.com/maps/api/geocode/xml?sensor=true&address=EmpireState Building&
    ${resp}=     Get Request  httpbin  /get
    Should Be Equal As Strings  ${resp.status_code}  200
    ${response}    Cloud Response Validation    xml    ${resp.content}   ${xmlPath}
    Should Be Equal As Strings  ${response}  political
