*** Settings ***
Resource    ../steps/CarrinhosSteps.robot

*** Test Cases ***
Criar Carrinho Com Sucesso
    Dado que eu possua um produto disponivel
    Quando eu realizo a requisicao de criacao do carrinho
    Entao o sistema deve retornar status 201 e confirmar a criacao

Criar Carrinho Com Produto Inexistente
    Dado que eu informe um produto que nao existe
    Quando eu tento criar um carrinho com produto invalido
    Entao o sistema deve retornar status 400 e produto nao encontrado
