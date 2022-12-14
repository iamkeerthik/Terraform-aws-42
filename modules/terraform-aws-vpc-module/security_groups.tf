# Declare a variable for the security group rules
variable "sg_rules" {
  type = list(object({
    description    = string,
    cidr_block     = string,
    from_port      = number,
    protocol       = string,
    security_group = string,
    to_port        = number,
  }))
}
##############################################################################
# Security Groups
##############################################################################

resource "aws_security_group" "aws-eks-sg" {
  name   = var.eks_sg_name
  vpc_id = aws_vpc.myVPC.id

  # Use the variable for the security group rules
  ingress = [
    for rule in var.sg_rules :
    {
      description      = rule.description
      cidr_blocks      = [rule.cidr_block]
      from_port        = rule.from_port
      protocol         = rule.protocol
      security_groups  = [rule.security_group]
      to_port          = rule.to_port
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
  # Use the variable for the security group rules
  ingress = [
    for rule in var.sg_rules :
    {
      description      = rule.description
      cidr_blocks      = [rule.cidr_block]
      from_port        = rule.from_port
      protocol         = rule.protocol
      security_groups  = [rule.security_group]
      to_port          = rule.to_port
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
    Name = var.db_sg_name

  }
}

################# Pluto_Security_Group #######################################
resource "aws_security_group" "aws-pluto-sg" {
  name        = var.pluto_sg_name
  description = "Allow incoming connections"
  vpc_id      = aws_vpc.myVPC.id
  # Use the variable for the security group rules
  ingress = [
    for rule in var.sg_rules :
    {
      description      = rule.description
      cidr_blocks      = [rule.cidr_block]
      from_port        = rule.from_port
      protocol         = rule.protocol
      security_groups  = [rule.security_group]
      to_port          = rule.to_port
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
    Name = var.pluto_sg_name
  }
}


################# MSK_Security_Group #######################################

# Create a security group for the MSK cluster
resource "aws_security_group" "msk-sg" {
  name        = var.msk_sg_name
  description = "Security group for MSK cluster"
  vpc_id      = aws_vpc.myVPC.id

  # Allow incoming traffic on port 9094 for Apache Kafka
  ingress = [
    for rule in var.sg_rules :
    {
      description      = rule.description
      cidr_blocks      = [rule.cidr_block]
      from_port        = rule.from_port
      protocol         = rule.protocol
      security_groups  = [rule.security_group]
      to_port          = rule.to_port
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
    Name = var.msk_sg_name
  }
}

############# Traffic between SG #############################
resource "aws_security_group_rule" "allow_pluto_to_db" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.aws-pluto-sg.id
  source_security_group_id = aws_security_group.aws-db-sg.id
}

resource "aws_security_group_rule" "allow_db_to_pluto" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.aws-db-sg.id
  source_security_group_id = aws_security_group.aws-pluto-sg.id
}

resource "aws_security_group_rule" "allow_eks_to_pluto" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.aws-eks-sg.id
  source_security_group_id = aws_security_group.aws-pluto-sg.id
}

resource "aws_security_group_rule" "allow_eks_to_db" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.aws-eks-sg.id
  source_security_group_id = aws_security_group.aws-db-sg.id
}

resource "aws_security_group_rule" "allow_eks_to_msk" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.aws-eks-sg.id
  source_security_group_id = aws_security_group.msk-sg.id
}

resource "aws_security_group_rule" "allow_msk_to_esk" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.msk-sg.id
  source_security_group_id = aws_security_group.aws-eks-sg.id
}