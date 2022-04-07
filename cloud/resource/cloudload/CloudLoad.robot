*** Settings ***
Documentation    This resource file consist keywords for cloud load testing.
           ...    - This resource file allows the user execute existing keywords of Locust library

Library    ${CURDIR}/../../src/wrappers/cloudload/LocustWrapper.py
Library    ${CURDIR}/../../src/lib/load/LocustLib.py
Library    OperatingSystem

*** Keywords ***
Generate Http Locust Request
    [Arguments]    ${method}    ${host}    ${url}    ${name}=${None}    ${catch_response}=${None}    ${params}=${None}    ${data}=${None}    ${headers}=${None}    ${cookies}=${None}    ${files}=${None}     ${auth}=${None}    ${timeout}=${None}    ${allow_redirects}=${None}    ${proxies}=${None}    ${stream}=${None}    ${verify}=${None}    ${cert}=${None}    ${max_wait}=1000    ${min_wait}=1000
    [Documentation]    Create a locust file with specific/define request.
    ...                \n*method* – method for the new Request object.
    ...                \n*url* – URL for the new Request object.
    ...                \n*name* – (optional) An argument that can be specified to use as label in Locust’s statistics instead of the URL path. This can be used to group different URL’s that are requested into a single entry in Locust’s statistics.
    ...                \n*catch_response* – (optional) Boolean argument that, if set, can be used to make a request return a context manager to work as argument to a with statement. This will allow the request to be marked as a fail based on the content of the response, even if the response code is ok (2xx). The opposite also works, one can use catch_response to catch a request and then mark it as successful even if the response code was not (i.e 500 or 404).
    ...                \n*params* – (optional) Dictionary or bytes to be sent in the query string for the Request.
    ...                \n*data* – (optional) Dictionary or bytes to send in the body of the Request.
    ...                \n*headers* – (optional) Dictionary of HTTP Headers to send with the Request.
    ...                \n*cookies* – (optional) Dict or CookieJar object to send with the Request.
    ...                \n*files* – (optional) Dictionary of 'filename': file-like-objects for multipart encoding upload.
    ...                \n*auth* – (optional) Auth tuple or callable to enable Basic/Digest/Custom HTTP Auth.
    ...                \n*timeout* (float) – (optional) How long to wait for the server to send data before giving up, as a float.
    ...                \n*allow_redirects* (bool) – (optional) Set to True by default.
    ...                \n*proxies* – (optional) Dictionary mapping protocol to the URL of the proxy.
    ...                \n*stream* – (optional) whether to immediately download the response content. Defaults to False.
    ...                \n*verify* – (optional) if True, the SSL cert will be verified. A CA_BUNDLE path can also be provided.
    ...                \n*cert* – (optional) if String, path to ssl client cert file (.pem). If Tuple, (‘cert’, ‘key’) pair.
    Log    Creating Locust file    console=yes
    ${returnValue}    generateRequest    ${method}    ${host}    ${url}    ${name}    ${catch_response}    ${params}    ${data}    ${headers}    ${cookies}    ${files}     ${auth}    ${timeout}    ${allow_redirects}    ${proxies}    ${stream}    ${verify}    ${cert}    ${max_wait}    ${min_wait}
    Should Be True    ${returnValue}
    Log    Generated sussesfully Locustfile.py    console=yes

Generate Mqtt Locust Request
    [Arguments]    ${method}    ${host}   ${topic}    ${qos}    ${retry}    ${timeout}    ${payload}=${None}    ${name}=mqtt
    [Documentation]    Create a locust file with specific/define mqtt request.
    ...                \n*method* - the method (publish/subsribe)
    ...                \n*host* - the host url with port number (e.g: broker.hivemq.com:1883) 
    ...                \n*topic* - the topic to publish to (topic string)
    ...                \n*qos* - QoS level
    ...                \n*retry* - retry count
    ...                \n*timeout* - time out for response
    ...                \n*payload* - (optional) the payload to publish, (buffer or string)
    ...                \n*name* - (optional) assign name to request
    Log    Creating Locust file    console=yes
    ${returnValue}    generateMqttRequest    ${method}    ${host}   ${topic}    ${qos}    ${retry}    ${timeout}    ${payload}    ${name}
    Should Be True    ${returnValue}
    Log    Generated sussesfully Locustfile.py    console=yes

Start Locust Execution
   [Arguments]    ${num_clients}    ${hatch_rate}    ${num_requests}    ${csvBase}=${TEST NAME}
   [Documentation]    Start Locust cli execution
   ...                \n*num_clients* - number of clints to be generated.
   ...                \n*hatch_rate* - number of users to be created per second.
   ...                \n*num_requests* - number of requests to be generated.
   ...                \n*csvBase* - Csv report file base name.
   Log    Starting Locust Execution    console=yes
   ${returnValue}    startExecution    ${num_clients}    ${hatch_rate}    ${num_requests}    ${csvBase}
   Log    Load test is done
   [Return]    ${returnValue}

Compare Response Per Second
   [Arguments]     ${responsePerSec}    ${csvReportFile}=${TEST NAME}
   [Documentation]    Compare response per second from report file
   ...                \n*responsePerSec* - number of response per sec to be compared with test execution value.
   ...                \n*csvReportFile* - Csv report file name from Rps will be compared.
   ${returnValue}    compareStatistics    ${responsePerSec}    ${csvReportFile}
   Should Be True    ${returnValue}

Plot Pi Chart
   [Arguments]    ${plotFileName}    ${csvReportFile}=${TEST NAME}
   [Documentation]    Plot PI chart of test result.
   ...                \n*plotFileName* - file name for plot to save.
   ...                \n*csvReportFile* - Csv report file name from plot will be generated.
   Log    Generating Plot.    console=yes
   ${returnValue}    plotGraph    ${plotFileName}    ${csvReportFile}
   Should Be True    ${returnValue}
   Log    Generated plot succesfully.    console=yes
