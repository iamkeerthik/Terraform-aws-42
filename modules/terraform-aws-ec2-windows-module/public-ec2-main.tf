

# Create EC2 Instance
resource "aws_instance" "public-server" {
  ami           = data.aws_ami.windows-2016.id
  instance_type = var.pluto_instance_type
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  key_name = data.aws_key_pair.key.key_name
  # vpc_security_group_ids      = data.aws_security_groups.sg.ids
  vpc_security_group_ids      = [aws_security_group.aws-public-sg.id]
  subnet_id                   = data.aws_subnet.public.id
  associate_public_ip_address = true
  source_dest_check           = false
  #   key_name                    = aws_key_pair.key_pair.key_name
  # user_data                   = data.template_file.windows-userdata.rendered
  user_data = var.pluto_user_data
  # root disk
  root_block_device {
    volume_size           = var.pluto_root_volume_size
    volume_type           = var.pluto_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  tags = {
    Name = "${lower(var.name)}-public-server",
    env = "${var.name}"
  }
}

# # Create Elastic IP for the EC2 instance
# resource "aws_eip" "windows-eip" {
#   vpc  = true
#   tags = {
#     Name        = "${lower(var.app_name)}-${var.app_environment}-windows-eip"
#     Environment = var.app_environment
#   }
# }

# # Associate Elastic IP to Windows Server
# resource "aws_eip_association" "windows-eip-association" {
#   instance_id   = aws_instance.windows-server.id
#   allocation_id = aws_eip.windows-eip.id
# }

# Define the security group for the Windows server
resource "aws_security_group" "aws-public-sg" {
  name        = "${lower(var.name)}-public-sg"
  description = "Allow incoming connections"
  vpc_id      = data.aws_vpc.vpc_available.id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["103.171.59.0/24"]
    description = "Allow incoming RDP connections"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${lower(var.name)}-public-sg"
    env = "${var.name}"
  }
}
