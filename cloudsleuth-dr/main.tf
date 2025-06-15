module "vpc_primary" {
  source    = "./modules/vpc"
  providers = { aws = aws.primary }
  name        = "vpc-primary"
  region      = "eu-west-2"
  vpc_cidr    = var.primary_vpc_cidr
  primary_subnet_cidr = var.primary_subnet_cidr
  secondary_subnet_cidr = var.secondary_subnet_cidr
}

module "vpc_secondary" {
  source    = "./modules/vpc"
  providers = { aws = aws.secondary }
  name        = "vpc-secondary"
  region      = "eu-west-1"
  vpc_cidr    = var.secondary_vpc_cidr
  primary_subnet_cidr = var.primary_subnet_cidr
  secondary_subnet_cidr = var.secondary_subnet_cidr
}

module "sg_primary" {
  source    = "./modules/security_group"
  providers = { aws = aws.primary }

  vpc_id    = module.vpc_primary.vpc_id
  name      = "primary_environment"
  subnet_id = module.vpc_primary.public_subnet_id
  sg_id     = var.sg_primary_id
  ami       = var.ami_primary
}

module "sg_secondary" {
  source    = "./modules/security_group"
  providers = { aws = aws.secondary }

  vpc_id     = module.vpc_secondary.vpc_id
  name       = "secondary-environment"
  ami        = var.ami_secondary
  sg_id      = var.sg_primary_id
  subnet_id  = module.vpc_secondary.public_subnet_id
}

module "ec2_primary" {
  source        = "./modules/ec2"
  providers     = { aws = aws.primary }
  name          = "ec2-primary"
  ami           = var.ami_primary
  instance_type = var.primary_instance_type
  subnet_id     = module.vpc_primary.public_subnet_id
  sg_id         = module.sg_primary.id
  is_stopped    = var.primary_is_stopped
}
module "ec2_secondary" {
  source        = "./modules/ec2"
  providers     = { aws = aws.secondary }
  name          = "ec2-secondary"
  ami           = var.ami_secondary
  instance_type = var.secondary_instance_type
  subnet_id     = module.vpc_secondary.public_subnet_id
  sg_id         = module.sg_secondary.id
  is_stopped    = var.secondary_is_stopped
}


module "global_accelerator" {
  source             = "./modules/global_accelerator"
  name               = "cloudsleuth-global-accelerator"
  primary_endpoint   = module.ec2_primary.instance_id
  secondary_endpoint = module.ec2_secondary.instance_id
  primary_region     = "eu-west-2"
  
}
resource "aws_sns_topic" "failover-alerts" {
  name = "failover-alerts"
}
resource "aws_lambda_function" "failover_lambda" {
  function_name = var.lambda_function_name
  runtime       = "python3.9" # Use "nodejs14.x" for Node.js
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  filename      = "failover_lambda.zip" # Path to the zipped Lambda function code

  environment {
    variables = {
      primary_instance_id   = var.primary_instance_id
      secondary_instance_id = var.secondary_instance_id
      primary_region        = var.primary_region
      secondary_region      = var.secondary_region
    }
  }
}
resource "aws_lambda_permission" "allow_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.failover_lambda.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.failover-alerts.arn
}

module "lambda_failover" {
  source              = "./modules/lambda"
  primary_instance_id = module.ec2_primary.instance_id
  secondary_instance_id = module.ec2_secondary.instance_id
  primary_region      = "eu-west-2"
  secondary_region    = "eu-west-1"
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

module "aws_ssm_document" {
  source = "./modules/ssm"
  document_name = "FailoverAutomationDocument"
}
