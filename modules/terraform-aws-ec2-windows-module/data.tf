# data "aws_iam_instance_profile" "instance_profile" {
#   name = "MyEC2SSMRole"
# }
################################################################################
# Availability Zones list out
################################################################################
data "aws_availability_zones" "available_1" {
  state = "available"
}

data "aws_key_pair" "key" {
  key_name = var.key_name
}

data "aws_vpc" "vpc_available" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}
data "aws_subnet" "private" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = data.aws_availability_zones.available_1.names[0]
  filter {
    name   = "tag:Name"
    values = [var.private_subnet_tag_1]
  }
}

data "aws_subnet" "public" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = data.aws_availability_zones.available_1.names[0]
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_tag_1]
  }
}


data "aws_security_group" "db_security_group" {
  vpc_id = data.aws_vpc.vpc_available.id
  filter {
    name   = "tag:Name"
    values = [var.db_sg_name]
  }
}

data "aws_security_group" "pluto_security_group" {
  vpc_id = data.aws_vpc.vpc_available.id
  filter {
    name   = "tag:Name"
    values = [var.pluto_sg_name]
  }
}