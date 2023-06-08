resource "aws_iam_policy" "port_aws_exporter_policy" {
  name   = "PortAWSExporterPolicyModule"
  policy = var.lambda_policy_file != null ? file(var.lambda_policy_file) : file("${path.module}/defaults/policy.json")
}

resource "aws_serverlessapplicationrepository_cloudformation_stack" "port_aws_exporter_stack" {
  name           = var.stack_name
  application_id = "arn:aws:serverlessrepo:eu-west-1:185657066287:applications/port-aws-exporter"
  capabilities   = [
    "CAPABILITY_IAM",
    "CAPABILITY_RESOURCE_POLICY",
  ]
  parameters = {
    "CustomIAMPolicyARN"             = aws_iam_policy.port_aws_exporter_policy.arn
    "CustomPortCredentialsSecretARN" = var.custom_port_credentials_secret_arn != null ? var.custom_port_credentials_secret_arn : ""
    "SecretName"                     = var.custom_port_credentials_secret_arn == null ? var.secret_name : ""
    "CreateBucket"                   = var.create_bucket
    "BucketName"                     = var.bucket_name
    "ConfigJsonFileKey"              = var.config_json_file
    "FunctionName"                   = var.function_name
    "ScheduleExpression"             = var.schedule_expression
    "ScheduleState"                  = var.schedule_state
  }
}

## Get the Port credentials from the environment variables
data "env_variable" "port_client_id" {
  name = "PORT_CLIENT_ID"
}
data "env_variable" "port_client_secret" {
  name = "PORT_CLIENT_SECRET"
}

resource "aws_secretsmanager_secret_version" "port_credentials_secret_version" {
  secret_id     = aws_serverlessapplicationrepository_cloudformation_stack.port_aws_exporter_stack.outputs.PortCredentialsSecretARN
  secret_string = jsonencode({
    id           = data.env_variable.port_client_id.value
    clientSecret = data.env_variable.port_client_secret.value
  })
  depends_on = [aws_serverlessapplicationrepository_cloudformation_stack.port_aws_exporter_stack]
}

data "jsonschema_validator" "port_config_validation" {
  document = file(var.config_json_file)
  schema   = "${path.module}/defaults/config_schema.json"
}

resource "aws_s3_object" "config_file_object" {
  bucket       = var.bucket_name
  key          = var.config_json_file
  content_type = "application/json"
  content      = file(var.config_json_file)
  depends_on   = [aws_serverlessapplicationrepository_cloudformation_stack.port_aws_exporter_stack]
}
