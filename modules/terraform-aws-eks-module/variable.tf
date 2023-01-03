variable "cluster_name" {

}

variable "subnet_1" {
  type = string

}

variable "subnet_2" {
  type = string

}

variable "asg_desired_size" {
  type = number

}

variable "asg_max_size" {
  type = number

}

variable "asg_min_size" {
  type = number

}

variable "launch_template_id" {
  type = string
}

variable "launch_template_version" {
}

variable "endpoint_private_access" {
  type = bool

}
variable "endpoint_public_access" {
  type = bool

}

variable "eks_version" {

}

variable "node_group_name" {
  type = string

}

variable "eks_instance_type" {
  type = string
}

variable "cluster_role_name" {
  type = string
}
variable "node_role_name" {
  type = string
}

variable "vpc_name" {
  type = string

}

variable "eks_sg_name" {
  type = string

}