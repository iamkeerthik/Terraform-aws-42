
module "vpc" {
  source                     = "../terraform-aws-vpc-module"
  vpc_name                   = var.vpc_name
  cidr                       = var.cidr
  igw_tag                    = var.igw_tag
  nat_tag                    = var.nat_tag
  public_subnet_tag_1        = var.public_subnet_tag_1
  public_subnets_cidr_1      = var.public_subnets_cidr_1
  public_subnet_tag_2        = var.public_subnet_tag_2
  public_subnets_cidr_2      = var.public_subnets_cidr_2
  private_subnet_tag_1       = var.private_subnet_tag_1
  private_subnets_cidr_1     = var.private_subnets_cidr_1
  private_subnet_tag_2       = var.private_subnet_tag_2
  private_subnets_cidr_2     = var.private_subnets_cidr_2
  public_route_table_tag     = var.public_route_table_tag
  private_route_table_tag    = var.private_route_table_tag
  map_public_ip_on_launch    = var.map_public_ip_on_launch
  enable_dhcp_options        = var.enable_dhcp_options
  enable_dns_hostnames       = var.enable_dns_hostnames
  enable_dns_support         = var.enable_dns_support
  enable_ipv6                = var.enable_ipv6
  manage_default_route_table = var.manage_default_route_table

}
module "ec2" {
  source = "../terraform-aws-ec2-windows-module"
  depends_on = [
    module.vpc
  ]
  vpc_name                            = var.vpc_name
  key_name                            = var.key_name
  app_name                            = var.app_name
  app_environment                     = var.app_environment
  pluto_instance_type                 = var.pluto_instance_type
  db_instance_type                    = var.db_instance_type
  windows_associate_public_ip_address = var.windows_associate_public_ip_address
  windows_root_volume_size            = var.windows_root_volume_size
  windows_data_volume_size            = var.windows_data_volume_size
  windows_root_volume_type            = var.windows_root_volume_type
  windows_data_volume_type            = var.windows_data_volume_type

}

module "eks" {
  source = "../terraform-aws-eks-module"
  depends_on = [
    module.vpc
  ]
  cluster_name            = var.cluster_name
  vpc_name                   = var.vpc_name
  subnet_1             = var.subnet_1
  subnet_2             = var.subnet_2
  asg_desired_size        = var.asg_desired_size
  asg_max_size            = var.asg_max_size
  asg_min_size            = var.asg_min_size
  launch_template_id      = var.launch_template_id
  launch_template_version = var.launch_template_version
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
  eks_version             = var.eks_version
  node_group_name         = var.node_group_name
  eks_instance_type       = var.eks_instance_type
  cluster_role_name       = var.cluster_role_name
  node_role_name          = var.node_role_name
}

module "MSK" {
  source = "../terraform-aws-msk-module"
  depends_on = [
    module.vpc
  ]
  msk_cluster_name=var.msk_cluster_name
  kafka_version=var.kafka_version
  no_of_nodes =var.no_of_nodes
  kafka_intance_type=var.kafka_intance_type
  environment=var.environment
  msk_security_group_name=var.msk_security_group_name
}