provider "aws" {
  region = "eu-west-2"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}

resource "aws_s3_bucket" "bucket" {
  bucket_prefix = "msk-broker-logs-bucket"
  acl           = "private"
}

resource "aws_cloudwatch_log_group" "test" {
  name = "msk_broker_logs"
}

module "complete" {
  source = "../../"

  cluster_name    = "complete"
  instance_type   = "kafka.t3.small"
  number_of_nodes = length(data.aws_subnet_ids.default.ids)
  client_subnets  = data.aws_subnet_ids.default.ids
  kafka_version   = "2.6.2"
  volume_size     = 2000

  extra_security_groups = [data.aws_security_group.default.id]

  prometheus_jmx_exporter  = true
  prometheus_node_exporter = true

  s3_logs_bucket = aws_s3_bucket.bucket.id
  s3_logs_prefix = "msk"

  cloudwatch_logs_group = aws_cloudwatch_log_group.test.name

  server_properties = {
    "auto.create.topics.enable"  = "true"
    "default.replication.factor" = "2"
  }

  encryption_in_transit_client_broker = "TLS"
  enhanced_monitoring                 = "PER_BROKER"

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

}
