resource "aws_cloudwatch_metric_alarm" "primary_instance_down" {
  alarm_name          = "PrimaryInstanceDown"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "HealthCheckStatus"
  namespace           = "AWS/Route53"
  period              = "60"
  statistic           = "Minimum"
  threshold           = "0"
  alarm_description   = "Alarm when the primary instance becomes unreachable."

  dimensions = {
    HealthCheckId = aws_route53_health_check.primary_health_check.id
  }

  alarm_actions = [aws_sns_topic.failover_alerts.arn]
    ok_actions    = [aws_sns_topic.failover_alerts.arn]
  }