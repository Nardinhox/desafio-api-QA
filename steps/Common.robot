*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    suppress_warnings.py
Library    String
Library    Collections
Resource    RequestsPages.robot
Resource    ../variables/Variables.robot

*** Keywords ***
Criar Sessao API
    [Arguments]    ${base_url}
    Create Session    sessao_api    ${base_url}

Validar Status Code
    [Arguments]    ${response}    ${status_code_esperado}
    Should Be Equal As Integers    ${response.status_code}    ${status_code_esperado}

Validar Campo Em Resposta
    [Arguments]    ${response}    ${campo}
    Dictionary Should Contain Key    ${response.json()}    ${campo}

Validar Mensagem Em Resposta
    [Arguments]    ${response}    ${mensagem_esperada}
    Should Contain    ${response.json()}[message]    ${mensagem_esperada}

Gerar email aleatório
    ${random_string}=    Generate Random String    5
    ${email_aleatorio}=    Set Variable    ${random_string}@qa.com
    [Return]    ${email_aleatorio}

Criar usuario com email aleatorio
    ${email_aleatorio}=    Gerar email aleatório
    ${body}=    Load JSON From File    ${CURDIR}/../data/usuario_cadastro.json
    Set To Dictionary    ${body}    email=${email_aleatorio}    administrador=true
    [Return]    ${body}    ${email_aleatorio}