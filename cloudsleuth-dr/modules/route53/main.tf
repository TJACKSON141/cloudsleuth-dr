resource "aws_route53_health_check" "primary" {
  fqdn              = module.ec2_primary.public_ip
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = 3
  request_interval  = 30

  tags = {
    Name = "tf-test-health-check"
  }
}

