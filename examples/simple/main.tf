provider "aws" {
  region = "eu-west-2"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

module "simple" {
  source = "../../"

  cluster_name    = "simple"
  client_subnets  = data.aws_subnet_ids.default.ids
  number_of_nodes = length(data.aws_subnet_ids.default.ids)
  instance_type   = "kafka.t3.small"
  kafka_version   = "2.6.2"
}
