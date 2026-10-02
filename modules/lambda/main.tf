data "archive_file" "layer" {
  type        = "zip"
  source_dir  = "${path.root}/layer"
  output_path = "${path.root}/layer.zip"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.root}/lambda/lambda_function.py"
  output_path = "${path.root}/lambda/lambda_function.zip"
}

resource "aws_lambda_layer_version" "common" {
  filename            = data.archive_file.layer.output_path
  layer_name          = "${var.project_name}-${var.environment}-common"
  compatible_runtimes = [var.lambda_runtime]

  source_code_hash = data.archive_file.layer.output_base64sha256
}

resource "aws_lambda_function" "products_api" {
  function_name = "${var.project_name}-${var.environment}"

  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = var.lambda_runtime
  handler = "lambda_function.lambda_handler"

  role = var.lambda_role_arn

  memory_size = var.lambda_memory
  timeout     = var.lambda_timeout

  layers = [
    aws_lambda_layer_version.common.arn
  ]

  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
    }
  }

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
    Project     = var.project_name
  }
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.products_api.function_name}"
  retention_in_days = 14

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
    Project     = var.project_name
  }
}