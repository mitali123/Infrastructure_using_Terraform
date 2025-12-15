variable "region" {
  description = "AWS region where all infrastructure resources will be deployed."
  type        = string
}

variable "vpc_name" {
  description = "Name assigned to the VPC and related networking components."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnet1_cidr" {
  description = "CIDR block for Public Subnet 1 (typically used in AZ1)."
  type        = string
}

variable "public_subnet2_cidr" {
  description = "CIDR block for Public Subnet 2 (typically used in AZ2)."
  type        = string
}

variable "public_subnet3_cidr" {
  description = "CIDR block for Public Subnet 3 (typically used in AZ3)."
  type        = string
}

variable "private_subnet1_cidr" {
  description = "CIDR block for Private Subnet 1 (typically used for backend workloads in AZ1)."
  type        = string
}

variable "private_subnet2_cidr" {
  description = "CIDR block for Private Subnet 2 (typically used for backend workloads in AZ2)."
  type        = string
}

variable "private_subnet3_cidr" {
  description = "CIDR block for Private Subnet 3 (typically used for backend workloads in AZ3)."
  type        = string
}

variable "az1" {
  description = "Availability Zone identifier for zone 1."
  type        = string
}

variable "az2" {
  description = "Availability Zone identifier for zone 2."
  type        = string
}

variable "az3" {
  description = "Availability Zone identifier for zone 3."
  type        = string
}

variable "ami_id" {
  description = "AMI ID used for EC2 instance deployment (e.g., Amazon Linux 2 AMI)."
  type        = string
}

variable "key_name" {
  description = "Key pair name used for SSH access to EC2 instances."
  type        = string
}

variable "webapp_bucket_name" {
  description = "S3 bucket name used to store web application assets or artifacts."
  type        = string
}

variable "codedeploy_bucket_name" {
  description = "S3 bucket name used by AWS CodeDeploy for application revision storage."
  type        = string
}

variable "lambda_bucket_name" {
  description = "S3 bucket name that stores Lambda function deployment packages."
  type        = string
}

variable "cert_arn" {
  description = "ssl cert arn."
  type        = string
  default     = "arn:aws:acm:us-east-1:210150958355:certificate/da6b93e0-9866-4dd5-b90b-5820460d727f"
}

variable "rds_username" {
  description = "Master username for the Amazon RDS instance."
  type        = string
}

variable "rds_password" {
  description = "Master password for the Amazon RDS instance."
  type        = string
  sensitive   = true
}

variable "rds_db_name" {
  description = "Initial database name created inside the RDS instance."
  type        = string
}

variable "rds_identifier" {
  description = "Unique DB instance identifier for RDS."
  type        = string
}

variable "account_num" {
  description = "AWS account number used for resource permissions, ARNs, and cross-service integrations."
  type        = string
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the ALB record, e.g., app.example.com"
  type        = string
}

variable "lambda_s3_key" {
  description = "S3 key for the Lambda deployment package (zip) stored in lambda_bucket_name."
  type        = string
}

variable "lambda_function_name" {
  description = "Short name for the Lambda function (used in resource naming)."
  type        = string
  default     = "demo-password-reset"
}

variable "lambda_handler" {
  description = "Lambda entrypoint handler (module-level default is index.handler)."
  type        = string
  default     = "index.handler"
}

variable "lambda_runtime" {
  description = "Lambda runtime environment (nodejs14.x, python3.9, etc.)."
  type        = string
  default     = "nodejs14.x"
}

variable "lambda_timeout" {
  description = "Maximum execution time for the Lambda function in seconds."
  type        = number
  default     = 10
}

variable "lambda_sns_topic_name" {
  description = "SNS topic name created for invoking or notifying Lambda."
  type        = string
  default     = "password_reset_topic"
}

variable "dynamodb_table_arn" {
  description = "Optional: ARN of DynamoDB table Lambda may use; leave blank if unused."
  type        = string
  default     = ""
}
