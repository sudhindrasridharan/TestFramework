*** Settings ***
Documentation    This resource file consist keywords for AWS DynamoDB Library Testing.
Library    ../../src/wrappers/aws/DynamoDBWrapper.py


*** Keywords ***
Start Aws DynamoDB Session
    [Arguments]    ${awsAccessKey}    ${awsSecretKey}    ${awsRegionName}
    [Documentation]    Start AWS DynamoDB Session to read/write DB table
    ${sessionResp}    createAwsDynamoDBSession    ${awsAccessKey}    ${awsSecretKey}    ${awsRegionName}
    Should Be Equal    '${sessionResp}'    'True'

Create New DB Table
    [Arguments]    ${name}    ${keySchema}    ${attrDefinitions}    ${provisionedThroughput}
    [Documentation]    Create New Table into DataBase
    ${createTableResp}    createNewTable    ${name}    ${keySchema}    ${attrDefinitions}    ${provisionedThroughput}
    Should Be Equal    '${createTableResp}'    'True'

Put Item In DB table
    [Arguments]    ${tableName}    ${item}
    [Documentation]    Put New Item into Existing DB Table
    ${response}    putItemIntable    ${tableName}    ${item}
    [Return]    ${response}

Get Item From DB Table
    [Arguments]    ${tableName}    ${item}
    [Documentation]    Get Item from Existing DB Table
    ${response}    getItemFromTable    ${tableName}    ${item}
    [Return]    ${response}

Delete Item From DB Table
    [Arguments]    ${tableName}    ${item}
    [Documentation]    Delete Item from DB Table
    ${response}    deleteItemFromTable    ${tableName}    ${item}
    [Return]    ${response}

Scan DB Table
    [Arguments]    ${tableName}
    [Documentation]    Scan Item from DB Table
    ${response}    scanTable    ${tableName}
    [Return]    ${response}

search Query From The DB Table
    [Arguments]    ${tableName}    ${searchKey}     ${expectedVal}
    [Documentation]    Search specific item from the table
    ${response}    searchQueryFromTheTable    ${tableName}    ${searchKey}     ${expectedVal}
    [Return]    ${response}

Delete DB Table
    [Arguments]    ${tableName}
    [Documentation]    Delete Table from the DataBase
    ${response}    deleteTable    ${tableName}
    [Return]    ${response}
