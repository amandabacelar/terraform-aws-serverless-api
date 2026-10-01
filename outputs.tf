output "lambda_arn" {
  description = "ARN da Lambda"
  value       = module.lambda.lambda_arn
}

output "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB"
  value       = module.dynamodb.table_name
}

output "api_gateway_url" {
  description = "URL da API Gateway"
  value       = module.api_gateway.api_gateway_url
}