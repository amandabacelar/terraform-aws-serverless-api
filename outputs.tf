output "lambda_arn" {
  description = "ARN da Lambda"
  value       = aws_lambda_function.products_api.arn
}

output "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB"
  value       = aws_dynamodb_table.products.name
}

output "api_gateway_url" {
  description = "URL da API Gateway"
  value       = aws_apigatewayv2_api.api.api_endpoint
}