resource "aws_iam_role" "ssm_automation_role" {
  name = "SSMAutomationFailoverRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ssm.amazonaws.com"
      }
    }]
  })
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_policy_attachment" "ssm_full_access" {
  name       = "ssm_automation_access"
  roles      = [aws_iam_role.ssm_automation_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}
