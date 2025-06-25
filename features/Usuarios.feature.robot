*** Settings ***
Resource    ../steps/UsuariosSteps.robot

*** Test Cases ***
Cadastrar Usuario Com Sucesso
    Dado que eu possua dados validos para criar um usuario
    Quando eu realizo a requisicao de criacao do usuario
    Entao o sistema deve retornar status 201 e confirmar a criacao

Consultar Usuario Com Sucesso
    Dado que eu possua um usuario ja cadastrado
    Quando eu realizo a requisicao de consulta do usuario
    Entao o sistema deve retornar status 200 e os dados do usuario
