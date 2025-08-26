output "cognito_user_pool_id" {
  description = "Cognito 사용자 풀의 ID입니다."
  value       = aws_cognito_user_pool.pool.id
}

output "cognito_app_client_id" {
  description = "Cognito 앱 클라이언트의 ID입니다."
  value       = aws_cognito_user_pool_client.client.id
}

# output "api_gateway_rest_api_id" {
#   description = "API Gateway REST API의 ID입니다."
#   value       = aws_api_gateway_rest_api.api.id
# }