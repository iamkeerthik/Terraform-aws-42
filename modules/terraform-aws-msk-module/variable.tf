variable "cluster_name" {
  type = string

}

# variable "kms_key" {
#     type = string


# }
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

variable "msk_cluster_name" {
  type = string


}
variable "environment" {
  type = string

}

variable "msk_sg_name" {
  type    = string
 
}

# variable "msk_role" {
#   type = string
#   default = "msk-role"

# }

variable "vpc_name" {
  description = "Tag Name to be assigned with VPC"
  type        = string
}

variable "subnet_1" {
  type = string
}

variable "subnet_2" {
  type = string
}