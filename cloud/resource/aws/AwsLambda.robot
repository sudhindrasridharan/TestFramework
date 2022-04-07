*** Settings ***
Library    ../../src/wrappers/aws/LambdaWrapper.py

*** keywords ***
Start AWS Lambda Session
    [Arguments]    ${awsAccessKey}    ${awsSecretKey}    ${awsRegionName}
    [Documentation]    Start AWS Lambda Session in order to invoke Lambda Function
    ${sessionResp}    createAwsLambdaSession    ${awsAccessKey}    ${awsSecretKey}    ${awsRegionName}
    Should Be Equal    '${sessionResp}'    'True'

Invoke AWS Lambda Function
    [Arguments]    ${funcName}    ${Payload}    ${invocType}=Event    ${LogType}=Tail
    [Documentation]    Invoke AWS Lambda Function
    ${response}    invokeAwsLambda    funcName=${funcName}    Payload=${Payload}    invocType=${invocType}    LogType=${LogType}
    [Return]    ${response}

Start Node Server
    [Documentation]    Start Node server
    Start Node JS Server

Stop Node Server
    [Arguments]    ${serverPort}=3000
    [Documentation]    Stop Node server
    Stop Node JS Server    ${serverPort}
