############____VPC____###################

variable "vpc_name" {
  description = "Tag Name to be assigned with VPC"
  type        = string
}

variable "cidr" {
  description = "Enter the CIDR range required for VPC"
  type        = string
}

variable "igw_tag" {
  description = "Mention Tag needs to be associated with internet gateway"
  type        = string
}

variable "nat_tag" {
  description = "Mention Tag needs to be associated with NAT gateway"
  type        = string
}

variable "public_subnet_tag_1" {
  description = "Tag for public subnet"
  type        = string
}

variable "public_subnets_cidr_1" {
  description = "Cidr Blocks"
  type        = string
}

variable "public_subnet_tag_2" {
  description = "Tag for public subnet"
  type        = string
}

variable "public_subnets_cidr_2" {
  description = "Cidr Blocks"
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "It will map the public ip while launching resources"
  type        = bool
}

variable "private_subnet_tag_1" {
  description = "Tag for Private Subnet"
  type        = string
}

variable "private_subnets_cidr_1" {
  description = "mention the CIDR block for database subnet"
  type        = string
}

variable "private_subnet_tag_2" {
  description = "Tag for Private Subnet"
  type        = string
}

variable "private_subnets_cidr_2" {
  description = "mention the CIDR block for database subnet"
  type        = string
}

variable "default_security_group_name" {
  description = "Enter the name for security group"
  type        = string
  default     = null
}

variable "enable_dhcp_options" {
  description = "Enable DHCP options.. True or False"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable DNS Hostname"
  type        = bool
}

variable "enable_dns_support" {
  description = "Enable DNS Support"
  type        = bool
}
variable "enable_ipv6" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block."
  type        = bool
}

variable "public_route_table_tag" {
  description = "Tag name for public route table"
  type        = string
}
variable "private_route_table_tag" {
  description = "Tage for private route table"
  type        = string
}

variable "manage_default_route_table" {
  description = "Are we managing default route table"
  type        = bool
}

#############______EC2________###############

########################################
## Virtual Machine Module - Variables ##
########################################
variable "app_name" {
  type        = string
  description = "Application name"
}

variable "pluto_instance_type" {
  type        = string
  description = "EC2 instance type for pluto Server"
}

variable "db_instance_type" {
  type        = string
  description = "EC2 instance type for db Server"
}

variable "windows_associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address to the EC2 instance"
}

variable "windows_root_volume_size" {
  type        = number
  description = "Volumen size of root volumen of Windows Server"
}

variable "windows_data_volume_size" {
  type        = number
  description = "Volumen size of data volumen of Windows Server"
}

variable "windows_root_volume_type" {
  type        = string
  description = "Volumen type of root volumen of Windows Server. Can be standard, gp3, gp2, io1, sc1 or st1"
}

variable "windows_data_volume_type" {
  type        = string
  description = "Volumen type of data volumen of Windows Server. Can be standard, gp3, gp2, io1, sc1 or st1"

}

variable "key_name" {
  type = string

}
#########________EKS_______###########

variable "cluster_name" {
  type = string
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
  type = number
}

variable "endpoint_private_access" {
  type = bool
}
variable "endpoint_public_access" {
  type = bool
}

variable "eks_version" {
  type = string
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


#############______MSK________#################

variable "msk_cluster_name" {
  type = string
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

variable "environment" {
  type = string
}

variable "msk_sg_name" {
  type = string
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
}
