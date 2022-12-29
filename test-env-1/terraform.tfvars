##################______VPC________##############
vpc_name = "Terraform-VPC"
# cidr                       = ""
# igw_tag                    = ""
# nat_tag                    = ""
# public_subnet_tag_1        = ""
# public_subnets_cidr_1      = ""
# public_subnet_tag_2        = ""
# public_subnets_cidr_2      = ""
# private_subnet_tag_1       = ""
# private_subnets_cidr_1     = ""
# private_subnet_tag_2       = ""
# private_subnets_cidr_2     = ""
# public_route_table_tag     = ""
# private_route_table_tag    = ""
# map_public_ip_on_launch    = ""
# enable_dhcp_options        = ""
# enable_dns_hostnames       = ""
# enable_dns_support         = ""
# enable_ipv6                = ""
# manage_default_route_table = ""
eks_sg_name = "EKS-sg"
db_sg_name = "pluto-sg"
pluto_sg_name = "db-sg"
msk_sg_name="msk-sg"


###################_______EC2_____##############
app_name = "test123"
key_name = "keerthik"
# app_environment                     = ""
# pluto_instance_type                 = ""
# db_instance_type                    = ""
# windows_associate_public_ip_address = true
# windows_root_volume_size            = 30
# windows_root_volume_type            = "gp2"
# windows_data_volume_size            = 10
# windows_data_volume_type            = "gp2"


#################_______EKS_________##############
cluster_name = "eks-cluster"
# subnet_1             = ""
# subnet_2             = ""
# asg_desired_size        = ""
# asg_max_size            = ""
# asg_min_size            = ""
# launch_template_id      = ""
# launch_template_version = ""
# endpoint_private_access = ""
# endpoint_public_access  = ""
# eks_version             = ""
node_group_name         = "eks-node-group"
eks_instance_type = "t3a.medium"
# cluster_role_name       = ""
# node_role_name          = ""


##################__________MSK_________#################
#   msk_cluster_name=""
#   kafka_version=""
#   no_of_nodes =""
#   kafka_intance_type=""
#   environment=""