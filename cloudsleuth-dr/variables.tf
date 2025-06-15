variable "primary_vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "primary_subnet_cidr" {
  type = string
  default = "10.1.1.0/24"
}

variable "secondary_vpc_cidr" {
  type = string
  default = "10.1.0.0/16"       
}

variable "secondary_subnet_cidr" {
  type = string
  default = "10.1.1.0/24"
}

variable "primary_instance_type" {
  default = "t2.micro"
  type = string
}

variable "secondary_instance_type" {
  default = "t2.micro"
  type = string
}
variable "ami_primary" {
  type        = string
  description = "AMI ID for the primary EC2 instance"
  default = "ami-0031a24a5d5c1edb7"
}

variable "ami_secondary" {
  type        = string
  description = "AMI ID for the secondary EC2 instance"
  default = "ami-001e8fc44ac03e5da"
}
variable "primary_is_stopped" {

  description = "Flag to determine if the secondary EC2 instance should be stopped"

  type        = bool

  default     = false

}
variable "secondary_is_stopped" {

  description = "Flag to determine if the secondary EC2 instance should be stopped"

  type        = bool

  default     = false

}
variable "sg_primary_id" {

  description = "The security group ID for the primary environment"

  type        = string

}

variable "lambda_function_name" {
  type        = string
  description = "The name of the Lambda function"
  default     = "FailoverLambda"
}

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
  default = "eu-west-2"
}

variable "secondary_region" {
  type        = string
  description = "The AWS region of the secondary EC2 instance"
  default = "eu-west-1"
}