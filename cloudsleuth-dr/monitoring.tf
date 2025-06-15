resource "aws_route53_health_check" "web_health" {
  fqdn              = module.ec2_primary.public_dns
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = 3
  request_interval  = 30
}

resource "aws_cloudwatch_metric_alarm" "web_alarm" {
  alarm_name          = "cloudsleuth-failover-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HealthCheckStatus"
  namespace           = "AWS/Route53"
  period              = 60
  statistic           = "Minimum"
  threshold           = 1
  alarm_description   = "Alarm when health check fails"
  actions_enabled     = true
  dimensions = {
    HealthCheckId = aws_route53_health_check.web_health.id
  }
  alarm_actions = [aws_sns_topic.failover.arn]
}

resource "aws_sns_topic" "failover" {
  name = "cloudsleuth-failover-topic"
}
