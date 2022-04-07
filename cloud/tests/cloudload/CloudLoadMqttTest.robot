*** Settings ***
Documentation    Example test cases for Locust.robot resource file.
           ...    All tests contain a workflow constructed from keywords in Locust.robot
           ...    To run this file execute command: 'robot LocustTest.robot'

Resource          ../../resource/cloudload/CloudLoad.robot

*** Variables ***
${HOST}           broker.bevywise.com:8443
${TOPIC}            $SYS/#
${NUM_REQUESTS}    1000 
${HATCH_RATE}     50   
${NUM_CLIENTS}    50   
${RESPONSE_PER_SEC}    3
${METHOD}   subscribe

 

*** Test Cases ***
Test1
    Generate Mqtt Locust Request    ${METHOD}    ${HOST}    ${TOPIC}    0    5    15000    name=${TEST NAME} 
    Start Locust Execution    ${NUM_CLIENTS}    ${HATCH_RATE}    ${NUM_REQUESTS}
    Compare Response Per Second    ${RESPONSE_PER_SEC}

