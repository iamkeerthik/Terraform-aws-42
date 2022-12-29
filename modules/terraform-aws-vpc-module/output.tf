output "vpc_id" {
  value = aws_vpc.myVPC.id
}
output "public_subnet_1" {
  value = aws_subnet.private_subnet_1.id

}
output "database_subnet_1" {
  value = aws_subnet.private_subnet_2.id

}
# output "nat_gateway_ip" {
#   value = aws_eip.nat_eip.public_ip
# }