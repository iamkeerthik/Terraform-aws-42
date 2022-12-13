########################################
## Virtual Machine Module - Variables ##
########################################

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

variable "windows_instance_name_1" {
  type        = string
  description = "EC2 instance name for Windows Server"
  default     = "pluto"
}
variable "windows_instance_name_2" {
  type        = string
  description = "EC2 instance name for Windows Server"
  default     = "database"
}