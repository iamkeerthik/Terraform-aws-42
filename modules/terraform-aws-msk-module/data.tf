
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


data "aws_security_group" "msk_sg" {
  vpc_id = data.aws_vpc.vpc_available.id
  filter {
    name   = "tag:Name"
    values = [var.msk_sg_name]
  }

}

# data "aws_iam_role" "msk_role" {
#   name = var.msk_role_name
# }
