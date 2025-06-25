*** Settings ***
Resource    ../steps/LoginSteps.robot

*** Test Cases ***
Login Com Sucesso
    Dado que eu possua um usuario valido
    Quando eu realizo o login com credenciais validas
    Entao o sistema deve retornar status 200 e token de autorizacao

Login Com Senha Invalida
    Dado que eu possua um usuario valido
    Quando eu realizo o login com senha invalida
    Entao o sistema deve retornar status 401 e mensagem de erro