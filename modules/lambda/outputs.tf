output "lambda_arn" {
  value = aws_lambda_function.products_api.arn
}

output "lambda_invoke_arn" {
  value = aws_lambda_function.products_api.invoke_arn
}

output "lambda_function_name" {
  value = aws_lambda_function.products_api.function_name
}