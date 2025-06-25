*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    Collections
Library    JSONLibrary
Resource    Common.robot
Resource    RequestsPages.robot
Resource    ../variables/Variables.robot

*** Keywords ***
Limpar Carrinho Do Usuario
    [Documentation]    Remove o carrinho do usuário de teste
    Criar Sessao API    ${BASE_URL}
    ${login_body}=    Load JSON From File    ${CURDIR}/../data/login_sucesso.json
    ${login_response}=    Exec Requisicao    POST    ${LOGIN_ENDPOINT}    ${login_body}
    ${token}=    Set Variable    ${login_response.json()}[authorization]
    ${headers}=    Create Dictionary    Authorization=${token}
    ${response}=    GET On Session    sessao_api    ${CARRINHOS_ENDPOINT}
    ${carrinhos}=    Set Variable    ${response.json()['carrinhos']}
    Run Keyword If    ${carrinhos}    DELETE On Session    sessao_api    ${CARRINHOS_ENDPOINT}/concluir-compra    headers=${headers}

Dado que eu possua um produto disponivel
    Limpar Carrinho Do Usuario
    Criar Sessao API    ${BASE_URL}
    ${login_body}=    Load JSON From File    ${CURDIR}/../data/login_sucesso.json
    ${login_response}=    Exec Requisicao    POST    ${LOGIN_ENDPOINT}    ${login_body}
    ${token}=    Set Variable    ${login_response.json()}[authorization]
    Set Suite Variable    ${AUTH_TOKEN}    ${token}
    ${produto}=    Create Dictionary    idProduto=BeeJh5lz3k6kSIzA    quantidade=1
    Set Suite Variable    ${produto}    ${produto}

Quando eu realizo a requisicao de criacao do carrinho
    ${produtos}=    Create List    ${produto}
    ${body}=    Create Dictionary    produtos=${produtos}
    ${headers}=    Create Dictionary    Authorization=${AUTH_TOKEN}
    ${response}=    POST On Session    sessao_api    ${CARRINHOS_ENDPOINT}    json=${body}    headers=${headers}
    Set Suite Variable    ${response}

Entao o sistema deve retornar status 201 e confirmar a criacao
    Should Be Equal As Integers    ${response.status_code}    201
    Should Contain    ${response.json()['message']}    Cadastro realizado com sucesso

Dado que eu informe um produto que nao existe
    Limpar Carrinho Do Usuario
    Criar Sessao API    ${BASE_URL}
    ${login_body}=    Load JSON From File    ${CURDIR}/../data/login_sucesso.json
    ${login_response}=    Exec Requisicao    POST    ${LOGIN_ENDPOINT}    ${login_body}
    ${token}=    Set Variable    ${login_response.json()}[authorization]
    Set Suite Variable    ${AUTH_TOKEN}    ${token}
    ${random_id}=    Generate Random String    16    [LETTERS][NUMBERS]
    Set Suite Variable    ${produto_id_inexistente}    ${random_id}

Quando eu tento criar um carrinho com produto invalido
    ${produto_invalido}=    Create Dictionary    idProduto=${produto_id_inexistente}    quantidade=1
    ${produtos}=    Create List    ${produto_invalido}
    ${body}=    Create Dictionary    produtos=${produtos}
    ${headers}=    Create Dictionary    Authorization=${AUTH_TOKEN}
    ${response}=    POST On Session    sessao_api    ${CARRINHOS_ENDPOINT}    json=${body}    headers=${headers}    expected_status=400
    Set Suite Variable    ${response}

Entao o sistema deve retornar status 400 e produto nao encontrado
    Should Be Equal As Integers    ${response.status_code}    400
    Should Contain    ${response.json()}[message]    Produto não encontrado
