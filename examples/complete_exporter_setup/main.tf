terraform {
  required_providers {
    port-labs = {
          source  = "port-labs/port-labs"
          version = "~> 0.10.3"
    }
  }
}

# Create Blueprints
resource "port-labs_blueprint" "region" {
  title      = "AWS Region"
  icon       = "AWS"
  identifier = "aws_region"

  properties {
    title = "Link"
    identifier = "link"
    type = "string"
    format = "url"
  }
}

module "port_dynamodb_table" {
  source = "/Users/matarpeles/Work/terraform-aws-port-exporter/modules/port_dynamodb_table"
}

module "port_ecs_service" {
  source = "/Users/matarpeles/Work/terraform-aws-port-exporter/modules/port_ecs_service"
}

module "port_lambda_function" {
  source = "/Users/matarpeles/Work/terraform-aws-port-exporter/modules/port_lambda_function"
}

module "port_rds_db_instance" {
  source = "/Users/matarpeles/Work/terraform-aws-port-exporter/modules/port_rds_db_instance"
}

module "port_s3_bucket" {
  source = "/Users/matarpeles/Work/terraform-aws-port-exporter/modules/port_s3_bucket"
}

module "port_sns_topic" {
  source = "/Users/matarpeles/Work/terraform-aws-port-exporter/modules/port_sns_topic"
}

module "port_sqs_topic" {
  source = "/Users/matarpeles/Work/terraform-aws-port-exporter/modules/port_sqs_queue"
}


## Create Iam policy and Mapping configuration
#locals {
#  combined_configs = [
#    module.port_ecs_service.exporter_config,
#    module.port_dynamodb_table.exporter_config,
#    module.port_lambda_function.exporter_config,
#    module.port_rds_db_instance.exporter_config,
#    module.port_s3_bucket.exporter_config,
#    module.port_sqs_topic.exporter_config,
#    module.port_sns_topic.exporter_config,
#  ]
#
#  combined_actions = flatten([
#      module.port_ecs_service.iam_policy,
#      module.port_dynamodb_table.iam_policy,
#      module.port_lambda_function.iam_policy,
#      module.port_rds_db_instance.iam_policy,
#      module.port_s3_bucket.iam_policy,
#      module.port_sqs_topic.iam_policy,
#      module.port_sns_topic.iam_policy,
#    ])
#
#  merged_policy = {
#    Version   = "2012-10-17"
#    Statement = [
#      {
#        Effect   = "Allow"
#        Action   = local.combined_actions
#        Resource = "*"
#      }
#    ]
#  }
#
#  merged_config = {
#    resources = local.combined_configs
#  }
#}
#
#
## Deploy the AWS exporter application
#module "port_aws_exporter" {
#  source = "/Users/matarpeles/Work/terraform-aws-port-exporter"
#
#  stack_name    = var.stack_name
#  secret_name   = var.secret_name
#  create_bucket = var.create_bucket
#  bucket_name   = var.bucket_name
#  function_name = var.function_name
#  config_json   = jsonencode(local.merged_config)
#  lambda_policy = jsonencode(local.merged_policy)
#}
