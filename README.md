# AWS Serverless Products API

API REST serverless desenvolvida com Terraform e AWS.

## Tecnologias

- Terraform
- AWS Lambda
- API Gateway
- DynamoDB
- IAM
- CloudWatch
- Python 3.12

## Arquitetura

Cliente
   ↓
API Gateway
   ↓
AWS Lambda
   ↓
DynamoDB

Os logs da Lambda são enviados para o CloudWatch.

## Endpoints

| Método | Endpoint | Descrição |
|---|---|---|
| POST | `/products` | Criar produto |
| GET | `/products` | Listar produtos |
| GET | `/products/{id}` | Buscar produto |
| DELETE | `/products/{id}` | Deletar produto |

## Como executar

terraform init
terraform fmt
terraform validate
terraform plan
terraform apply

## Testando a API

### Criar produto

curl -X POST "API_URL/products" \
-H "Content-Type: application/json" \
-d '{"name":"Notebook","price":3500}'

### Listar produtos

curl "API_URL/products"

### Buscar produto

curl "API_URL/products/ID_DO_PRODUTO"

### Deletar produto

curl -X DELETE "API_URL/products/ID_DO_PRODUTO"

## Segurança

A Lambda utiliza uma IAM Role própria.

As permissões do DynamoDB são limitadas às operações necessárias:

- PutItem
- GetItem
- Scan
- DeleteItem

Arquivos de estado do Terraform e configurações locais não são versionados no Git.

## Destruir a infraestrutura

terraform destroy
