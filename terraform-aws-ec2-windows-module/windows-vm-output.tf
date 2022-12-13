#####################################
## Virtual Machine Module - Output ##
#####################################
output "windows_instance_name_1" {
  value = var.windows_instance_name_1
}
output "windows_instance_name_2" {
  value = var.windows_instance_name_2
}


output "pluto-server-private-ip" {
  value = aws_instance.pluto-server.private_ip
}

output "db_server_private_ip" {
  value = aws_instance.db-server.private_ip
}