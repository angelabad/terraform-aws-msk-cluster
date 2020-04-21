locals {
  server_properties = join("\n", [for k, v in var.server_properties : format("%s = %s", k, v)])
}

terraform {
  required_version = ">= 0.12"
  required_providers {
    aws    = ">= 2.51"
    random = ">= 2.1"
  }
}

data "aws_subnet" "this" {
  id = var.client_subnets[0]
}

resource "aws_security_group" "this" {
  name_prefix = "${var.cluster_name}-"
  vpc_id      = data.aws_subnet.this.vpc_id
}

resource "aws_security_group_rule" "msk-plain" {
  from_port         = 9092
  to_port           = 9092
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  self              = true
}

resource "aws_security_group_rule" "msk-tls" {
  from_port         = 9094
  to_port           = 9094
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  self              = true
}

resource "aws_security_group_rule" "zookeeper" {
  from_port         = 2181
  to_port           = 2181
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  self              = true
}

resource "random_id" "configuration" {
  prefix      = "${var.cluster_name}-"
  byte_length = 8

  keepers = {
    server_properties = local.server_properties
  }
}

resource "aws_msk_configuration" "this" {
  kafka_versions    = [var.kafka_version]
  name              = random_id.configuration.dec
  server_properties = local.server_properties
}

resource "aws_msk_cluster" "this" {
  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_nodes

  broker_node_group_info {
    client_subnets  = var.client_subnets
    ebs_volume_size = var.volume_size
    instance_type   = var.instance_type
    security_groups = concat(aws_security_group.this.*.id, var.extra_security_groups)
  }

  configuration_info {
    arn      = aws_msk_configuration.this.arn
    revision = aws_msk_configuration.this.latest_revision
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = var.encryption_at_rest_kms_key_arn
    encryption_in_transit {
      client_broker = var.encryption_in_transit_client_broker
      in_cluster    = var.encryption_in_transit_in_cluster
    }
  }

  enhanced_monitoring = var.enhanced_monitoring

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = var.prometheus_jmx_exporter
      }
      node_exporter {
        enabled_in_broker = var.prometheus_node_exporter
      }
    }
  }

  tags = var.tags
}
