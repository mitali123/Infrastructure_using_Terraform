provider "aws" {
  region = var.region
  profile = "default"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr               = var.vpc_cidr
  vpc_name               = var.vpc_name

  public_subnet1_cidr    = var.public_subnet1_cidr
  public_subnet2_cidr    = var.public_subnet2_cidr
  public_subnet3_cidr    = var.public_subnet3_cidr

  private_subnet1_cidr   = var.private_subnet1_cidr
  private_subnet2_cidr   = var.private_subnet2_cidr
  private_subnet3_cidr   = var.private_subnet3_cidr

  az1 = var.az1
  az2 = var.az2
  az3 = var.az3
}

module "s3" {
  source = "./modules/s3"
  webapp_bucket_name     = var.webapp_bucket_name
  codedeploy_bucket_name = var.codedeploy_bucket_name
  lambda_bucket_name     = var.lambda_bucket_name
}

module "iam" {
  source = "./modules/iam"
  account_num = var.account_num
}

module "ec2" {
  source = "./modules/ec2"

  ami_id      = var.ami_id
  key_name    = var.key_name
  subnet_id   = module.vpc.public_subnet_1_id
  vpc_id      = module.vpc.vpc_id
}

module "rds" {
  source = "./modules/rds"

  db_name     = var.rds_db_name
  username    = var.rds_username
  password    = var.rds_password
  identifier  = var.rds_identifier
  subnet_ids  = module.vpc.private_subnet_ids
  vpc_id      = module.vpc.vpc_id
}

module "alb" {
  source = "./modules/alb"

  public_subnet_ids = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id
  instance_id       = module.ec2.instance_id
  cert_arn          = var.cert_arn
}


module "route53" {
  source = "./modules/route53"

  hosted_zone_id = var.hosted_zone_id
  record_name    = var.domain_name

  alb_dns_name = module.alb.alb_dns
  alb_zone_id  = module.alb.alb_zone_id
}

module "lambda" {
  source = "./modules/lambda"

  lambda_bucket_name      = var.lambda_bucket_name
  lambda_s3_key           = var.lambda_s3_key
  lambda_function_name    = var.lambda_function_name
  lambda_handler          = var.lambda_handler
  lambda_runtime          = var.lambda_runtime
  lambda_timeout          = var.lambda_timeout
  environment_variables   = {
    DOMAIN_NAME = var.domain_name
    STAGE       = var.env_stage
  }
  sns_topic_name          = var.lambda_sns_topic_name
  dynamodb_table_arn      = var.dynamodb_table_arn
}
