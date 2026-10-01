resource "aws_apigatewayv2_api" "api" {
  name          = "${var.project_name}-${var.environment}"
  protocol_type = "HTTP"

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
    Project     = var.project_name
  }
}

resource "aws_apigatewayv2_integration" "lambda" {
  api_id = aws_apigatewayv2_api.api.id

  integration_type = "AWS_PROXY"
  integration_uri  = var.lambda_invoke_arn

  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "posts_products" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "POST /products"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_route" "get_products" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "GET /products"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_route" "get_product_by_id" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "GET /products/{id}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_route" "delete_product_by_id" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "DELETE /products/{id}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "$default"
  auto_deploy = true

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
    Project     = var.project_name
  }
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
}