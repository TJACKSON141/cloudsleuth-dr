resource "aws_ssm_document" "failover" {
  name          = "FailoverAutomationDocument"
  document_type = "Automation"
  content       = file("${path.module}/failover_document.json")
  document_format = "JSON"
}
