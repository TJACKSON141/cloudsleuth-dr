output "lambda_function_name" {
  value = aws_lambda_function.failover_lambda.function_name
}

output "arn" {
  value = aws_lambda_function.failover_lambda.arn
}