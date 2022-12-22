
data "aws_vpc" "vpc_available" {
  filter {
    name   = "tag:Name"
    values = ["Suremdm-VPC"]
  }
}

data "aws_subnet" "private_1" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = "ap-south-1a"
  filter {
    name   = "tag:Name"
    values = ["suremdm_private_subnet_az_1a"]
  }
}

data "aws_subnet" "private_2" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = "ap-south-1b"
  filter {
    name   = "tag:Name"
    values = ["suremdm_private_subnet_az_1b"]
  }
}

data "aws_subnet" "public_1" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = "ap-south-1a"
  filter {
    name   = "tag:Name"
    values = ["suremdm_public_subnet_az_1a"]
  }
}

data "aws_subnet" "public_2" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = "ap-south-1b"
  filter {
    name   = "tag:Name"
    values = ["suremdm_public_subnet_az_1b"]
  }
}

data "aws_security_group" "node-security" {
  vpc_id = data.aws_vpc.vpc_available.id
  filter {
    name   = "tag:Name"
    values = ["suremdm_security_group"]
  }

}

# data "aws_iam_role" "msk_role" {
#   name = "msk_role"
# }

