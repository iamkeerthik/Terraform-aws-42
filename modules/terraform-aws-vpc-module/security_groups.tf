##############################################################################
# Security Groups
##############################################################################

resource "aws_security_group" "aws-eks-sg" {
  name        = var.eks_sg_name
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.myVPC.id

  ingress = [
    {
      description      = "All traffic"
      from_port        = 0    # All ports
      to_port          = 0    # All Ports
      protocol         = "-1" # All traffic
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      description      = "Outbound rule"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    Name = var.eks_sg_name
  }
}

################# DB_Security_Group #######################################

# Define the security group for the Windows server
resource "aws_security_group" "aws-db-sg" {
  name        = var.db_sg_name
  description = "Allow incoming connections"
  vpc_id      = aws_vpc.myVPC.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTP connections"
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming RDP connections"
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = var.db_sg_name
 
  }
}

################# Pluto_Security_Group #######################################
resource "aws_security_group" "aws-pluto-sg" {
  name        = var.pluto_sg_name
  description = "Allow incoming connections"
  vpc_id      = aws_vpc.myVPC.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTP connections"
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming RDP connections"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = var.pluto_sg_name
  }
}


################# MSK_Security_Group #######################################

# Create a security group for the MSK cluster
resource "aws_security_group" "msk_cluster" {
  name        = var.msk_sg_name
  description = "Security group for MSK cluster"
  vpc_id      = aws_vpc.myVPC.id

  # Allow incoming traffic on port 9094 for Apache Kafka
  ingress {
    from_port   = 9094
    to_port     = 9094
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow incoming traffic on port 2181 for Apache ZooKeeper
  ingress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = var.msk_sg_name
  }
}

############# Traffic between SG #############################
resource "aws_security_group_rule" "allow_pluto_to_db" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.aws-pluto-sg.id
  source_security_group_id = aws_security_group.aws-db-sg.id
}

resource "aws_security_group_rule" "allow_db_to_pluto" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.aws-db-sg.id
  source_security_group_id = aws_security_group.aws-pluto-sg.id
}

resource "aws_security_group_rule" "allow_eks_to_pluto" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.aws-eks-sg.id
  source_security_group_id = aws_security_group.aws-pluto-sg.id
}

resource "aws_security_group_rule" "allow_eks_to_db" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.aws-eks-sg.id
  source_security_group_id = aws_security_group.aws-db-sg.id
}
