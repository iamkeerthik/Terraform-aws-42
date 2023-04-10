
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
output "NAT_gateway-1a" {
  value = module.vpc.NAT_Gateway-1a
}
output "NAT_gateway-1b" {
  value = module.vpc.NAT_Gateway-1b
}
output "NAT_IP-1a" {
  value = module.vpc.nat_gateway_ip-1a
}
output "NAT_IP-1b" {
  value = module.vpc.nat_gateway_ip-1b
}
output "Pluto_sg" {
  value = module.vpc.pluto_sg
}
output "DB_sg" {
  value = module.vpc.db_sg
}

####################EC2##################
# output "pluto_machine_ip" {
#   value = module.ec2.pluto-server-private-ip
# }
# output "db_machine_ip" {
#   value = module.ec2.db_server_private_ip
# }
output "pluto_instance_id" {
  value = module.ec2.pluto_instance_id
}
output "db_instance_id" {
  value = module.ec2.db_instance_id
}
output "public_instance_id" {
  value = module.ec2.public_instance_id
}
output "linux_instance_id" {
  value = module.ec2.linux_instance_id
}

output "pluto_instance_type" {
  value = module.ec2.pluto_instance_type
}
output "db_instance_type" {
  value = module.ec2.db_instance_type
}
output "linux_instance_type" {
  value = module.ec2.linux_instance_type
}
output "public_instance_type" {
  value = module.ec2.public_instance_type
}

output "pluto_ami_id" {
  value = module.ec2.pluto_ami_id
}
output "db_ami_id" {
  value = module.ec2.db_ami_id
}
output "linux_ami_id" {
  value = module.ec2.linux_ami_id
}
output "public_ami_id" {
  value = module.ec2.public_ami_id
}
# # ##############EKS################
# output "cluster_id" {
#   value = module.eks.cluster_id
# }

# output "eks_nodegroup_id" {
#   value = module.eks.eks_nodegroup_id
# }

# output "cluster_endpoint" {
#   value = module.eks.cluster_endpoint
# }

# output "cluster_ca_cert" {
#   value = module.eks.cluster_ca_cert
# }

# output "cluster_name" {
#   value = module.eks.cluster_name
# }
# # ##############MSK######################
# # output "msk_cluster_id" {
# #   value = module.MSK.msk_cluter_id
# # }