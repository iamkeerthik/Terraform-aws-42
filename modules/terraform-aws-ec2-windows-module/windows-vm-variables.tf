########################################
## Virtual Machine Module - Variables ##
########################################
variable "ec2_role" {
  type = string
  description = "IAM role for ec2 for ssm and cloudwatch"
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

variable "pluto_root_volume_size" {
  type        = number
  description = "Volumen size of root volumen of Windows Server"
}

variable "db_root_volume_size" {
  type        = number
  description = "Volumen size of root volumen of Windows Server"
}

variable "windows_data_volume_size" {
  type        = number
  description = "Volumen size of data volumen of Windows Server"
}

variable "pluto_root_volume_type" {
  type        = string
  description = "Volumen type of root volumen of pluto Server. Can be standard, gp3, gp2, io1, sc1 or st1"

}

variable "db_root_volume_type" {
  type        = string
  description = "Volumen type of root volumen of db Server. Can be standard, gp3, gp2, io1, sc1 or st1"

}

variable "windows_data_volume_type" {
  type        = string
  description = "Volumen type of data volumen of Windows Server. Can be standard, gp3, gp2, io1, sc1 or st1"

}

variable "vpc_name" {
  type = string

}

variable "key_name" {
  type = string

}

variable "db_sg_name" {
  type = string
}

variable "pluto_sg_name" {
  type = string
}

variable "pluto_user_data" {
  type = string
}

variable "db_user_data" {
  type = string
}

variable "private_subnet_tag_1" {
  description = "Tag for Private Subnet"
  type        = string
}

variable "private_subnet_tag_2" {
  description = "Tag for Private Subnet"
  type        = string
}

variable "public_subnet_tag_1" {
  description = "Tag for public subnet"
  type        = string
}

variable "termination_protection" {
  type = bool
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