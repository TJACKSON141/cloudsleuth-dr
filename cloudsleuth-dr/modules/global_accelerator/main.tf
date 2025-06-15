resource "aws_globalaccelerator_accelerator" "this" {
  name    = var.name
  enabled = true
}

resource "aws_globalaccelerator_listener" "this" {
  accelerator_arn = aws_globalaccelerator_accelerator.this.id
  protocol        = "TCP"

  port_range {
    from_port = 80
    to_port   = 80
  }
}

resource "aws_globalaccelerator_endpoint_group" "primary" {
  listener_arn = aws_globalaccelerator_listener.this.id

  endpoint_configuration {
    endpoint_id = var.primary_endpoint
    weight      = 128
    client_ip_preservation_enabled = true
  }

  health_check_port     = 80
  health_check_protocol = "TCP"
  }

resource "aws_globalaccelerator_endpoint_group" "secondary" {
  listener_arn = aws_globalaccelerator_listener.this.id

  endpoint_configuration {
    endpoint_id = var.secondary_endpoint
    weight      = 0
  }

  health_check_port     = 80
  health_check_protocol = "TCP"
 
}