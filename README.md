# BankSystem

Este é um código Perl que implementa uma aplicação de cadastro de contas bancárias simples. A aplicação utiliza um banco de dados PostgreSQL para armazenar informações das contas e também armazena os dados em um arquivo JSON localmente. O código foi desenvolvido com uso de módulos como `DBI` para a conexão com o banco de dados e `JSON` para manipulação de arquivos JSON.

## Pré-requisitos

Antes de executar a aplicação, certifique-se de que os seguintes pré-requisitos estão instalados:

- Perl (a aplicação foi desenvolvida em Perl)
- PostgreSQL (com um banco de dados vazio criado)

## Configurações

No início do código, há algumas configurações que você pode ajustar conforme necessário:

- `$db_name`: Nome do banco de dados PostgreSQL a ser utilizado.
- `$db_user`: Nome de usuário do banco de dados PostgreSQL.
- `$db_pass`: Senha do usuário do banco de dados PostgreSQL.
- `$db_host`: Host do banco de dados PostgreSQL.

Verifique se essas configurações estão corretas para a sua instalação do PostgreSQL.

## Funcionalidades

A aplicação oferece as seguintes funcionalidades:

1. **Cadastrar Conta:** Permite ao usuário criar uma nova conta bancária, fornecendo informações como login, senha, CPF, nome completo e saldo inicial. Os dados são inseridos no banco de dados PostgreSQL e também salvos em um arquivo JSON localmente.

2. **Visualizar Informações:** Permite ao usuário realizar o login e visualizar informações da conta, incluindo nome completo, CPF e saldo. Os dados são recuperados do banco de dados PostgreSQL.

3. **Sair:** Encerra a execução da aplicação.

## Como Usar

1. Execute o script Perl em um ambiente compatível com Perl.

2. O menu principal será exibido, onde você pode escolher as opções digitando o número correspondente seguido de Enter.

3. Para cadastrar uma conta, escolha a opção 1 e siga as instruções para fornecer os dados necessários.

4. Para visualizar informações de uma conta, escolha a opção 2 e siga as instruções para fazer o login.

5. Para sair da aplicação, escolha a opção 3.
