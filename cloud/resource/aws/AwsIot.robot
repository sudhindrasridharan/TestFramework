*** Settings ***
Documentation    This resource file consist keywords for AWS IOT Library Testing.
Library    ../../src/wrappers/aws/IotWrapper.py

*** Keywords ***
Start Aws Iot Session
    [Arguments]    ${awsAcessKey}    ${awsSecretKey}    ${awsRegionName}
    [Documentation]    Start AWS IoT session to Perform Thing Operations
    ${sessionResp}    createAwsIotSession    ${awsAcessKey}    ${awsSecretKey}    ${awsRegionName}
    Should Be Equal    '${sessionResp}'    'True'

Update The Thing Shadow
    [Arguments]    ${thingName}    ${payload}
    [Documentation]    Updates the thing shadow for the specified thing.
    ${updateResp}    updateThingShadow    ${thingName}    ${payload}
    [Return]    ${updateResp}

Get The Thing Shadow
    [Arguments]    ${thingName}
    [Documentation]    Gets the thing shadow for the specified thing.
    ${getResp}    getThingShadow    ${thingName}
    [Return]    ${getResp}
