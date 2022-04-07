*** Settings ***
Documentation    Example test cases for Locust.robot resource file.
           ...    All tests contain a workflow constructed from keywords in Locust.robot
           ...    To run this file execute command: 'robot LocustTest.robot'

Resource          ../../resource/cloudload/CloudLoad.robot

*** Variables ***
${HOST}           http://testphp.vulnweb.com
${URL}            /login.php
${NUM_REQUESTS}    100 
${HATCH_RATE}     5   
${NUM_CLIENTS}    5   
&{DATA}    username=usr    password=passwd
${METHOD}    POST
${RESPONSE_PER_SEC}    3
${RESPONSE_PER_SEC1}    15

*** Test Cases ***
Test1
    [Tags]    Sanity
    Generate Http Locust Request    ${METHOD}    ${HOST}    ${URL}    name=${TEST NAME}    data=${DATA}
    Start Locust Execution    ${NUM_CLIENTS}    ${HATCH_RATE}    ${NUM_REQUESTS}
    Plot Pi Chart    ${TEST NAME}
    Compare Response Per Second    ${RESPONSE_PER_SEC}

Test2
    [Tags]    Sanity
    Generate Http Locust Request    ${METHOD}    ${HOST}    ${URL}    name=${TEST NAME}    data=${DATA}
    Start Locust Execution    ${NUM_CLIENTS}    ${HATCH_RATE}    ${NUM_REQUESTS}
    Plot Pi Chart    ${TEST NAME}
    Compare Response Per Second    ${RESPONSE_PER_SEC1}
