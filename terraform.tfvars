# --------------------------------------------------
# Global / Region
# --------------------------------------------------
region = "us-east-1"

# --------------------------------------------------
# VPC Configuration
# --------------------------------------------------
vpc_name = "demo-vpc"
vpc_cidr = "10.0.0.0/16"

# --------------------------------------------------
# Public Subnets (ALB, NAT Gateway, Internet-facing)
# --------------------------------------------------
public_subnet1_cidr = "10.0.1.0/24"
public_subnet2_cidr = "10.0.2.0/24"
public_subnet3_cidr = "10.0.3.0/24"

# --------------------------------------------------
# Private Subnets (Application, RDS, Lambda access)
# --------------------------------------------------
private_subnet1_cidr = "10.0.11.0/24"
private_subnet2_cidr = "10.0.12.0/24"
private_subnet3_cidr = "10.0.13.0/24"

# --------------------------------------------------
# Availability Zones
# --------------------------------------------------
az1 = "us-east-1a"
az2 = "us-east-1b"
az3 = "us-east-1c"

# --------------------------------------------------
# EC2 / Auto Scaling
# --------------------------------------------------
ami_id   = "ami-0c02fb55956c7d316" # Amazon Linux 2 (us-east-1)
key_name = "demo-keypair"

# --------------------------------------------------
# S3 Buckets
# --------------------------------------------------
webapp_bucket_name     = "demo-webapp-assets"
codedeploy_bucket_name = "demo-codedeploy-artifacts"
lambda_bucket_name     = "demo-lambda-packages"

# --------------------------------------------------
# SSL / Domain / Route53
# --------------------------------------------------
domain_name    = "app.example.com"
hosted_zone_id = "Z123456ABCDEFG"

# cert_arn uses default unless overridden

# --------------------------------------------------
# RDS Configuration
# --------------------------------------------------
rds_username   = "dbadmin"
rds_password   = "ChangeMeStrongPassword123!"
rds_db_name    = "demo_db"
rds_identifier = "demo-rds"

# --------------------------------------------------
# AWS Account
# --------------------------------------------------
account_num = ""

# --------------------------------------------------
# Lambda Configuration
# --------------------------------------------------
lambda_s3_key        = "password-reset/password-reset.zip"
lambda_function_name = "demo-password-reset"
lambda_handler       = "index.handler"
lambda_runtime       = "nodejs14.x"
lambda_timeout       = 10

# --------------------------------------------------
# SNS
# --------------------------------------------------
lambda_sns_topic_name = "password_reset_topic"

# --------------------------------------------------
# Optional DynamoDB
# --------------------------------------------------
dynamodb_table_arn = ""
