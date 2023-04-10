################################################################################
# VPC
################################################################################

resource "aws_vpc" "myVPC" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  assign_generated_ipv6_cidr_block = var.enable_ipv6
  tags = {
    Name = "${var.name}-vpc"
  }
}

###############################################################################
# Internet Gateway
###############################################################################

resource "aws_internet_gateway" "IGW" {

  vpc_id = aws_vpc.myVPC.id
  tags = {
    "Name" = "${var.name}-IGW"
  }
}

#################################################################################
# Egressonly IGW
################################################################################
resource "aws_egress_only_internet_gateway" "EgressonlyIGW" {
  vpc_id = aws_vpc.myVPC.id
  tags = {
    "Name" = "${var.name}-egw"
  }
}


################################################################################
# Public subnet
################################################################################

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.public_subnets_cidr_1
  ipv6_cidr_block         = cidrsubnet(aws_vpc.myVPC.ipv6_cidr_block, 8, 1)
  availability_zone       = data.aws_availability_zones.available_1.names[0]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "${var.name}-public-subent-1a"
  }
}
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.public_subnets_cidr_2
  ipv6_cidr_block         = cidrsubnet(aws_vpc.myVPC.ipv6_cidr_block, 8, 2)
  availability_zone       = data.aws_availability_zones.available_1.names[1]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "${var.name}-public-subent-1b"
  }
}

################################################################################
# Private subnet
################################################################################

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.private_subnets_cidr_1
  ipv6_cidr_block         = cidrsubnet(aws_vpc.myVPC.ipv6_cidr_block, 8, 3)
  availability_zone       = data.aws_availability_zones.available_1.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.name}-private-subent-1a"
  }
}
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.private_subnets_cidr_2
  ipv6_cidr_block         = cidrsubnet(aws_vpc.myVPC.ipv6_cidr_block, 8, 4)
  availability_zone       = data.aws_availability_zones.available_1.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.name}-private-subent-1b"
  }
}
###############################################################################
# EIP Gateway
###############################################################################

resource "aws_eip" "nat_eip-1a" {
  vpc = true
  tags = {
    "Name" = "${var.name}-nat-eip-1a"
  }
}

resource "aws_eip" "nat_eip-1b" {
  vpc = true
  tags = {
    "Name" = "${var.name}-nat-eip-1b"
  }
}

###############################################################################
# NAT Gateway
###############################################################################

resource "aws_nat_gateway" "nat_gateway-1a" {
  allocation_id = aws_eip.nat_eip-1a.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    "Name" = "${var.name}-nat-1a"
  }
}

resource "aws_nat_gateway" "nat_gateway-1b" {
  allocation_id = aws_eip.nat_eip-1b.id
  subnet_id     = aws_subnet.public_subnet_2.id
  tags = {
    "Name" = "${var.name}-nat-lb"
  }
}
################################################################################
# Publiс routes
################################################################################

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.myVPC.id
  tags = {
    Name = "${var.name}-public-rt"
  }
}
resource "aws_route" "public_internet_gateway_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW.id
}

################################################################################
# Private route table
################################################################################

resource "aws_route_table" "private_route_table-1a" {
  vpc_id = aws_vpc.myVPC.id

  tags = {
    Name = "${var.name}-private-rt-1a"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway-1a.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.EgressonlyIGW.id
  }
}

resource "aws_route_table" "private_route_table-1b" {
  vpc_id = aws_vpc.myVPC.id

  tags = {
    Name = "${var.name}-private-rt-1b"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway-1b.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.EgressonlyIGW.id
  }
}
################################################################################
# Route table association with subnets
################################################################################

resource "aws_route_table_association" "public_route_table_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public_route_table_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "private_route_table_association_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table-1a.id
}
resource "aws_route_table_association" "private_route_table_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table-1b.id
}

