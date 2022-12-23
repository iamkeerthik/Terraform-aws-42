variable "cluster_name" {
  type = string
  default = "suremdm-cluster"
}

variable "kms_key" {
    type = string
    default = ""
  
}
variable "kafka_version" {
  type = string
  default = "2.6.0"
  
}

variable "no_of_nodes" {
  type = number
  default = 2
  
}

variable "kafka_intance_type" {
  type = string
  default = "kafka.t3.small"
  
}

variable "msk_cluster_name" {
  type = string
  default = "suremdm-msk"
  
}
variable "environment" {
  type = string
  default = "dev"  
}

variable "msk_security_group_name" {
  type = string
  default = "suremdm-msk-sg"
}

# variable "msk_role" {
#   type = string
#   default = "msk-role"
  
# }

variable "vpc_name" {
  description = "Tag Name to be assigned with VPC"
  type        = string
  default     = "Suremdm-VPC"
}

variable "subnet_1" {
  type    = string
  default = "suremdm_public_subnet_az_1a"
}

variable "subnet_2" {
  type    = string
  default = "suremdm_public_subnet_az_1b"
}