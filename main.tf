module "dynamodb" {
  source = "./modules/dynamodb"

  project_name = var.project_name
  environment  = var.environment
}

module "iam" {
  source = "./modules/iam"

  project_name       = var.project_name
  environment        = var.environment
  dynamodb_table_arn = module.dynamodb.table_arn
}

module "lambda" {
  source = "./modules/lambda"

  project_name        = var.project_name
  environment         = var.environment
  lambda_runtime      = var.lambda_runtime
  lambda_memory       = var.lambda_memory
  lambda_timeout      = var.lambda_timeout
  lambda_role_arn     = module.iam.lambda_role_arn
  dynamodb_table_name = module.dynamodb.table_name
}

module "api_gateway" {
  source = "./modules/api-gateway"

  project_name         = var.project_name
  environment          = var.environment
  lambda_invoke_arn    = module.lambda.lambda_invoke_arn
  lambda_function_name = module.lambda.lambda_function_name
}