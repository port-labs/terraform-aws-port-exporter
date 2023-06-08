# Port AWS Exporter Module

This Terraform module deploys the Port AWS Exporter in your AWS account.

## Prerequisites

Before using this module, make sure you have completed the following prerequisites:

1. Install and configure the AWS Command Line Interface (CLI) on your local machine. 
   
   Refer to the [AWS CLI Documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html) for instructions.
2. Export the `PORT_CLIENT_ID` and `PORT_CLIENT_SECRET` environment variables with your [Port credentials](https://docs.getport.io/build-your-software-catalog/sync-data-to-catalog/api/#find-your-port-credentials). These credentials are necessary for the module to authenticate with Port.

   You can export the variables using the following commands in your terminal:

   ```bash
   export PORT_CLIENT_ID="your-port-client-id"
   export PORT_CLIENT_SECRET="your-port-client-secret"


## Getting Started

### Using the Module

To use this module, include the following code in your Terraform configuration:

```terraform
module "port_aws_exporter" {
  source = "git::https://github.com/port-labs/terraform-aws-port-exporter.git"
  
  stack_name           = var.stack_name
  secret_name          = var.secret_name
  create_bucket        = var.create_bucket
  bucket_name          = var.bucket_name
  config_json_file     = var.config_json_file
  function_name        = var.function_name
}
```
### Running Terraform
After configuring the module, run the following Terraform commands:

```bash
terraform init        # Initialize the Terraform configuration.
terraform plan --var-file=path/to/variables.tfvars        # Preview the changes to be applied, providing the path to your variables file using the --var-file option.
terraform apply --var-file=path/to/variables.tfvars        # Apply the changes and provision the resources in your AWS account, providing the path to your variables file using the --var-file option.
```


### Variables
The following variables should be configured for this module:

- `stack_name`: The name of the CloudFormation stack.
- `secret_name`: The name of the secret for storing credentials.
- `create_bucket`: Specifies whether to create an S3 bucket.
- `bucket_name`: The name of the S3 bucket.
- `config_json_file`: The path to the configuration JSON file.
- `function_name`: The name of the AWS Lambda function.

> To see all possible parameters, see [`Variables.tf`](./variables.tf).

### After Installation 
* You should see your the Port exporter in your CloudFormation Stacks with the name: 

   `serverlessrepo-<your_stack_name>`


* To remove the resources when they are no longer needed use the `destroy` command:

   ```bash
   terraform destroy --var-file=path/to/variables.tfvars
   ```


## Further Information
See the [examples](./examples/) folder for example about deploying the module and deploying EventBridge rules for your exporter.
