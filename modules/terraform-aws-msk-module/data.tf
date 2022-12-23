
data "aws_vpc" "vpc_available" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "subnet_1" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = "ap-south-1a"
  filter {
    name   = "tag:Name"
    values = [var.subnet_1]
  }
}

data "aws_subnet" "subnet_2" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = "ap-south-1b"
  filter {
    name   = "tag:Name"
    values = [var.subnet_2]
  }
}


data "aws_security_group" "eks-security" {
  vpc_id = data.aws_vpc.vpc_available.id
  filter {
    name   = "tag:Name"
    values = ["suremdm_security_group"]
  }

}

# data "aws_iam_role" "msk_role" {
#   name = var.msk_role_name
# }
