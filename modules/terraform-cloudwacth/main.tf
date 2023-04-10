
# resource "aws_sns_topic" "EC2_topic" {
#   name = "EC2_topic"
# }

# resource "aws_sns_topic_subscription" "EC2_Subscription" {
#   topic_arn = aws_sns_topic.EC2_topic.arn
#   protocol  = "email"
#   endpoint  = "keerthik.shenoy@42gears.com"

#   depends_on = [
#     aws_sns_topic.EC2_topic
#   ]

#   lifecycle {
#     prevent_destroy = false
#     create_before_destroy = true
#   }
# }
# Create a CloudWatch dashboard
resource "aws_cloudwatch_dashboard" "example" {
  dashboard_name = "Terraform_dashboard"

  # Define the layout of the dashboard
  dashboard_body = jsonencode({
    "widgets": [
      {
        "type": "metric",
        "x": 0,
        "y": 1,
        "width": 12,
        "height": 8,
        "properties": {
          "metrics": [
            ["AWS/EC2", "CPUUtilization", "InstanceId", "${data.terraform_remote_state.ec2.outputs.pluto_instance_id}", {"label": "InstanceName"}],
            ["AWS/EC2", "CPUUtilization", "InstanceId", "${data.terraform_remote_state.ec2.outputs.db_instance_id}", {"label": "InstanceName"}],
            ["AWS/EC2", "CPUUtilization", "InstanceId", "${data.terraform_remote_state.ec2.outputs.linux_instance_id}", {"label": "InstanceName"}]
          ],
          "view": "timeSeries",
          "stacked": false,
          "region": "ap-south-1",
          "title": "CPU Utilization"
        }
      },
      {
        "type": "metric",
        "x": 12,
        "y": 1,
        "width": 12,
        "height": 8,
        "properties": {
          "metrics": [
            ["CWAgent", "Memory Available MBytes", "InstanceId", "${data.terraform_remote_state.ec2.outputs.pluto_instance_id}", "InstanceType", "${data.terraform_remote_state.ec2.outputs.pluto_instance_type}", "ImageId","${data.terraform_remote_state.ec2.outputs.pluto_ami_id}", "objectname", "Memory"],
            ["CWAgent", "Memory Available MBytes", "InstanceId", "${data.terraform_remote_state.ec2.outputs.db_instance_id}", "ImageId","${data.terraform_remote_state.ec2.outputs.db_ami_id}", "objectname", "Memory"],
            ["CWAgent", "mem_used_percent", "InstanceId", "${data.terraform_remote_state.ec2.outputs.linux_instance_id}", "InstanceType", "${data.terraform_remote_state.ec2.outputs.linux_instance_type}", "ImageId", "${data.terraform_remote_state.ec2.outputs.linux_ami_id}"]
          ],
          "view": "timeSeries",
          "stacked": false,
          "region": "ap-south-1",
          "title": "Memory Utilization"
        }
      },
      {
        "type": "metric",
        "x": 12,
        "y": 1,
        "width": 12,
        "height": 8,
        "properties": {
          "metrics": [
            ["CWAgent", "LogicalDisk % Free Space", "InstanceId", "${data.terraform_remote_state.ec2.outputs.pluto_instance_id}", "InstanceType", "${data.terraform_remote_state.ec2.outputs.pluto_instance_type}", "ImageId","${data.terraform_remote_state.ec2.outputs.pluto_ami_id}", "objectname", "LogicalDisk", "instance", "C:"],
            ["CWAgent", "LogicalDisk % Free Space", "InstanceId", "${data.terraform_remote_state.ec2.outputs.db_instance_id}", "InstanceType", "${data.terraform_remote_state.ec2.outputs.db_instance_type}", "ImageId","${data.terraform_remote_state.ec2.outputs.db_ami_id}",  "objectname", "LogicalDisk", "instance", "C:"],
            ["CWAgent", "disk_used_percent", "InstanceId", "${data.terraform_remote_state.ec2.outputs.linux_instance_id}", "InstanceType", "${data.terraform_remote_state.ec2.outputs.linux_instance_type}", "ImageId", "${data.terraform_remote_state.ec2.outputs.linux_ami_id}","path", "/","fstype","xfs","device", "xvda1"]
          ],
          "view": "timeSeries",
          "stacked": false,
          "region": "ap-south-1",
          "title": "Disk Utilization"
        }
      }
    ]
  })
}


