# AWS Serverless Products API

API REST serverless desenvolvida com **Terraform** e **AWS**, utilizando Lambda, API Gateway e DynamoDB.

O projeto demonstra conceitos de **Infraestrutura como Código (IaC)**, arquitetura serverless, modularização com Terraform e gerenciamento de recursos AWS.

## Arquitetura

```text
Cliente
   |
   v
API Gateway
   |
   v
AWS Lambda
   |
   v
DynamoDB

Lambda
   |
   v
CloudWatch
```

## Tecnologias

- Terraform
- AWS Lambda
- API Gateway
- DynamoDB
- IAM
- CloudWatch
- Python 3.12
- Boto3

## Endpoints

| Método | Endpoint         | Função          |
|--------|------------------|-----------------|
| POST   | `/products`      | Criar produto   |
| GET    | `/products`      | Listar produtos |
| GET    | `/products/{id}` | Buscar produto  |
| DELETE | `/products/{id}` | Deletar produto |

## Estrutura

```text
.
├── lambda/
│   └── lambda_function.py
├── layer/
│   └── python/
│       └── utils.py
├── modules/
│   ├── api-gateway/
│   ├── dynamodb/
│   ├── iam/
│   └── lambda/
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
└── versions.tf
```

## Recursos AWS

O Terraform provisiona:

- API Gateway
- AWS Lambda
- DynamoDB
- IAM Role e Policy
- CloudWatch Log Group
- Lambda Layer

A infraestrutura é organizada em **módulos Terraform**, facilitando manutenção e reutilização.

## Execução

Inicializar o Terraform:

```bash
terraform init
```

Validar:

```bash
terraform validate
```

Visualizar o plano:

```bash
terraform plan
```

Aplicar:

```bash
terraform apply
```

Visualizar os outputs:

```bash
terraform output
```

## Teste

Após o deploy:

```bash
curl "API_URL/products"
```

Exemplo para criar um produto:

```bash
curl -X POST "API_URL/products" \
  -H "Content-Type: application/json" \
  -d '{"name":"Notebook","price":3500}'
```

## Conceitos praticados

- Infrastructure as Code
- Arquitetura Serverless
- Terraform Modules
- Terraform Workspaces
- AWS Lambda
- API Gateway
- DynamoDB
- IAM
- CloudWatch
- Lambda Layers
- CORS

## Próximos passos

- API Key
- Usage Plan
- Autenticação com `x-api-key`
- Melhorias de observabilidade
- Evolução dos ambientes `dev`, `staging` e `prod`

## Objetivo

Projeto desenvolvido para estudos e portfólio, com foco em **Cloud Computing, DevOps, Terraform e AWS**.
