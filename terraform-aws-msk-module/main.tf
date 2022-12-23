
# Create the MSK cluster
resource "aws_msk_cluster" "my_cluster" {
  cluster_name     = var.msk_cluster_name
  kafka_version = var.kafka_version
  number_of_broker_nodes = var.no_of_nodes
  enhanced_monitoring = "PER_BROKER"
  # encryption_in_transit = true
#   open_monitoring = ["prometheus"]
#   log_retention_hours = 24
#   iam_roles = [data.aws_iam_role.msk_role.arn]


  broker_node_group_info {
    client_subnets = [data.aws_subnet.subnet_1.id, data.aws_subnet.subnet_2.id]
    instance_type = var.kafka_intance_type
    security_groups = [aws_security_group.msk_cluster.id]
    # az_distribution = "BROKER_STICKINESS"
    ebs_volume_size = 20
    
  }


  encryption_info {
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster = true
    }
    # encryption_at_rest {
    #   data_volume_kms_key_id = "${var.kms_key.id}}"
    # }
  }
tags = {
    Name = var.msk_cluster_name
    Environment = var.environment
  }
}

# Create a security group for the MSK cluster
resource "aws_security_group" "msk_cluster" {
  name        = var.msk_security_group_name
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