# resource "aws_cloudwatch_composite_alarm" "EC2" {
#   alarm_description = "Composite alarm that monitors CPU, Memory and Disk Utilization"
#   alarm_name        = "EC2_Composite_Alarm"
#   alarm_actions = [aws_sns_topic.EC2_topic.arn]

#   alarm_rule = "ALARM(${aws_cloudwatch_metric_alarm.EC2_CPU_Usage_Alarm.alarm_name}) OR ALARM(${aws_cloudwatch_metric_alarm.EC2_Memory_Usage_Alarm.alarm_name}) OR ALARM(${aws_cloudwatch_metric_alarm.EC2_Disk_Usage_Alarm.alarm_name})"

#   depends_on = [
#     aws_cloudwatch_metric_alarm.EC2_CPU_Usage_Alarm,
#     aws_cloudwatch_metric_alarm.EC2_Memory_Usage_Alarm,
#     aws_cloudwatch_metric_alarm.EC2_Disk_Usage_Alarm,
#     aws_sns_topic.EC2_topic,
#     aws_sns_topic_subscription.EC2_Subscription
#   ]
# }

# Creating the AWS CLoudwatch Alarm that will autoscale the AWS EC2 instance based on CPU utilization.
resource "aws_cloudwatch_metric_alarm" "Pluto_EC2_CPU_Usage_Alarm" {
  alarm_name          = "${var.name}-Pluto-CPU_Usage_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "70"
  alarm_description     = "This metric monitors ec2 cpu utilization exceeding 70%"
  alarm_actions       = [data.aws_sns_topic.ec2_topic.arn]
  dimensions = {
        InstanceId = data.terraform_remote_state.ec2.outputs.pluto_instance_id
      }
}

resource "aws_cloudwatch_metric_alarm" "Pluto_EC2_Memory_Usage_Alarm" {
  alarm_name          = "${var.name}-Pluto-Memory_Usage_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "Memory Available MBytes"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors EC2 memory utilization exceeding 80%"
  alarm_actions       = [data.aws_sns_topic.ec2_topic.arn]
  dimensions = {
        InstanceId = data.terraform_remote_state.ec2.outputs.pluto_instance_id
        InstanceType = data.terraform_remote_state.ec2.outputs.pluto_instance_type
        ImageId      = data.terraform_remote_state.ec2.outputs.pluto_ami_id
        objectname = "Memory"
      }
}

resource "aws_cloudwatch_metric_alarm" "Pluto_EC2_Disk_Usage_Alarm" {
  alarm_name          = "${var.name}-Pluto-Disk_Usage_Alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "LogicalDisk % Free Space"
  namespace           = "CWAgent"
  period              = "120"
  statistic           = "Average"
  threshold           = "60"
  alarm_description   = "This metric monitors EC2 disk utilization exceeding 80%"
  alarm_actions       = [data.aws_sns_topic.ec2_topic.arn]
  dimensions = {
        InstanceId = data.terraform_remote_state.ec2.outputs.pluto_instance_id
        InstanceType = data.terraform_remote_state.ec2.outputs.pluto_instance_type
        ImageId      = data.terraform_remote_state.ec2.outputs.pluto_ami_id
        instance = "C:"
        objectname = "LogicalDisk"
      }
}

resource "aws_cloudwatch_metric_alarm" "DB_EC2_CPU_Usage_Alarm" {
  alarm_name          = "${var.name}-DB-CPU_Usage_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "70"
  alarm_description     = "This metric monitors ec2 cpu utilization exceeding 70%"
  alarm_actions       = [data.aws_sns_topic.ec2_topic.arn]
  dimensions = {
        InstanceId = data.terraform_remote_state.ec2.outputs.db_instance_id
      }
}

resource "aws_cloudwatch_metric_alarm" "DB_EC2_Memory_Usage_Alarm" {
  alarm_name          = "${var.name}-DB-Memory_Usage_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "Memory Available MBytes"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors EC2 memory utilization exceeding 80%"
  alarm_actions       = [data.aws_sns_topic.ec2_topic.arn]
  dimensions = {
        InstanceId = data.terraform_remote_state.ec2.outputs.db_instance_id
        InstanceType = data.terraform_remote_state.ec2.outputs.db_instance_type
        ImageId      = data.terraform_remote_state.ec2.outputs.db_ami_id
        objectname = "Memory"
      }
}

