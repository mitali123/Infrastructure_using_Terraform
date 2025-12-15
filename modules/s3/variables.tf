variable "webapp_bucket_name" {
  description = "Name of the S3 bucket used to store web application assets or static content."
  type        = string
}

variable "codedeploy_bucket_name" {
  description = "Name of the S3 bucket used by AWS CodeDeploy to store application deployment artifacts."
  type        = string
}

variable "lambda_bucket_name" {
  description = "Name of the S3 bucket that stores Lambda deployment packages (ZIP files) for serverless functions."
  type        = string
}

