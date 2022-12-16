# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Create the MSK cluster
resource "aws_msk_cluster" "my_cluster" {
  cluster_name     = "my-cluster"
  kafka_version    = "2.8.0"
  number_of_broker_nodes = 3

  encryption_info {
    encryption_at_rest_kms_key_arn = "arn:aws:kms:us-east-1:1234567890:key/key-id"
  }

  kafka_settings {
    log_retention_hours = 24
  }

  vpc_id = data.aws_vpc.vpc_available.id
  subnet_ids = [data.aws_subnet.public_1.id, data.aws_subnet.public_2.id]

  tags = {
    Name = "suremdm-cluster"
  }
  iam_role {
    role_arn = var.msk_role.arn
  }
}

# Create a security group for the MSK cluster
resource "aws_security_group" "msk_cluster" {
  name        = "msk-cluster"
  description = "Security group for MSK cluster"
  vpc_id      = data.aws_vpc.vpc_available.id
  
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
}

# Associate the security group with the MSK cluster
resource "aws_msk_cluster_security_group_association" "cluster_sg_assoc" {
  cluster_arn = aws_msk_cluster.my_cluster.arn
  security_group_arn = aws_security_group.msk_cluster.arn
}

