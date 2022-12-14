variable "subnet_id_1" {
  type = string
  default = "subnet-your_first_subnet_id"
 }
 
 variable "subnet_id_2" {
  type = string
  default = "subnet-your_second_subnet_id"
 }

 variable "asg_desired_size" {
  type = number
  default = 1 
 }

 variable "asg_max_size" {
  type = number
  default = 1 
 }

 variable "asg_min_size" {
  type = number
  default = 1
 }

 variable "launch_template_name" {
  type = string
  default="" 
 }

 variable "launch_template_version" {
   type = number
   default = 1
 }