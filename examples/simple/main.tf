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

module "simple" {
  source = "../../"

  cluster_name    = "simple"
  client_subnets  = data.aws_subnets.default.ids
  number_of_nodes = length(data.aws_subnets.default.ids)
  instance_type   = "kafka.t3.small"
  kafka_version   = "2.6.2"
}
