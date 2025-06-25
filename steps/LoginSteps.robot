*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    Collections
Library    JSONLibrary
Resource    Common.robot
Resource    RequestsPages.robot
Resource    ../variables/Variables.robot

*** Keywords ***
Dado que eu possua um usuario valido
    Criar Sessao API    ${BASE_URL}

Quando eu realizo o login com credenciais validas
    ${body}=    Load JSON From File    ${CURDIR}/../data/login_sucesso.json
    ${response}=    Exec Requisicao    POST    ${LOGIN_ENDPOINT}    ${body}
    Set Suite Variable    ${response}

Entao o sistema deve retornar status 200 e token de autorizacao
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    authorization

Quando eu realizo o login com senha invalida
    ${body}=    Load JSON From File    ${CURDIR}/../data/login_senha_invalida.json
    ${response}=    Exec Requisicao    POST    ${LOGIN_ENDPOINT}    ${body}    401
    Set Suite Variable    ${response}

Entao o sistema deve retornar status 401 e mensagem de erro
    Should Be Equal As Integers    ${response.status_code}    401
    Should Contain    ${response.json()}[message]    Email e/ou senha inválidos