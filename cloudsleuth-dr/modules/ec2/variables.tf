variable "name" {
  type = string
  description = "Name of the EC2 instance"
}

variable "ami" {
  type = string
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  type = string
  description = "Instance type for the EC2 instance"
}

variable "subnet_id" {
  type = string
  description = "Subnet ID where the EC2 instance will be launched"
}

variable "sg_id" {
  type = string
  description = "Security group ID for the EC2 instance"
}


variable "is_stopped" {
  type        = bool
  description = "Whether to stop the instance on creation (for pilot light)"
}
