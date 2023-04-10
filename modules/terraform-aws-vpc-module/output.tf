output "vpc_id" {
  value = aws_vpc.myVPC.id
}
output "public_subnet_1" {
  value = aws_subnet.private_subnet_1.id

}
output "public_subnet_2" {
  value = aws_subnet.public_subnet_2.id

}
output "private_subnet_1" {
  value = aws_subnet.private_subnet_1.id 
}
output "private_subnet_2" {
  value = aws_subnet.private_subnet_2.id 
}
output "Internet_Gateway" {
  value = aws_internet_gateway.IGW.id
}
output "NAT_Gateway-1a" {
  value = aws_nat_gateway.nat_gateway-1a.id
}
output "NAT_Gateway-1b" {
  value = aws_nat_gateway.nat_gateway-1b.id
}
output "nat_gateway_ip-1a" {
  value = aws_eip.nat_eip-1a.public_ip
}
output "nat_gateway_ip-1b" {
  value = aws_eip.nat_eip-1b.public_ip
}

output "Egress_only_IGW" {
  value = aws_egress_only_internet_gateway.EgressonlyIGW.id
}

output "pluto_sg" {
  value = aws_security_group.aws-pluto-sg.id
}
output "db_sg" {
  value = aws_security_group.aws-db-sg.id
}

