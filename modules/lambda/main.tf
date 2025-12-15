# Lambda IAM role
resource "aws_iam_role" "lambda_role" {
  name = "${var.lambda_function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = {
    Module = "Lambda"
  }
}

# Attach AWS managed policy for CloudWatch Logs
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Inline policy for S3 / SNS / DynamoDB usage
resource "aws_iam_role_policy" "lambda_inline_policy" {
  name = "${var.lambda_function_name}-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::${var.lambda_bucket_name}",
          "arn:aws:s3:::${var.lambda_bucket_name}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "sns:Publish",
          "sns:Subscribe",
          "sns:ListTopics"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ],
        Resource = var.dynamodb_table_arn != "" ? [var.dynamodb_table_arn,"*"] : ["*"]
      }
    ]
  })
}

# SNS topic used by Lambda (optional trigger)
resource "aws_sns_topic" "lambda_topic" {
  name = var.sns_topic_name

  tags = {
    Module = "Lambda"
  }
}

# Lambda function (deployed from S3)
resource "aws_lambda_function" "lambda" {
  function_name = var.lambda_function_name
  s3_bucket     = var.lambda_bucket_name
  s3_key        = var.lambda_s3_key
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  role          = aws_iam_role.lambda_role.arn
  timeout       = var.lambda_timeout

  environment {
    variables = var.environment_variables
  }

  tags = {
    Module = "Lambda"
  }
}

# Grant SNS permission to invoke the function
resource "aws_lambda_permission" "allow_sns_invoke" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.lambda_topic.arn
}

# Subscribe Lambda to the SNS topic
resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = aws_sns_topic.lambda_topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.lambda.arn
}
