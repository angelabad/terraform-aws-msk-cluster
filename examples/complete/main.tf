provider "aws" {
  region = "eu-west-2"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}

resource "aws_s3_bucket" "bucket" {
  bucket_prefix = "msk-broker-logs-bucket"
}

resource "aws_kms_key" "msk-test" {
  description = "Example Key for MSK Cluster Scram Secret Association"
}

resource "aws_secretsmanager_secret" "msk-test" {
  name_prefix = "AmazonMSK_example"
  kms_key_id  = aws_kms_key.msk-test.key_id
}

resource "aws_secretsmanager_secret_version" "msk-test" {
  secret_id     = aws_secretsmanager_secret.msk-test.id
  secret_string = jsonencode({ username = "user", password = "pass" })
}

resource "aws_secretsmanager_secret_policy" "msk-test" {
  secret_arn = aws_secretsmanager_secret.msk-test.arn
  policy     = <<POLICY
{
  "Version" : "2012-10-17",
  "Statement" : [ {
    "Sid": "AWSKafkaResourcePolicy",
    "Effect" : "Allow",
    "Principal" : {
      "Service" : "kafka.amazonaws.com"
    },
    "Action" : "secretsmanager:getSecretValue",
    "Resource" : "${aws_secretsmanager_secret.msk-test.arn}"
  } ]
}
POLICY
}

resource "aws_cloudwatch_log_group" "test" {
  name = "msk_broker_logs"
}

module "complete" {
  source = "../../"

  cluster_name    = "complete"
  instance_type   = "kafka.t3.small"
  number_of_nodes = length(data.aws_subnets.default.ids)
  client_subnets  = data.aws_subnets.default.ids
  kafka_version   = "2.6.2"
  volume_size     = 2000

  extra_security_groups = [data.aws_security_group.default.id]

  client_authentication_sasl_scram_secrets_arns = [aws_secretsmanager_secret.msk-test.arn]
  client_authentication_unauthenticated_enabled = true
  client_authentication_sasl_iam_enabled        = true

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
