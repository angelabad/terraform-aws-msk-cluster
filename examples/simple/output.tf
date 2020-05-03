output "bootstrap_brokers" {
  description = "A comma separated list of one or more hostname:port pairs of kafka brokers suitable to boostrap connectivity to the kafka cluster."
  value       = module.simple.bootstrap_brokers
}

output "zookeeper_connect_string" {
  description = "A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster."
  value       = module.simple.zookeeper_connect_string
}

output "default_security_group" {
  description = "Msk cluster default security group id."
  value       = module.simple.default_security_group
}
