#####################################
## Virtual Machine Module - Output ##
#####################################

# output "pluto-server-private-ip" {
#   value = aws_instance.pluto-server.private_ip
# }

# output "db_server_private_ip" {
#   value = aws_instance.db-server.private_ip
# }

output "pluto_instance_id" {
  value = aws_instance.pluto-server.id
}
output "pluto_instance_type" {
  value = aws_instance.pluto-server.instance_type
}
output "pluto_ami_id" {
  value = aws_instance.pluto-server.ami
}

output "db_instance_id" {
  value = aws_instance.db-server.id
}
output "db_instance_type" {
  value = aws_instance.db-server.instance_type
}
output "db_ami_id" {
  value = aws_instance.db-server.ami
}

output "linux_instance_id" {
  value = aws_instance.linux-helper.id
}
output "linux_instance_type" {
  value = aws_instance.linux-helper.instance_type
}
output "linux_ami_id" {
  value = aws_instance.linux-helper.ami
}

output "public_instance_id" {
  value = aws_instance.public-server.id
}
output "public_instance_type" {
  value = aws_instance.public-server.instance_type
}
output "public_ami_id" {
  value = aws_instance.public-server.ami
}