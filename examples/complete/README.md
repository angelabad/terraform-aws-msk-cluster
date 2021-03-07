# Complete MSK Cluster

Configuration in this directory creates complete [AWS MSK Cluster](https://aws.amazon.com/es/msk/)
in your default vpc and its subnets. It includes s3 logs, cloudwatch logs, prometheus exporters,
server properties, ...

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money (Msk Cluster, for example). Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| complete | ../../ |  |

## Resources

| Name |
|------|
| [aws_cloudwatch_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) |
| [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) |
| [aws_subnet_ids](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) |
| [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| bootstrap\_brokers\_tls | A comma separated list of one or more hostname:port pairs of kafka brokers suitable to boostrap connectivity to the kafka cluster. |
| default\_security\_group | Msk cluster default security group id. |
| zookeeper\_connect\_string | A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
