*** Settings ***
Documentation    This file contains all sanity level tests for MQTT Library keywords.
Resource    ../../../resource/cloudfunctional/mqtt/MqttResource.robot
Resource    MqttTestData.robot

*** Test Cases ****
TC-1:
    [Documentation]    To Connect with MQTT Broken with specific client id
    [Tags]    TCID_1    Sanity
    ${mqttc}    Connect    ${brokerUri}    client_id=${clientId}
    Should be equal as strings    ${mqttc._client_id}    ${clientId}

TC-2:
    [Documentation]    To Connect with MQTT broker with specified port and client id
    [Tags]    TCID_2    Sanity
    ${mqttc}    Connect    ${brokerUri}    ${brokerPort}    ${clientId}
    Should be equal as strings    ${mqttc._client_id}    ${clientId}

TC-3:
    [Documentation]    To Disconnect from MQTT Broker
    [Tags]    TCID_3    Sanity
    ${mqttc}    Connect    ${brokerUri}    client_id=${clientId}
    Disconnect

TC-4:
    [Documentation]    To Publish a message on perticular topic
    [Tags]    TCID_4    Sanity
    ${mqttc}    Connect    ${brokerUri}    client_id=${clientId}
    ${time}    Get Time    epoch
    ${message}    Catenate    test message    ${time}
    Publish    topic=${topic}    message=${message}

TC-5:
    [Documentation]    To Publish mutiple messages on perticular topic
    [Tags]    TCID_5    Sanity
    ${testMessage1}    Create Dictionary    topic=${topic}    payload=MQTTTest_1
    ${testMessage2}    Create Dictionary    topic=${topic}    payload=MQTTTest_2
    @{msgs}    Create List    ${testMessage1}    ${testMessage2}
    Publish Multiple    msgs=${msgs}    hostname=${brokerUri}

TC-6:
    [Documentation]    To Subscribe on perticular topic and get message
    [Tags]    TCID_6    Sanity
    Connect    ${brokerUri}    ${brokerPort}    ${clientId}    ${false}
    @{messages}    Subscribe    ${topic}    ${qos}    ${timeOut}    ${limit}

TC-7:
    [Documentation]    To Subscribe on perticular topic and validate
    [Tags]    TCID_7    Sanity
    Connect    ${brokerUri}    ${brokerPort}    ${clientId}
    #Subscribe    ${topic}    ${qos}    ${timeOut}    ${limit}
    Subscribe and Validate    ${topic}    ${qos}    ${message}    10

TC-8:
    [Documentation]    To Unsubscribe from perticular topic
    [Tags]    TCID_8    Sanity
    ${mqttc}    Connect    ${brokerUri}    client_id=${clientId}
    Unsubscribe    ${topic}
