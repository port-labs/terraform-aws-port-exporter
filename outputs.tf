output "exporter_policy_arn" {
  value = aws_iam_policy.port_aws_exporter_policy.arn
  description = "The ARN of the policy the exporter is assigned with"
}

output "config_bucket_name" {
  value = aws_serverlessapplicationrepository_cloudformation_stack.port_aws_exporter_stack.outputs.ConfigBucketName
  description = "Exporter config bucket name"
}

output "lambda_function_arn" {
  value = aws_serverlessapplicationrepository_cloudformation_stack.port_aws_exporter_stack.outputs.LambdaFunctionARN
  description = "Lambda function ARN"
}

output "lambda_function_iam_role_arn" {
  value = aws_serverlessapplicationrepository_cloudformation_stack.port_aws_exporter_stack.outputs.LambdaFunctionIamRoleARN
  description = "Lambda function execution IAM Role ARN"
}

output "port_credentials_secret_arn" {
  value = aws_serverlessapplicationrepository_cloudformation_stack.port_aws_exporter_stack.outputs.PortCredentialsSecretARN
  description = "Port credentials secret ARN"
}

output "events_queue_arn" {
  value = aws_serverlessapplicationrepository_cloudformation_stack.port_aws_exporter_stack.outputs.EventsQueueARN
  description = "Events queue ARN"
}

output "config_file_object" {
  value = aws_s3_object.config_file_object.id
  description = "S3 object id of the config.json the exporter is using"
}
