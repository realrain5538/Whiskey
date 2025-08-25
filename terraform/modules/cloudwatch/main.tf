# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "app" {
  name              = var.log_group_name
  retention_in_days = var.log_retention_in_days
  tags              = var.tags
}

# CloudWatch CPU Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "${var.ecs_cluster_name}-cpu-high-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.cpu_alarm_threshold
  alarm_description   = "이 알람은 ECS CPU 사용률을 모니터링합니다."

  dimensions = {
    ClusterName = var.ecs_cluster_name
  }
}

# CloudWatch Memory Utilization Alarm
resource "aws_cloudwatch_metric_alarm" "memory_alarm" {
  alarm_name          = "${var.ecs_cluster_name}-memory-high-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.memory_alarm_threshold
  alarm_description   = "이 알람은 ECS 메모리 사용률을 모니터링합니다."

  dimensions = {
    ClusterName = var.ecs_cluster_name
  }
}