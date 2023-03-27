
###################VPC##################
output "vpc_id" {
  value = module.vpc.vpc_id
}
output "public_subnet_1" {
  value = module.vpc.public_subnet_1
}
output "public_subnet_2" {
  value = module.vpc.public_subnet_2
}
output "private_subnet_1" {
  value = module.vpc.private_subnet_1
}
output "private_subnet_2" {
  value = module.vpc.private_subnet_2
}
output "Internet_gateway" {
  value = module.vpc.Internet_Gateway
}
output "Egressonly_IGW" {
  value = module.vpc.Egress_only_IGW
}
output "NAT_gateway" {
  value = module.vpc.NAT_Gateway
}
output "NAT_IP" {
  value = module.vpc.nat_gateway_ip
}
output "Pluto_sg" {
  value = module.vpc.pluto_sg
}
output "DB_sg" {
  value = module.vpc.db_sg
}

####################EC2##################
output "pluto_machine_ip" {
  value = module.ec2.pluto-server-private-ip
}
output "db_machine_ip" {
  value = module.ec2.db_server_private_ip
}

# ##############EKS################
# output "cluster_id" {
#   value = module.eks.eks_cluster_id
# }

# output "nodegroup_id" {
#   value = module.eks.eks_nodegroup_id
# }


# ##############MSK######################
# output "msk_cluster_id" {
#   value = module.MSK.msk_cluter_id
# }