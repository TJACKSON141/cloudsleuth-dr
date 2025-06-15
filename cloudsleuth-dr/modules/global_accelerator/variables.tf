variable "name" {
  type = string
}

variable "primary_endpoint" {
  description = "Endpoint ID for primary (e.g., ALB/NLB/EC2)"
  type        = string
}

variable "secondary_endpoint" {
  description = "Endpoint ID for secondary (e.g., ALB/NLB/EC2)"
  type        = string
}

variable "primary_region" {
  type = string
  default = "eu-west-1"
}

