# AWS Serverless Products API

API REST serverless desenvolvida com Terraform e AWS.

O projeto utiliza AWS Lambda, API Gateway, DynamoDB, IAM e CloudWatch para disponibilizar uma API de gerenciamento de produtos.

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