
resource "aws_sns_topic" "EC2_topic" {
  name = "EC2_topic"
}

resource "aws_sns_topic_subscription" "EC2_Subscription" {
  topic_arn = aws_sns_topic.EC2_topic.arn
  protocol  = "email"
  endpoint  = "keerthik.shenoy@42gears.com"

  depends_on = [
    aws_sns_topic.EC2_topic
  ]
}

resource "aws_cloudwatch_dashboard" "EC2_Dashboard" {
  dashboard_name = "EC2-Dashboard"

  dashboard_body = <<EOF
{
    "widgets": [
        {
            "type": "explorer",
            "width": 24,
            "height": 15,
            "x": 0,
            "y": 0,
            "properties": {
                "metrics": [
                    {
                        "metricName": "CPUUtilization",
                        "resourceType": "AWS::EC2::Instance",
                        "stat": "Maximum"
                    },
                    {
                        "metricName": "MemoryUtilization",
                        "resourceType": "AWS::EC2::Instance",
                        "namespace": "CWAgent",
                        "dimensions": [
                            {
                                "name": "InstanceId",
                                "value": "i-02a3c8a90314dea52"
                            }
                        ],
                        "stat": "Maximum"
                    },
                    {
                        "metricName": "DiskSpaceUtilization",
                        "resourceType": "AWS::EC2::Instance",
                        "namespace": "CWAgent",
                        "dimensions": [
                            {
                                "name": "InstanceId",
                                "value": "i-02a3c8a90314dea52"
                            }
                        ],
                        "stat": "Maximum"
                    }
                ],
                "aggregateBy": {
                    "key": "InstanceType",
                    "func": "MAX"
                },
                "labels": [
                    {
                        "key": "State",
                        "value": "running"
                    }
                ],
                "widgetOptions": {
                    "legend": {
                        "position": "bottom"
                    },
                    "view": "timeSeries",
                    "rowsPerPage": 8,
                    "widgetsPerRow": 2
                },
                "period": 60,
                "title": "Running EC2 Instances Utilization"
            }
        }
    ]
}
EOF
}

resource "aws_cloudwatch_composite_alarm" "EC2" {
  alarm_description = "Composite alarm that monitors CPU, Memory and Disk Utilization"
  alarm_name        = "EC2_Composite_Alarm"
  alarm_actions = [aws_sns_topic.EC2_topic.arn]

  alarm_rule = "ALARM(${aws_cloudwatch_metric_alarm.EC2_CPU_Usage_Alarm.alarm_name}) OR ALARM(${aws_cloudwatch_metric_alarm.EC2_Memory_Usage_Alarm.alarm_name}) OR ALARM(${aws_cloudwatch_metric_alarm.EC2_Disk_Usage_Alarm.alarm_name})"

  depends_on = [
    aws_cloudwatch_metric_alarm.EC2_CPU_Usage_Alarm,
    aws_cloudwatch_metric_alarm.EC2_Memory_Usage_Alarm,
    aws_cloudwatch_metric_alarm.EC2_Disk_Usage_Alarm,
    aws_sns_topic.EC2_topic,
    aws_sns_topic_subscription.EC2_Subscription
  ]
}

# Creating the AWS CLoudwatch Alarm that will autoscale the AWS EC2 instance based on CPU utilization.
resource "aws_cloudwatch_metric_alarm" "EC2_CPU_Usage_Alarm" {
  alarm_name          = "EC2_CPU_Usage_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "70"
alarm_description     = "This metric monitors ec2 cpu utilization exceeding 70%"
alarm_actions       = [aws_sns_topic.EC2_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "EC2_Memory_Usage_Alarm" {
  alarm_name          = "EC2_Memory_Usage_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryUtilization"
  namespace           = "System/Linux"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors EC2 memory utilization exceeding 80%"
  alarm_actions       = [aws_sns_topic.EC2_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "EC2_Disk_Usage_Alarm" {
  alarm_name          = "EC2_Disk_Usage_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors EC2 disk utilization exceeding 80%"
  alarm_actions       = [aws_sns_topic.EC2_topic.arn]
}


resource "aws_cloudwatch_log_group" "ebs_log_group" {
  name = "ebs_log_group"
  retention_in_days = 30
}


resource "aws_cloudwatch_log_stream" "ebs_log_stream" {
  name           = "ebs_log_stream"
  log_group_name = aws_cloudwatch_log_group.ebs_log_group.name
}



