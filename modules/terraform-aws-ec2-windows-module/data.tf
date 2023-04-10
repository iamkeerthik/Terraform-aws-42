data "aws_iam_role" "instance_role" {
  name = var.ec2_role
}
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
    values = ["${var.name}-vpc"]
  }
}
data "aws_subnet" "private" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = data.aws_availability_zones.available_1.names[0]
  filter {
    name   = "tag:Name"
    values = ["${var.name}-private-subent-1a"]
  }
}

data "aws_subnet" "public" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = data.aws_availability_zones.available_1.names[0]
  filter {
    name   = "tag:Name"
    values = ["${var.name}-public-subent-1a"]
  }
}


data "aws_security_group" "db_security_group" {
  vpc_id = data.aws_vpc.vpc_available.id
  filter {
    name   = "tag:Name"
    values = ["${var.name}-db-sg"]
  }
}

data "aws_security_group" "pluto_security_group" {
  vpc_id = data.aws_vpc.vpc_available.id
  filter {
    name   = "tag:Name"
    values = ["${var.name}-pluto-sg"]
  }
}
data "aws_security_group" "linux_security_group" {
  vpc_id = data.aws_vpc.vpc_available.id
  filter {
    name   = "tag:Name"
    values = ["${var.name}-linux-helper-sg"]
  }
}
