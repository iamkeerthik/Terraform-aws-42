########################################
## Virtual Machine Module - Variables ##
########################################
variable "name" {
  description = "Tag Name to be assigned with resources"
  type        = string

}
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


variable "key_name" {
  type = string

}

variable "pluto_user_data" {
  type = string
}

variable "db_user_data" {
  type = string
}


variable "termination_protection" {
  type = bool
}

variable "linux_instance_type" {
  type        = string
  description = "EC2 instance type for Linux Server"
  default     = "t2.micro"
}
variable "linux_associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address to the EC2 instance"
  default     = true
}
variable "linux_root_volume_size" {
  type        = number
  description = "Volumen size of root volumen of Linux Server"
}

variable "linux_root_volume_type" {
  type        = string
  description = "Volumen type of root volumen of Linux Server."
  default     = "gp2"
}


variable "linux_user_data" {
  type = string
}