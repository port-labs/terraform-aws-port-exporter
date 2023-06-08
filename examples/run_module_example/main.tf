module "port_aws_exporter" {
  source = "../terraform-aws-port-exporter/"
  
  stack_name                       = var.stack_name
  secret_name                      = var.secret_name
  create_bucket                    = var.create_bucket
  bucket_name                      = var.bucket_name
  config_json_file                 = var.config_json_file
  function_name                    = var.function_name
}
