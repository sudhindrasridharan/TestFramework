*** Settings ***
Documentation    This resource file consist keywords for cloud testing.
           ...    - This resource file allows the user execute existing keywords of all available cloud libraries.

Library    ${CURDIR}/../src/lib/ResponseValidator.py

*** Keywords ***
Cloud Response Validation
    [Arguments]    ${responseType}    ${response}    ${traversalPath}
    [Documentation]    This function will return response value for given *tracersal path* for 'JSON' and 'XML' type of responses.
                       ...                   
                       ...     *Args:*
                       ...       - ${responseType} - Provide response type (Ex: 'JSON', 'XML')
                       ...       - ${response} - Provide variable where response is stored
                       ...       - ${traversalPath} - Provide traversal path for whom need to find value (Ex: 'dict:args,dict:key,list:0')
                       ...
                       ...     *Examples:*
                       ...     | ${response} | Cloud Response Validation | JSON | ${cloudResponse} | dict:args,dict:key,list:0

    ${response}    responseValidation    responseType=${responseType}    response=${response}    traversalPath=${traversalPath}
    [Return]    ${response}
