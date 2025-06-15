variable "name" {
  type = string
  description = "Name of the VPC"
}

variable "region" {
  type = string
  description = "Region for the VPC"
  default = "eu-west-1"
}

variable "vpc_cidr" {
  type = string
  description = "CIDR block for the VPC"
}

variable "primary_subnet_cidr" {
  type = string
  description = "CIDR block for the subnet"

}
variable "secondary_subnet_cidr" {

  description = "CIDR block for the secondary public subnet"
  type        = string

}

