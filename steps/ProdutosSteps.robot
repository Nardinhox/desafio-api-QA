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
Dado que eu possua dados validos para criar um produto
    Criar Sessao API    ${BASE_URL}
    ${login_body}=    Load JSON From File    ${CURDIR}/../data/login_sucesso.json
    ${login_response}=    Exec Requisicao    POST    ${LOGIN_ENDPOINT}    ${login_body}
    ${token}=    Set Variable    ${login_response.json()}[authorization]
    Set Suite Variable    ${AUTH_TOKEN}    ${token}
    ${random}=    Generate Random String    5
    Set Suite Variable    ${produto_nome}    Produto ${random}

Quando eu realizo a requisicao de criacao do produto
    ${body}=    Create Dictionary    nome=${produto_nome}    preco=100    descricao=Produto Teste    quantidade=10
    ${headers}=    Create Dictionary    Authorization=${AUTH_TOKEN}
    ${response}=    POST On Session    sessao_api    ${PRODUTOS_ENDPOINT}    json=${body}    headers=${headers}
    Set Suite Variable    ${response}

Entao o sistema deve retornar status 201 e confirmar a criacao
    Should Be Equal As Integers    ${response.status_code}    201
    Should Contain    ${response.json()['message']}    Cadastro realizado com sucesso

Dado que eu possua um produto ja cadastrado
    Criar Sessao API    ${BASE_URL}
    ${login_body}=    Load JSON From File    ${CURDIR}/../data/login_sucesso.json
    ${login_response}=    Exec Requisicao    POST    ${LOGIN_ENDPOINT}    ${login_body}
    ${token}=    Set Variable    ${login_response.json()}[authorization]
    Set Suite Variable    ${AUTH_TOKEN}    ${token}

Quando eu tento criar o mesmo produto novamente
    ${body}=    Load JSON From File    ${CURDIR}/../data/produto_cadastro.json
    ${headers}=    Create Dictionary    Authorization=${AUTH_TOKEN}
    ${response}=    POST On Session    sessao_api    ${PRODUTOS_ENDPOINT}    json=${body}    headers=${headers}    expected_status=400
    Set Suite Variable    ${response}

Entao o sistema deve retornar status 400 e mensagem de erro
    Should Be Equal As Integers    ${response.status_code}    400
    Should Contain    ${response.json()}[message]    Já existe produto com esse nome