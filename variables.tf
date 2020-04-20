variable "cluster_name" {
  description = "Name of the MSK cluster."
  type        = string
}

variable "kafka_version" {
  description = "Specify the desired Kafka software version."
  type        = string
}

variable "number_of_nodes" {
  description = "The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets."
  type        = number
}

variable "client_subnets" {
  description = "A list of subnets to connect to in client VPC"
  type        = list(string)
}

variable "volume_size" {
  description = "The size in GiB of the EBS volume for the data drive on each broker node."
  type        = number
  default     = 1000
}

variable "instance_type" {
  description = "Specify the instance type to use for the kafka brokers. e.g. kafka.m5.large."
  type        = string
}

variable "extra_security_groups" {
  description = "A list of extra security groups to associate with the elastic network interfaces to control who can communicate with the cluster."
  type        = list(string)
  default     = []
}

variable "prometheus_jmx_exporter" {
  description = "Indicates whether you want to enable or disable the JMX Exporter."
  type        = bool
  default     = false
}

variable "prometheus_node_exporter" {
  description = "Indicates whether you want to enable or disable the Node Exporter."
  type        = bool
  default     = false
}

variable "server_properties" {
  description = "A map of the contents of the server.properties file. Supported properties are documented in the [MSK Developer Guide](https://docs.aws.amazon.com/msk/latest/developerguide/msk-configuration-properties.html)."
  type        = map(string)
  default     = {}
}

variable "encryption_at_rest_kms_key_arn" {
  description = "You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest. If no key is specified, an AWS managed KMS ('aws/msk' managed service) key will be used for encrypting the data at rest."
  type        = string
  default     = null
}

variable "encryption_in_transit_client_broker" {
  description = "Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT. Default value is TLS_PLAINTEXT when encryption_in_transit block defined, but TLS when encryption_in_transit block omitted."
  type        = string
  default     = "TLS"
}

variable "encryption_in_transit_in_cluster" {
  description = "Whether data communication among broker nodes is encrypted. Default value: true."
  type        = bool
  default     = true
}
