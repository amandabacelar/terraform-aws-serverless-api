variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "lambda_runtime" {
  type = string
}

variable "lambda_memory" {
  type = number
}

variable "lambda_timeout" {
  type = number
}

variable "lambda_role_arn" {
  type = string
}

variable "dynamodb_table_name" {
  type = string
}