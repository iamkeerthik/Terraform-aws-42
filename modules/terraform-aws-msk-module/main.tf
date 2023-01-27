
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

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  bucket = aws_s3_bucket.logs_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
resource "aws_s3_bucket_lifecycle_configuration" "Expiry" {
  bucket = aws_s3_bucket.logs_bucket.id

  rule {
    id      = "Expiry"
    status  = "Enabled"
    filter {
      prefix = "logs"
    }
    expiration {
      days = 60
    }
  }
}
# Create the MSK cluster
resource "aws_msk_cluster" "my_cluster" {
  cluster_name           = var.msk_cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.no_of_nodes
  enhanced_monitoring    = "PER_TOPIC_PER_BROKER" #available options PER_BROKER, DEFAULT #for stage DEFAULT
  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = var.open_monitoring
      }
      node_exporter {
        enabled_in_broker = var.open_monitoring
      }
    }
  }
  configuration_info {
    # arn      = var.aws_msk_configuration_arn
    arn      = aws_msk_configuration.example.arn
    revision = var.config_revision
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

