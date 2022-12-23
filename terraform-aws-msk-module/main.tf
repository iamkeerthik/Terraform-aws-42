
resource "aws_msk_configuration" "example" {
  name              = "example-config"
  kafka_versions    = ["2.6.0"]
  server_properties = <<EOF
auto.create.topics.enable=true
log.retention.hours=24
EOF
}

# Create the MSK cluster
resource "aws_msk_cluster" "my_cluster" {
  cluster_name           = var.msk_cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.no_of_nodes
  enhanced_monitoring    = "DEFAULT"
  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }
      node_exporter {
        enabled_in_broker = true
      }
    }
  }
  configuration_info {
    arn      = aws_msk_configuration.example.arn
    revision = 1
  }

  broker_node_group_info {
    client_subnets  = [data.aws_subnet.subnet_1.id, data.aws_subnet.subnet_2.id]
    instance_type   = var.kafka_intance_type
    security_groups = [aws_security_group.msk_cluster.id]
    storage_info {
      ebs_storage_info {
        volume_size = 20
      }
    }
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }
  tags = {
    Name        = var.msk_cluster_name
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



