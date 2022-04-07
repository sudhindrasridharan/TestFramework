*** Settings ***
Documentation    This is Test Data file for MQTT Sanity Test Suite

*** Variables ***
${brokerUri}          iot.eclipse.org
${brokerPort}         1883
${clientId}           test.client
${topic}              test/mqtt_test
${qos}                1
${timeOut}            2
${limit}              1
${message}            TestMassage
 
