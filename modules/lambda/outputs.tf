output "lambda_function_name" {
  value = aws_lambda_function.lambda.function_name
}

output "lambda_function_arn" {
  value = aws_lambda_function.lambda.arn
}

output "lambda_sns_topic_arn" {
  value = aws_sns_topic.lambda_topic.arn
}
