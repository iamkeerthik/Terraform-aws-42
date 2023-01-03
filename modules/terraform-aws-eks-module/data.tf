
data "aws_availability_zones" "available_1" {
  state = "available"
}

data "aws_vpc" "vpc_available" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "subnet_1" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = data.aws_availability_zones.available_1.names[0]
  filter {
    name   = "tag:Name"
    values = [var.subnet_1]
  }
}

data "aws_subnet" "subnet_2" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = data.aws_availability_zones.available_1.names[1]
  filter {
    name   = "tag:Name"
    values = [var.subnet_2]
  }
}


data "aws_security_group" "eks-security" {
  vpc_id = data.aws_vpc.vpc_available.id
  filter {
    name   = "tag:Name"
    values = [var.eks_sg_name]
  }

}

data "aws_iam_role" "cluster_role" {
  name = var.cluster_role_name
}

data "aws_iam_role" "node_role" {
  name = var.node_role_name

}