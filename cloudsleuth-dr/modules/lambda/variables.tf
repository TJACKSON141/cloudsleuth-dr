variable "primary_instance_id" {
  type        = string
  description = "The instance ID of the primary EC2 instance"
}

variable "secondary_instance_id" {
  type        = string
  description = "The instance ID of the secondary EC2 instance"
}

variable "primary_region" {
  type        = string
  description = "The AWS region of the primary EC2 instance"
}

variable "secondary_region" {
  type        = string
  description = "The AWS region of the secondary EC2 instance"
}

variable "lambda_function_name" {
  type        = string
  description = "The name of the Lambda function"
  default     = "FailoverLambda"
}

variable "sns_topic_name" {
  type        = string
  description = "The name of the SNS topic"
  default     = "FailoverTopic"
}