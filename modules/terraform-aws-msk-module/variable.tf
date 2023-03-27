variable "name" {
  description = "Tag Name to be assigned with resources"
  type        = string

}
variable "kafka_version" {
  type = string
}

variable "no_of_nodes" {
  type = number
}

variable "kafka_intance_type" {
  type = string
}

variable "volume_size" {
  type = number
}

variable "open_monitoring" {
  type = bool
}

variable "aws_msk_configuration_arn" {
  type = string
}

variable "config_revision" {
  type = number
}