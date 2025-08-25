output "log_group_name" {
  description = "CloudWatch 로그 그룹의 이름입니다."
  value       = aws_cloudwatch_log_group.app.name
}

output "cpu_alarm_arn" {
  description = "CPU 알람의 ARN입니다."
  value       = aws_cloudwatch_metric_alarm.cpu_alarm.arn
}