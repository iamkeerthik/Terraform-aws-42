##################______VPC________##############
vpc_name                   = "Terraform-VPC"
cidr                       = "10.0.0.0/16"
igw_tag                    = "terraform-igw"
nat_tag                    = "terraform-nat"
public_subnet_tag_1        = "public-1a"
public_subnets_cidr_1      = "10.0.1.0/24"
public_subnet_tag_2        = "public-lb"
public_subnets_cidr_2      = "10.0.2.0/24"
private_subnet_tag_1       = "private-1a"
private_subnets_cidr_1     = "10.0.3.0/24"
private_subnet_tag_2       = "private-1b"
private_subnets_cidr_2     = "10.0.4.0/24"
public_route_table_tag     = "public-rt"
private_route_table_tag    = "private-rt"
map_public_ip_on_launch    = true
enable_dhcp_options        = true
enable_dns_hostnames       = true
enable_dns_support         = true
enable_ipv6                = false
manage_default_route_table = false
eks_sg_name                = "eks-sg"
db_sg_name                 = "db-sg"
pluto_sg_name              = "pluto-sg"
msk_sg_name                = "msk-sg"

####################SG Rules####################
sg_rules = [
  {
    description    = "http"
    cidr_block     = "10.0.0.0/24"
    from_port      = 80
    protocol       = "tcp"
    security_group = "EKS-sg"
    to_port        = 80
  },
  {
    description    = "ssh"
    cidr_block     = "10.0.1.0/24"
    from_port      = 22
    protocol       = "tcp"
    security_group = "EKS-sg"
    to_port        = 22
  },
  {
    description    = "rdp"
    cidr_block     = "0.0.0.0/0"
    from_port      = 3389
    protocol       = "tcp"
    security_group = "db-sg"
    to_port        = 3389
  },
  {
    description    = "apache_kafka"
    cidr_block     = "0.0.0.0/0"
    from_port      = 9094
    protocol       = "tcp"
    security_group = "msk-sg"
    to_port        = 9094
  },
  {
    description    = "apache_zookeeper"
    cidr_block     = "0.0.0.0/0"
    from_port      = 2181
    protocol       = "tcp"
    security_group = "msk-sg"
    to_port        = 2181
  },
]



###################_______EC2_____##############
app_name                            = "test123"
key_name                            = "keerthik"
pluto_instance_type                 = "t2.micro"
db_instance_type                    = "t2.micro"
windows_associate_public_ip_address = true
windows_root_volume_size            = 30
windows_root_volume_type            = "gp2"
windows_data_volume_size            = 10
windows_data_volume_type            = "gp2"

#################_______EKS_________##############
cluster_name            = "eks-cluster"
subnet_1                = "private-1a"
subnet_2                = "private-1b"
asg_desired_size        = 1
asg_max_size            = 1
asg_min_size            = 1
launch_template_id      = "lt-03fbea4b65e2a13fe"
launch_template_version = 1
endpoint_private_access = true
endpoint_public_access  = false
eks_version             = "1.23"
node_group_name         = "eks-node-group"
eks_instance_type       = "t2.micro"
cluster_role_name       = "suremdm-eks-cluster-role"
node_role_name          = "eks-node-group-role"


##################__________MSK_________#################
msk_cluster_name   = "terraform-msk"
kafka_version      = "2.6.2"
no_of_nodes        = "2"
kafka_intance_type = "kafka.t3.small"
environment        = "test"
volume_size        = 20