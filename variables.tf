variable "cluster_name" {
  type = string
}

variable "kafka_version" {
  type = string
}

variable "nodes" {
  type = number
}

variable "subnets" {
  type = list(string)
}

variable "volume_size" {
  type    = number
  default = 1000
}

variable "instance_type" {
  type = string
}

variable "extra_security_groups" {
  type    = list(string)
  default = []
}

variable "prometheus_jmx_exporter" {
  type    = bool
  default = false
}

variable "prometheus_node_exporter" {
  type    = bool
  default = false
}

variable "server_properties" {
  type    = map(string)
  default = {}
}

variable "encryption_at_rest_kms_key_arn" {
  type    = string
  default = null
}

variable "encryption_in_transit_client_broker" {
  type    = string
  default = "TLS"
}

variable "encryption_in_transit_in_cluster" {
  type    = bool
  default = true
}
