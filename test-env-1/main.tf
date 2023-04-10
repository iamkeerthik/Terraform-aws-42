terraform {
  backend "s3" {
    bucket  = "terraform-statefiles-keerthik"
    key     = "dev-test-env/infra-terraform.tfstate"
    region  = "ap-south-1"
    profile = "PS"
  }
}


module "vpc" {
  source                     = "../modules/terraform-aws-vpc-module"
  name                       = var.name
  cidr                       = var.cidr
  public_subnets_cidr_1      = var.public_subnets_cidr_1
  public_subnets_cidr_2      = var.public_subnets_cidr_2
  private_subnets_cidr_1     = var.private_subnets_cidr_1
  private_subnets_cidr_2     = var.private_subnets_cidr_2
  map_public_ip_on_launch    = var.map_public_ip_on_launch
  enable_dhcp_options        = var.enable_dhcp_options
  enable_dns_hostnames       = var.enable_dns_hostnames
  enable_dns_support         = var.enable_dns_support
  enable_ipv6                = var.enable_ipv6
  manage_default_route_table = var.manage_default_route_table
  sg_rules                   = var.sg_rules
}

module "ec2" {
  source = "../modules/terraform-aws-ec2-windows-module"
  depends_on = [
    module.vpc
  ]
  name                                = var.name
  key_name                            = var.key_name
  pluto_instance_type                 = var.pluto_instance_type
  db_instance_type                    = var.db_instance_type
  linux_instance_type                 = var.linux_instance_type
  windows_associate_public_ip_address = var.windows_associate_public_ip_address
  linux_associate_public_ip_address   = var.linux_associate_public_ip_address
  pluto_root_volume_size              = var.pluto_root_volume_size
  db_root_volume_size                 = var.db_root_volume_size
  linux_root_volume_size              = var.linux_root_volume_size
  windows_data_volume_size            = var.windows_data_volume_size
  pluto_root_volume_type              = var.pluto_root_volume_type
  db_root_volume_type                 = var.db_root_volume_type
  linux_root_volume_type              = var.linux_root_volume_type
  windows_data_volume_type            = var.windows_data_volume_type
  pluto_user_data                     = file("pluto-userdata.ps1")
  db_user_data                        = file("db-userdata.ps1")
  linux_user_data                     = file("linux-userdata.sh")
  termination_protection              = var.termination_protection
  ec2_role                            = var.ec2_role
}

# module "eks" {
#   source = "../modules/terraform-aws-eks-module"
#   depends_on = [
#     module.vpc
#   ]
#   name                    = var.name
#   asg_desired_size        = var.asg_desired_size
#   asg_max_size            = var.asg_max_size
#   asg_min_size            = var.asg_min_size
#   launch_template_id      = var.launch_template_id
#   launch_template_version = var.launch_template_version
#   endpoint_private_access = var.endpoint_private_access
#   endpoint_public_access  = var.endpoint_public_access
#   eks_version             = var.eks_version
#   eks_instance_type       = var.eks_instance_type
#   cluster_role_name       = var.cluster_role_name
#   node_role_name          = var.node_role_name
#   region                  = var.region
# }

# module "MSK" {
#   source = "../modules/terraform-aws-msk-module"
#   depends_on = [
#     module.vpc
#   ]
#   name                      = var.name
#   volume_size               = var.volume_size
#   kafka_version             = var.kafka_version
#   no_of_nodes               = var.no_of_nodes
#   kafka_intance_type        = var.kafka_intance_type
#   open_monitoring           = var.open_monitoring
#   aws_msk_configuration_arn = var.aws_msk_configuration_arn
#   config_revision           = var.config_revision
# }


# module "s3_logs_buckets" {
#   source          = "../modules/terraform-s3-module"
#   bucket_names    = var.bucket_names
#   bucket_prefix   = var.bucket_prefix
# }

# module "Cloudwatch" {
#   source = "../modules/terraform-cloudwacth"
#   depends_on = [
#     module.ec2
#   ]
#   name = var.name
# }
