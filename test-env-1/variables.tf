############____VPC____###################

variable "vpc_name" {
  description = "Tag Name to be assigned with VPC"
  type        = string
  default     = "Suremdm-VPC"
}

variable "cidr" {
  description = "Enter the CIDR range required for VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "igw_tag" {
  description = "Mention Tag needs to be associated with internet gateway"
  type        = string
  default     = "suremdm_igw"
}

variable "nat_tag" {
  description = "Mention Tag needs to be associated with NAT gateway"
  type        = string
  default     = "suremdm_nat"
}

variable "public_subnet_tag_1" {
  description = "Tag for public subnet"
  type        = string
  default     = "suremdm_public_subnet_az_1a"
}

variable "public_subnets_cidr_1" {
  description = "Cidr Blocks"
  type        = string
  default     = "192.168.1.0/24"
}

variable "public_subnet_tag_2" {
  description = "Tag for public subnet"
  type        = string
  default     = "suremdm_public_subnet_az_1b"
}

variable "public_subnets_cidr_2" {
  description = "Cidr Blocks"
  type        = string
  default     = "192.168.2.0/24"
}

variable "map_public_ip_on_launch" {
  description = "It will map the public ip while launching resources"
  type        = bool
  default     = true
}

variable "private_subnet_tag_1" {
  description = "Tag for Private Subnet"
  type        = string
  default     = "suremdm_private_subnet_az_1a"
}

variable "private_subnets_cidr_1" {
  description = "mention the CIDR block for database subnet"
  type        = string
  default     = "192.168.5.0/24"
}

variable "private_subnet_tag_2" {
  description = "Tag for Private Subnet"
  type        = string
  default     = "suremdm_private_subnet_az_1b"
}

variable "private_subnets_cidr_2" {
  description = "mention the CIDR block for database subnet"
  type        = string
  default     = "192.168.6.0/24"
}

variable "default_security_group_name" {
  description = "Enter the name for security group"
  type        = string
  default     = null
}

variable "enable_dhcp_options" {
  description = "Enable DHCP options.. True or False"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS Hostname"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS Support"
  type        = bool
  default     = true
}
variable "enable_ipv6" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block."
  type        = bool
  default     = null
}

variable "public_route_table_tag" {
  description = "Tag name for public route table"
  type        = string
  default     = "suremdm_public_route_table"
}
variable "private_route_table_tag" {
  description = "Tage for private route table"
  type        = string
  default     = "suremdm_private_route_table"
}

variable "manage_default_route_table" {
  description = "Are we managing default route table"
  type        = bool
  default     = null
}

#############______EC2________###############

########################################
## Virtual Machine Module - Variables ##
########################################
variable "app_name" {
  type        = string
  description = "Application name"
  default     = "suremdm"
}

variable "pluto_instance_type" {
  type        = string
  description = "EC2 instance type for pluto Server"
  default     = "t3a.medium"
}

variable "db_instance_type" {
  type        = string
  description = "EC2 instance type for db Server"
  default     = "t3a.medium"
}

variable "windows_associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address to the EC2 instance"
  default     = false
}

variable "windows_root_volume_size" {
  type        = number
  description = "Volumen size of root volumen of Windows Server"
  default     = "30"
}

variable "windows_data_volume_size" {
  type        = number
  description = "Volumen size of data volumen of Windows Server"
  default     = "10"
}

variable "windows_root_volume_type" {
  type        = string
  description = "Volumen type of root volumen of Windows Server. Can be standard, gp3, gp2, io1, sc1 or st1"
  default     = "gp2"
}

variable "windows_data_volume_type" {
  type        = string
  description = "Volumen type of data volumen of Windows Server. Can be standard, gp3, gp2, io1, sc1 or st1"
  default     = "gp2"
}

variable "key_name" {
  type = string

}

# variable "windows_instance_name_1" {
#   type        = string
#   description = "EC2 instance name for Windows Server"
#   default     = "pluto"
# }
# variable "windows_instance_name_2" {
#   type        = string
#   description = "EC2 instance name for Windows Server"
#   default     = "database"
# }


#########________EKS_______###########

variable "cluster_name" {
  default = "Suremdm_cluster"
}

variable "subnet_1" {
  type    = string
  default = "suremdm_public_subnet_az_1a"
}

variable "subnet_2" {
  type    = string
  default = "suremdm_public_subnet_az_1b"
}

variable "asg_desired_size" {
  type    = number
  default = 1
}

variable "asg_max_size" {
  type    = number
  default = 2
}

variable "asg_min_size" {
  type    = number
  default = 1
}

variable "launch_template_id" {
  type = string
}

variable "launch_template_version" {

}

variable "endpoint_private_access" {
  type    = bool
  default = false

}
variable "endpoint_public_access" {
  type    = bool
  default = true

}

variable "eks_version" {
  type    = string
  default = "1.23"

}

variable "node_group_name" {
  type    = string
  default = "suremdm-nodegroup"

}

variable "eks_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "cluster_role_name" {
  type    = string
  default = "suremdm-eks-cluster-role"
}
variable "node_role_name" {
  type    = string
  default = "eks-node-group-role"
}


#############______MSK________#################

variable "msk_cluster_name" {
  type    = string
  default = "suremdm-msk"

}

# variable "kms_key" {
#     type = string
#     default = ""

# }
variable "kafka_version" {
  type = string


}

variable "no_of_nodes" {
  type    = number
  default = 2

}

variable "kafka_intance_type" {
  type    = string
  default = "kafka.t3.small"

}

variable "environment" {
  type    = string
  default = "dev"
}

variable "msk_sg_name" {
  type    = string
  default = "suremdm-msk-sg"
}

variable "eks_sg_name" {
  type = string

}

variable "db_sg_name" {
  type = string
}

variable "pluto_sg_name" {
  type = string
}

variable "volume_size" {
  type = number
}
# variable "msk_role" {
#   type = string
#   default = "msk-role"

# }


variable "sg_rules" {
  type = list(object({
    description    = string,
    cidr_block     = string,
    from_port      = number,
    protocol       = string,
    security_group = string,
    to_port        = number,
  }))


  default = [
    {
      description    = "http"
      cidr_block     = "0.0.0.0/0"
      from_port      = 80
      protocol       = "tcp"
      security_group = ""
      to_port        = 80
    },
  ]
}
