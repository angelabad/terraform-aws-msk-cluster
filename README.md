# AWS Msk Kafka Cluster

[![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/angelabad/terraform-aws-msk-cluster)](https://github.com/angelabad/terraform-aws-msk-cluster/releases)
[![Msk Kafka Cluster](https://circleci.com/gh/angelabad/terraform-aws-msk-cluster.svg?style=shield)](https://app.circleci.com/pipelines/github/angelabad/terraform-aws-msk-cluster)

Terraform module which creates [Msk Kafka Cluster](https://aws.amazon.com/msk/) on AWS.

These types of resources are supported:

* [Aws Msk Cluster](https://www.terraform.io/docs/providers/aws/r/msk_cluster.html)
* [Aws Msk Configuration](https://www.terraform.io/docs/providers/aws/r/msk_configuration.html)

## Features

This module create a fully featured [Msk Kafka Cluster](https://aws.amazon.com/msk/) on Aws. You could configure monitoring, encryption, server
options, etc...

## Usage

```hcl
module "msk-cluster" {
  source  = "angelabad/msk-cluster/aws"

  cluster_name    = "kafka"
  instance_type   = "kafka.t3.small"
  number_of_nodes = 2
  client_subnets  = ["subnet-0ab97cbe1bd1406c2", "subnet-0d6cbf60360dbac64"]
  kafka_version   = "2.6.2"

  extra_security_groups = ["sg-019fc0f7d26f6c70f"]

  enhanced_monitoring = "PER_BROKER"

  s3_logs_bucket = aws_s3_bucket.logs.id
  s3_logs_prefix = "msklogs"

  prometheus_jmx_exporter  = true
  prometheus_node_exporter = true

  server_properties = {
    "auto.create.topics.enable"  = "true"
    "default.replication.factor" = "2"
  }

  encryption_in_transit_client_broker = "TLS"

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.39 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.39 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_msk_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_cluster) | resource |
| [aws_msk_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_configuration) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.jmx-exporter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.msk-plain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.msk-tls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.node_exporter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.zookeeper-plain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.zookeeper-tls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [random_id.configuration](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_subnets"></a> [client\_subnets](#input\_client\_subnets) | A list of subnets to connect to in client VPC | `list(string)` | n/a | yes |
| <a name="input_cloudwatch_logs_group"></a> [cloudwatch\_logs\_group](#input\_cloudwatch\_logs\_group) | Name of the Cloudwatch Log Group to deliver logs to. | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the MSK cluster. | `string` | n/a | yes |
| <a name="input_encryption_at_rest_kms_key_arn"></a> [encryption\_at\_rest\_kms\_key\_arn](#input\_encryption\_at\_rest\_kms\_key\_arn) | You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest. If no key is specified, an AWS managed KMS ('aws/msk' managed service) key will be used for encrypting the data at rest. | `string` | `""` | no |
| <a name="input_encryption_in_transit_client_broker"></a> [encryption\_in\_transit\_client\_broker](#input\_encryption\_in\_transit\_client\_broker) | Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS\_PLAINTEXT, and PLAINTEXT. Default value is TLS\_PLAINTEXT. | `string` | `"TLS_PLAINTEXT"` | no |
| <a name="input_encryption_in_transit_in_cluster"></a> [encryption\_in\_transit\_in\_cluster](#input\_encryption\_in\_transit\_in\_cluster) | Whether data communication among broker nodes is encrypted. Default value: true. | `bool` | `true` | no |
| <a name="input_enhanced_monitoring"></a> [enhanced\_monitoring](#input\_enhanced\_monitoring) | Specify the desired enhanced MSK CloudWatch monitoring level to one of three monitoring levels: DEFAULT, PER\_BROKER, PER\_TOPIC\_PER\_BROKER or PER\_TOPIC\_PER\_PARTITION. See [Monitoring Amazon MSK with Amazon CloudWatch](https://docs.aws.amazon.com/msk/latest/developerguide/monitoring.html). | `string` | `"DEFAULT"` | no |
| <a name="input_extra_security_groups"></a> [extra\_security\_groups](#input\_extra\_security\_groups) | A list of extra security groups to associate with the elastic network interfaces to control who can communicate with the cluster. | `list(string)` | `[]` | no |
| <a name="input_firehose_logs_delivery_stream"></a> [firehose\_logs\_delivery\_stream](#input\_firehose\_logs\_delivery\_stream) | Name of the Kinesis Data Firehose delivery stream to deliver logs to. | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Specify the instance type to use for the kafka brokers. e.g. kafka.m5.large. | `string` | n/a | yes |
| <a name="input_kafka_version"></a> [kafka\_version](#input\_kafka\_version) | Specify the desired Kafka software version. | `string` | n/a | yes |
| <a name="input_number_of_nodes"></a> [number\_of\_nodes](#input\_number\_of\_nodes) | The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets. | `number` | n/a | yes |
| <a name="input_prometheus_jmx_exporter"></a> [prometheus\_jmx\_exporter](#input\_prometheus\_jmx\_exporter) | Indicates whether you want to enable or disable the JMX Exporter. | `bool` | `false` | no |
| <a name="input_prometheus_node_exporter"></a> [prometheus\_node\_exporter](#input\_prometheus\_node\_exporter) | Indicates whether you want to enable or disable the Node Exporter. | `bool` | `false` | no |
| <a name="input_s3_logs_bucket"></a> [s3\_logs\_bucket](#input\_s3\_logs\_bucket) | Name of the S3 bucket to deliver logs to. | `string` | `""` | no |
| <a name="input_s3_logs_prefix"></a> [s3\_logs\_prefix](#input\_s3\_logs\_prefix) | Prefix to append to the folder name. | `string` | `""` | no |
| <a name="input_server_properties"></a> [server\_properties](#input\_server\_properties) | A map of the contents of the server.properties file. Supported properties are documented in the [MSK Developer Guide](https://docs.aws.amazon.com/msk/latest/developerguide/msk-configuration-properties.html). | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | The size in GiB of the EBS volume for the data drive on each broker node. | `number` | `1000` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Amazon Resource Name (ARN) of the MSK cluster. |
| <a name="output_bootstrap_brokers"></a> [bootstrap\_brokers](#output\_bootstrap\_brokers) | A comma separated list of one or more hostname:port pairs of kafka brokers suitable to boostrap connectivity to the kafka cluster. Only contains value if client\_broker encryption in transit is set o PLAINTEXT or TLS\_PLAINTEXT. |
| <a name="output_bootstrap_brokers_tls"></a> [bootstrap\_brokers\_tls](#output\_bootstrap\_brokers\_tls) | A comma separated list of one or more DNS names (or IPs) and TLS port pairs kafka brokers suitable to boostrap connectivity to the kafka cluster. Only contains value if client\_broker encryption in transit is set to TLS\_PLAINTEXT or TLS. |
| <a name="output_current_version"></a> [current\_version](#output\_current\_version) | Current version of the MSK Cluster used for updates, e.g. K13V1IB3VIYZZH |
| <a name="output_default_security_group"></a> [default\_security\_group](#output\_default\_security\_group) | Msk cluster default security group id. |
| <a name="output_encryption_at_rest_kms_key_arn"></a> [encryption\_at\_rest\_kms\_key\_arn](#output\_encryption\_at\_rest\_kms\_key\_arn) | The ARN of the KMS key used for encryption at rest of the broker data volumes. |
| <a name="output_zookeeper_connect_string"></a> [zookeeper\_connect\_string](#output\_zookeeper\_connect\_string) | A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by [Angel Abad](https://angelabad.me)

## License

Apache 2 Licensed. See LICENSE for full details
