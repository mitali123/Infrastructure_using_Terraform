variable "lambda_bucket_name" {
  description = "S3 bucket that contains the Lambda deployment package (zip)"
  type        = string
}

variable "lambda_s3_key" {
  description = "S3 key (object name) for the Lambda zip file (e.g., passwordReset.zip)"
  type        = string
}

variable "lambda_function_name" {
  description = "Name for the Lambda function"
  type        = string
}

variable "lambda_handler" {
  description = "Lambda handler (e.g., index.handler or passwordReset.passwordReset)"
  type        = string
  default     = "index.handler"
}

variable "lambda_runtime" {
  description = "Lambda runtime (e.g., nodejs14.x, python3.9)"
  type        = string
  default     = "nodejs14.x"
}

variable "lambda_timeout" {
  description = "Timeout in seconds for Lambda function"
  type        = number
  default     = 10
}

variable "environment_variables" {
  description = "Map of environment variables to set for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "sns_topic_name" {
  description = "SNS topic name used to trigger the Lambda (optional)"
  type        = string
  default     = "lambda-topic"
}

variable "dynamodb_table_arn" {
  description = "ARN of an existing DynamoDB table the Lambda may access (optional)"
  type        = string
  default     = ""
}
