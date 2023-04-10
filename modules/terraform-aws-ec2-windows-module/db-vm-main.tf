###################################
## Virtual Machine Module - Main ##
###################################

# Create EC2 Instance
resource "aws_instance" "db-server" {
  ami                         = data.aws_ami.windows-2019.id
  instance_type               = var.db_instance_type
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  key_name                    = data.aws_key_pair.key.key_name
  vpc_security_group_ids      = [data.aws_security_group.db_security_group.id]
  subnet_id                   = data.aws_subnet.private.id
  associate_public_ip_address = var.windows_associate_public_ip_address
  source_dest_check           = false
  # user_data = file("${path.module}/db-userdata.ps1")
  user_data                   = var.db_user_data
  disable_api_termination     = var.termination_protection

  # root disk
  root_block_device {
    volume_size           = var.db_root_volume_size
    volume_type           = var.db_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  # extra disk
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = var.windows_data_volume_size
    volume_type           = var.windows_data_volume_type
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "${lower(var.name)}-db-server",
    env = "${var.name}"
  }
}


