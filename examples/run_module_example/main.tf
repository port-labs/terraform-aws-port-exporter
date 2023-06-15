module "port_aws_exporter" {
  source = "git::https://github.com/port-labs/terraform-aws-port-exporter.git"
  
  stack_name                       = var.stack_name
  secret_name                      = var.secret_name
  create_bucket                    = var.create_bucket
  bucket_name                      = var.bucket_name
  config_json_file                 = var.config_json
  function_name                    = var.function_name
}
