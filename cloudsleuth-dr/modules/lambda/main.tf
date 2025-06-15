resource "aws_lambda_function" "failover_lambda" {
  function_name = var.lambda_function_name
  runtime       = "python3.9"
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  filename      = "failover_lambda.zip"

  environment {
    variables = {
      primary_instance_id   = var.primary_instance_id
      secondary_instance_id = var.secondary_instance_id
      primary_region        = var.primary_region
      secondary_region      = var.secondary_region
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "LambdaFailoverRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "LambdaFailoverPolicy"
  description = "Policy for Lambda to execute SSM automation"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:StartAutomationExecution"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_sns_topic" "failover_topic" {
  name = "FailoverTopic"
}

resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = aws_sns_topic.failover_topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.failover_lambda.arn
}

resource "aws_lambda_permission" "allow_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.failover_lambda.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.failover_topic.arn
}
