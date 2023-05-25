##################______VPC________##############
name                       = "Terraform"
cidr                       = "10.0.0.0/16"
public_subnets_cidr_1      = "10.0.1.0/24"
public_subnets_cidr_2      = "10.0.2.0/24"
private_subnets_cidr_1     = "10.0.3.0/24"
private_subnets_cidr_2     = "10.0.4.0/24"
map_public_ip_on_launch    = true
enable_dhcp_options        = true
enable_dns_hostnames       = true
enable_dns_support         = true
enable_ipv6                = true
manage_default_route_table = false

####################SG Rules####################
sg_rules = [
  {
    description    = "http"
    cidr_block     = "0.0.0.0/0"
    from_port      = 80
    protocol       = "tcp"
    security_group = "Terraform-eks-sg"
    to_port        = 80
  },
  {
    description    = "ssh"
    cidr_block     = "10.0.0.0/16"
    from_port      = 22
    protocol       = "tcp"
    security_group = "Terraform-eks-sg"
    to_port        = 22
  },
    {
    description    = "ssh"
    cidr_block     = "10.0.0.0/16"
    from_port      = 22
    protocol       = "tcp"
    security_group = "Terraform-linux-helper-sg"
    to_port        = 22
  },
  {
    description    = "rdp"
    cidr_block     = "10.0.0.0/16"
    from_port      = 3389
    protocol       = "tcp"
    security_group = "Terraform-db-sg"
    to_port        = 3389
  },
  {
    description    = "rdp"
    cidr_block     = "10.0.0.0/16"
    from_port      = 3389
    protocol       = "tcp"
    security_group = "Terraform-pluto-sg"
    to_port        = 3389
  },
  {
    description    = "apache_kafka"
    cidr_block     = "10.0.0.0/16"
    from_port      = 9094
    protocol       = "tcp"
    security_group = "Terraform-msk-sg"
    to_port        = 9094
  },
  {
    description    = "apache_zookeeper"
    cidr_block     = "10.0.0.0/16"
    from_port      = 2181
    protocol       = "tcp"
    security_group = "Terraform-msk-sg"
    to_port        = 2181
  },
]



###################_______EC2_____##############
key_name                            = "keerthik"
pluto_instance_type                 = "t3a.small"
db_instance_type                    = "t3a.medium"
linux_instance_type                 = "t2.micro"
windows_associate_public_ip_address = false
linux_associate_public_ip_address   = false
pluto_root_volume_size              = 30
db_root_volume_size                 = 65
linux_root_volume_size              = 20
pluto_root_volume_type              = "gp3"
db_root_volume_type                 = "gp3"
linux_root_volume_type              = "gp3"
windows_data_volume_size            = 10
windows_data_volume_type            = "gp3"
termination_protection              = true
ec2_role                            = "ec2_role"

#################_______EKS_________##############
asg_desired_size        = 2
asg_max_size            = 3
asg_min_size            = 1
launch_template_id      = "lt-03fbea4b65e2a13fe"
launch_template_version = 2
endpoint_private_access = true
endpoint_public_access  = true
eks_version             = "1.24"
eks_instance_type       = "t2.micro"
cluster_role_name       = "suremdm-eks-cluster-role"
node_role_name          = "eks-node-group-role"
region                  = "ap-south-1"

##################__________MSK_________#################
kafka_version             = "2.6.2"
no_of_nodes               = "2"
kafka_intance_type        = "kafka.t3.small"
volume_size               = 20
open_monitoring           = true
aws_msk_configuration_arn = "example-config_arn"
config_revision           = 1


#####################Logs_bucket##################
bucket_names  = ["app-logs", "api-logs"]
bucket_prefix = "keerthik980"