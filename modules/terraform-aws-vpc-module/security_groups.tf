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
  name   = "${var.name}-eks-sg"
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
    Name = "${var.name}-eks-sg"
  }
}

################# DB_Security_Group #######################################

# Define the security group for the Windows server
resource "aws_security_group" "aws-db-sg" {
  name        = "${var.name}-db-sg"
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
    Name = "${var.name}-db-sg"

  }
}

################# Pluto_Security_Group #######################################
resource "aws_security_group" "aws-pluto-sg" {
  name        = "${var.name}-pluto-sg"
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
    Name = "${var.name}-pluto-sg"
  }
}

#####################Linux_Helper_Security_Group############################
resource "aws_security_group" "aws-linux-sg" {
  name        = "${var.name}-linux-helper-sg"
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
    Name = "${var.name}-linux-helper-sg"
  }
}
################# MSK_Security_Group #######################################

# Create a security group for the MSK cluster
resource "aws_security_group" "msk-sg" {
  name        = "${var.name}-msk-sg"
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
    Name = "${var.name}-msk-sg"
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

resource "aws_security_group_rule" "allow_msk_to_eks" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.msk-sg.id
  source_security_group_id = aws_security_group.aws-eks-sg.id
}

resource "aws_security_group_rule" "allow_linux_helper_to_pluto" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "-1"
  security_group_id        = aws_security_group.aws-linux-sg.id
  source_security_group_id = aws_security_group.aws-pluto-sg.id
}
resource "aws_security_group_rule" "allow_linux_helper_to_db" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "-1"
  security_group_id        = aws_security_group.aws-linux-sg.id
  source_security_group_id = aws_security_group.aws-db-sg.id
}

resource "aws_security_group_rule" "allow_linux_helper_to_eks" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "-1"
  security_group_id        = aws_security_group.aws-linux-sg.id
  source_security_group_id = aws_security_group.aws-eks-sg.id
}