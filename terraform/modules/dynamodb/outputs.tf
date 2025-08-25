output "dynamodb_table_name" {
  description = "DynamoDB 테이블의 이름입니다."
  value       = aws_dynamodb_table.sessions.name
}

output "dynamodb_table_arn" {
  description = "DynamoDB 테이블의 ARN입니다."
  value       = aws_dynamodb_table.sessions.arn
}