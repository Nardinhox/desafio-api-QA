*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    Collections
Library    JSONLibrary
Library    String
Resource    Common.robot
Resource    RequestsPages.robot
Resource    ../variables/Variables.robot


*** Keywords ***
Dado que eu possua dados validos para criar um usuario
    Criar Sessao API    ${BASE_URL}

Quando eu realizo a requisicao de criacao do usuario
    ${body}    ${email_aleatorio}=    Criar usuario com email aleatorio
    ${response}=    Exec Requisicao    POST    ${USUARIOS_ENDPOINT}    ${body}
    Set Suite Variable    ${response}

Entao o sistema deve retornar status 201 e confirmar a criacao
    Should Be Equal As Integers    ${response.status_code}    201
    Should Contain    ${response.json()}[message]    Cadastro realizado com sucesso

Dado que eu possua um usuario ja cadastrado
    Criar Sessao API    ${BASE_URL}
    ${body}    ${email_aleatorio}=    Criar usuario com email aleatorio
    ${response}=    Exec Requisicao    POST    ${USUARIOS_ENDPOINT}    ${body}
    Should Be Equal As Integers    ${response.status_code}    201
    Set Suite Variable    ${USER_EMAIL}    ${email_aleatorio}
    Set Suite Variable    ${USER_ID}    ${response.json()}[_id]

Quando eu realizo a requisicao de consulta do usuario
    ${response}=    Exec Requisicao    GET    ${USUARIOS_ENDPOINT}/${USER_ID}
    Set Suite Variable    ${response}

Entao o sistema deve retornar status 200 e os dados do usuario
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Value    ${response.json()}    ${USER_EMAIL}