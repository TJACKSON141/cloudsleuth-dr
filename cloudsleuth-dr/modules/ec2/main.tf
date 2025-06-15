terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]

  tags = {
    Name = var.name
  }


  lifecycle {
    ignore_changes = [
      ami
    ]
  }

provisioner "local-exec" {
  when    = create
  command = "echo '${var.name} instance created'"
}

provisioner "local-exec" {
  when    = destroy
  command = "echo '${self.tags["name"]} instance destroyed'"
}
  }


resource "aws_ec2_instance_state" "this" {
  count         = var.is_stopped ? 1 : 0
  instance_id   = aws_instance.this.id
  state         = "stopped"
}