resource "aws_cloudwatch_metric_alarm" "DB_EC2_Disk_Usage_Alarm" {
  alarm_name          = "${var.name}-DB-Disk_Usage_Alarm"
comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "LogicalDisk % Free Space"
  namespace           = "CWAgent"
  period              = "120"
  statistic           = "Average"
  threshold           = "60"
  alarm_description   = "This metric monitors EC2 disk utilization exceeding 80%"
  alarm_actions       = [data.aws_sns_topic.ec2_topic.arn]
  dimensions = {
        InstanceId = data.terraform_remote_state.ec2.outputs.db_instance_id
        InstanceType = data.terraform_remote_state.ec2.outputs.db_instance_type
        ImageId      = data.terraform_remote_state.ec2.outputs.db_ami_id
        instance = "C:"
        objectname = "LogicalDisk"
      }
}

resource "aws_cloudwatch_metric_alarm" "Linux_helper_CPU_Usage_Alarm" {
  alarm_name          = "${var.name}-Linux_helper-CPU_Usage_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "50"
  alarm_description     = "This metric monitors ec2 cpu utilization exceeding 70%"
  actions_enabled     = "true"
  alarm_actions       = [data.aws_sns_topic.ec2_topic.arn]
  insufficient_data_actions = []
  dimensions = {
        InstanceId = data.terraform_remote_state.ec2.outputs.linux_instance_id
      }
}

resource "aws_cloudwatch_metric_alarm" "Linux_helper_Memory_Usage_Alarm" {
  alarm_name          = "${var.name}-Linux_helper-Memory_Usage_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "30"
  alarm_description   = "This metric monitors EC2 memory utilization exceeding 80%"
  actions_enabled     = "true"
  alarm_actions       = [data.aws_sns_topic.ec2_topic.arn]
  insufficient_data_actions = []
  dimensions = {
        InstanceId = data.terraform_remote_state.ec2.outputs.linux_instance_id
        InstanceType = data.terraform_remote_state.ec2.outputs.linux_instance_type
        ImageId      = data.terraform_remote_state.ec2.outputs.linux_ami_id
        
      }
}

resource "aws_cloudwatch_metric_alarm" "linux_helper_EC2_Disk_Usage_Alarm" {
  alarm_name          = "${var.name}-Linux_helper-Disk_Usage_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  alarm_description   = "This metric monitors EC2 disk utilization exceeding 80%"
  actions_enabled     = "true"
  alarm_actions       = [data.aws_sns_topic.ec2_topic.arn]
  insufficient_data_actions = []
  dimensions = {
        InstanceId = data.terraform_remote_state.ec2.outputs.linux_instance_id
        InstanceType = data.terraform_remote_state.ec2.outputs.linux_instance_type
        ImageId      = data.terraform_remote_state.ec2.outputs.linux_ami_id
        path         = "/"
        fstype       = "xfs"
        device       = "xvda1"
      }
}

resource "aws_cloudwatch_metric_alarm" "pluto_ec2_status_check_alarm" {
  alarm_name          = "${var.name}-Pluto-Status_Check_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "This metric monitors ec2 instance status checks failing"
  alarm_actions       = [data.aws_sns_topic.ec2_topic.arn]
  dimensions = {
    InstanceId = data.terraform_remote_state.ec2.outputs.pluto_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "db_ec2_status_check_alarm" {
  alarm_name          = "${var.name}-db-Status_Check_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "This metric monitors ec2 instance status checks failing"
  alarm_actions       = [data.aws_sns_topic.ec2_topic.arn]
  dimensions = {
    InstanceId = data.terraform_remote_state.ec2.outputs.db_instance_id
  }
}
resource "aws_cloudwatch_metric_alarm" "linux_status_check_alarm" {
  alarm_name          = "${var.name}-Linux_Helper-Status_Check_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "This metric monitors ec2 instance status checks failing"
  alarm_actions       = [data.aws_sns_topic.ec2_topic.arn]
  dimensions = {
    InstanceId = data.terraform_remote_state.ec2.outputs.linux_instance_id
  }
}
# resource "aws_cloudwatch_log_group" "ebs_log_group" {
#   name = "ebs_log_group"
#   retention_in_days = 30
# }


# resource "aws_cloudwatch_log_stream" "ebs_log_stream" {
#   name           = "ebs_log_stream"
#   log_group_name = aws_cloudwatch_log_group.ebs_log_group.name
# }



