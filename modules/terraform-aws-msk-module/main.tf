
resource "aws_msk_configuration" "example" {
  name              = "example-config"
  kafka_versions    = ["2.6.0"]
  server_properties = <<EOF
auto.create.topics.enable=true
log.retention.hours=24
EOF
}

# Create S3 Bucket for logging
resource "aws_s3_bucket" "logs_bucket" {
  bucket = "msk-logs-${var.msk_cluster_name}"
}

# Create the MSK cluster
resource "aws_msk_cluster" "my_cluster" {
  cluster_name           = var.msk_cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.no_of_nodes
  enhanced_monitoring    = "PER_TOPIC_PER_BROKER" #available options PER_BROKER, DEFAULT
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
    security_groups = [data.aws_security_group.msk_sg.id]
    storage_info {
      ebs_storage_info {
        volume_size = var.volume_size
      }
    }
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }

  logging_info {
    broker_logs {
      s3 {
        enabled = true
        bucket  = aws_s3_bucket.logs_bucket.bucket
        prefix  = "logs"
      }
    }
  }

  tags = {
    Name        = var.msk_cluster_name
    Environment = var.environment
  }
}

