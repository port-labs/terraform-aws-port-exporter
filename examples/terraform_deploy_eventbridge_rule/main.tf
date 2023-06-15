resource "aws_cloudformation_stack" "port-aws-exporter-event-rules" {
  name = "port-aws-exporter-event-rules-module"

  parameters = {
    PortAWSExporterStackName = "serverlessrepo-port-aws-stack"
  }

  template_body = file("../../templates/event_rules.yaml")
}

output "eventbridge_rule_id" {
  value = aws_cloudformation_stack.port-aws-exporter-event-rules.id
}