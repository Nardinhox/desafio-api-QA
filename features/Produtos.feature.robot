*** Settings ***
Resource    ../steps/ProdutosSteps.robot

*** Test Cases ***
Criar Produto Com Sucesso
    Dado que eu possua dados validos para criar um produto
    Quando eu realizo a requisicao de criacao do produto
    Entao o sistema deve retornar status 201 e confirmar a criacao

Criar Produto Com Nome Ja Cadastrado
    Dado que eu possua um produto ja cadastrado
    Quando eu tento criar o mesmo produto novamente
    Entao o sistema deve retornar status 400 e mensagem de erro