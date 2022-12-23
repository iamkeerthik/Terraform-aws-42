
# Create EC2 Instance
resource "aws_instance" "pluto-server" {
  ami           = data.aws_ami.windows-2016.id
  instance_type = var.pluto_instance_type
  # iam_instance_profile        = data.aws_iam_instance_profile.instance_profile.role_name
  key_name = data.aws_key_pair.key.key_name
  # vpc_security_group_ids      = data.aws_security_groups.sg.ids
  vpc_security_group_ids      = [aws_security_group.aws-pluto-sg.id]
  subnet_id                   = data.aws_subnet.private.id
  associate_public_ip_address = var.windows_associate_public_ip_address
  source_dest_check           = false
  # key_name                    = aws_key_pair.key_pair.key_name
  # user_data                   = data.template_file.windows-userdata.rendered
  user_data = file("${path.module}/userdata.ps1")
  # root disk
  root_block_device {
    volume_size           = var.windows_root_volume_size
    volume_type           = var.windows_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  # # extra disk
  # ebs_block_device {
  #   device_name           = "/dev/xvda"
  #   volume_size           = var.windows_data_volume_size
  #   volume_type           = var.windows_data_volume_type
  #   encrypted             = true
  #   delete_on_termination = true
  # }

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-pluto-server"
    Environment = var.app_environment
  }
}


# Define the security group for the Windows server
resource "aws_security_group" "aws-pluto-sg" {
  name        = "${lower(var.app_name)}-${var.app_environment}-pluto-sg"
  description = "Allow incoming connections"
  vpc_id      = data.aws_vpc.vpc_available.id
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

  # ingress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   security_group_id   = "${data.aws_security_group.node-security.id}"
  #   source_security_group_id = "eks-sg"
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-pluto-sg"
    Environment = var.app_environment
  }
}


