*** Settings ***
Library    RequestsLibrary

*** Keywords ***
Exec Requisicao
    [Arguments]    ${method}    ${endpoint}    ${body}=None    ${expected_status}=ANY
    ${response}=    Run Keyword If    '${method}' == 'POST'    POST On Session    sessao_api    ${endpoint}    json=${body}    expected_status=${expected_status}
    ...    ELSE IF    '${method}' == 'GET'    GET On Session    sessao_api    ${endpoint}    expected_status=${expected_status}
    ...    ELSE IF    '${method}' == 'PUT'    PUT On Session    sessao_api    ${endpoint}    json=${body}    expected_status=${expected_status}
    ...    ELSE IF    '${method}' == 'DELETE'    DELETE On Session    sessao_api    ${endpoint}    expected_status=${expected_status}
    [Return]    ${response}