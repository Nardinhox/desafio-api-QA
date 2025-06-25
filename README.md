# Desafio de Automação de API

Testes Automatizados de API com Robot Framework - Este repositório contém testes automatizados de API com a finalidade de explorar e validar as funcionalidades da API, utilizando Robot Framework.

## Pré-requisitos
Certifique-se de ter as seguintes ferramentas instaladas para executar o teste.

## Ferramentas Necessárias
Python 3.8 ou superior
Robot Framework
Bibliotecas adicionais listadas no "requirements.txt"

## Configuração do Ambiente
1. Instalar Python: Verifique se o Python está instalado executando "python --version" no terminal. Se não estiver instalado, siga as instruções no site oficial do Python (https://www.python.org/downloads/).

2. Instalar Robot Framework: Execute o comando "pip install robotframework" no terminal para instalar o Robot Framework.

3. Instalar as Bibliotecas Necessárias: Execute o comando "pip install -r requirements.txt" no terminal para instalar o Robot Framework.

## Como executar os testes
1. Clone o repositório "" e navegue até o diretório raiz do projeto

2.  Executar todos os testes: Execute o comando "robot features" no terminal
Ou
    Executar os testes por cenário: Execute o comando "robot features/{cenário}.feature.robot" no terminal (Exemplo: "robot features/Login.feature.robot")

## Estrutura do Projeto
DESAFIO-API-QA/
├── features/                               # Cenários de teste em formato BDD
│   ├── Carrinhos.feature.robot
│   ├── Login.feature.robot
│   ├── Produtos.feature.robot
│   └── Usuarios.feature.robot
│
├── steps/                                  # Implementação dos passos dos cenários
│   ├── CarrinhosSteps.robot
│   ├── LoginSteps.robot
│   ├── ProdutosSteps.robot
│   ├── UsuariosSteps.robot
│   ├── Common.robot
│   └── RequestsPages.robot
│
├── variables/                              # Variáveis globais utilizadas nos testes
│   └── Variables.robot
│
├── data/                                   # Dados de entrada para os testes (JSON)
│   ├── login_sucesso.json
│   ├── login_senha_invalida.json
│   ├── usuario_cadastro.json
│   ├── produto_cadastro.json
│   ├── carrinho_vazio.json
│   └── carrinho_produto_invalido.json
│
├── log.html                                # Relatório gerado pelo Robot após a execução
├── output.xml                              # Saída padrão do Robot
├── report.html                             # Relatório detalhado da execução
├── requirements.txt                        # Bibliotecas necessárias
└── README.md                               # Documentação do projeto

## Cenários de Teste Levantados

### **1. FUNCIONALIDADE: LOGIN**
**Caminho de Sucesso:**
- Login com credenciais válidas

**Caminho de Insucesso:**
- Login com senha incorreta
- Login com email inexistente
- Login com email em formato inválido
- Login com token expirado

**Caminho Alternativo:**
- Login com campos obrigatórios ausentes

### **2. FUNCIONALIDADE: USUÁRIOS**
**Caminho de Sucesso:**
- Cadastrar usuário com dados válidos
- Consultar usuário existente
- Editar dados do usuário
- Excluir usuário existente

**Caminho de Insucesso:**
- Cadastrar usuário com email já existente
- Consultar usuário inexistente
- Cadastrar usuário com dados inválidos

**Caminho Alternativo:**
- Cadastrar usuário com campos obrigatórios ausentes
- Editar usuário com dados inválidos

### **3. FUNCIONALIDADE: PRODUTOS**
**Caminho de Sucesso:**
- Cadastrar produto com dados válidos
- Consultar produto existente
- Listar todos os produtos
- Editar dados do produto
- Excluir produto existente

**Caminho de Insucesso:**
- Cadastrar produto com nome já existente
- Consultar produto inexistente
- Cadastrar produto com preço negativo
- Cadastrar produto com quantidade negativa

**Caminho Alternativo:**
- Cadastrar produto com campos obrigatórios ausentes
- Editar produto com dados inválidos

### **4. FUNCIONALIDADE: CARRINHOS**
**Caminho de Sucesso:**
- Criar carrinho com produtos válidos
- Consultar carrinho existente
- Listar todos os carrinhos
- Concluir compra do carrinho
- Cancelar compra do carrinho

**Caminho de Insucesso:**
- Criar carrinho sem produtos
- Criar carrinho com produto inexistente
- Criar carrinho com quantidade maior que estoque
- Consultar carrinho inexistente

**Caminho Alternativo:**
- Criar carrinho com dados inválidos
- Concluir carrinho já finalizado

## Cenários de Teste Automatizados
### Login
- Login com credenciais válidas
- Login com senha inválida

### Usuarios
- Cadastrar usuário com sucesso
- Consultar usuário existente

### Produtos
- Criar produto com sucesso
- Criar produto com nome já cadastrado

### Carrinhos
- Criar carrinho com sucesso
- Criar carrinho com produto inexistente

## Ferramentas Utilizadas
- Robot Framework 6.1.1
- RequestsLibrary 0.9.7
- Python 3.10+

## Estrutura BDD Utilizada
- Dado: Configuracao ou estado inicial
- Quando: Acao executada
- Entao: Validacao da resposta
