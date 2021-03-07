# Simple MSK Cluster

Configuration in this directory creates simple [AWS MSK Cluster](https://aws.amazon.com/es/msk/)
in your default vpc and its subnets.

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
| simple | ../../ |  |

## Resources

| Name |
|------|
| [aws_subnet_ids](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) |
| [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| bootstrap\_brokers | A comma separated list of one or more hostname:port pairs of kafka brokers suitable to boostrap connectivity to the kafka cluster. |
| default\_security\_group | Msk cluster default security group id. |
| zookeeper\_connect\_string | A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
