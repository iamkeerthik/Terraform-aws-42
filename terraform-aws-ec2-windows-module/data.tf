# data "aws_iam_instance_profile" "instance_profile" {
#   name = "MyEC2SSMRole"
# }
data "aws_availability_zone" "az" {
  name                   = "ap-south-1a"
  all_availability_zones = false
  state                  = "available"
}

data "aws_key_pair" "key" {
  key_name = "keerthik"
}

data "aws_vpc" "vpc_available" {
  filter {
    name   = "tag:Name"
    values = ["Suremdm-VPC"]
  }
}
data "aws_subnet" "private" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = "ap-south-1a"
  filter {
    name   = "tag:Name"
    values = ["suremdm_private_subnet_az_1a"]
  }
}

data "aws_subnet" "public" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = "ap-south-1a"
  filter {
    name   = "tag:Name"
    values = ["suremdm_public_subnet_az_1a"]
  }
}

data "aws_security_group" "eks-security" {
  vpc_id = data.aws_vpc.vpc_available.id
  filter {
    name   = "tag:Name"
    values = ["suremdm_security_group"]
  }
}