resource "aws_s3_bucket" "webapp" {
  bucket = var.webapp_bucket_name

  tags = {
    Purpose = "Web Application Hosting"
    Module  = "S3"
  }
}

resource "aws_s3_bucket" "codedeploy" {
  bucket = var.codedeploy_bucket_name

  tags = {
    Purpose = "CodeDeploy Artifacts"
    Module  = "S3"
  }
}

resource "aws_s3_bucket" "lambda" {
  bucket = var.lambda_bucket_name

  tags = {
    Purpose = "Lambda Deployment Packages"
    Module  = "S3"
  }
}
