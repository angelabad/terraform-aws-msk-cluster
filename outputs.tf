output "default_security_group" {
  value = aws_security_group.this.id
}

output "arn" {
  value = aws_msk_cluster.this.arn
}

output "bootstrap_brokers" {
  value = aws_msk_cluster.this.bootstrap_brokers
}

output "bootstrap_brokers_tls" {
  value = aws_msk_cluster.this.bootstrap_brokers_tls
}

output "current_version" {
  value = aws_msk_cluster.this.current_version
}

output "encryption_at_rest_kms_key_arn" {
  value = aws_msk_cluster.this.encryption_info.0.encryption_at_rest_kms_key_arn
}

output "zookeeper_connect_string" {
  value = aws_msk_cluster.this.zookeeper_connect_string
}
