# Cognito 사용자 풀
resource "aws_cognito_user_pool" "pool" {
  name = var.cognito_user_pool_name
  tags = var.tags
}

# Cognito 사용자 풀 도메인
resource "aws_cognito_user_pool_domain" "domain" {
  domain       = var.cognito_domain_prefix
  user_pool_id = aws_cognito_user_pool.pool.id
}

# Cognito 사용자 풀 앱 클라이언트
resource "aws_cognito_user_pool_client" "client" {
  name                              = var.cognito_app_client_name
  user_pool_id                      = aws_cognito_user_pool.pool.id
  callback_urls                     = var.cognito_callback_urls
  logout_urls                       = var.cognito_logout_urls
  supported_identity_providers      = ["COGNITO"]
  explicit_auth_flows               = ["ALLOW_ADMIN_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
}

# API Gateway REST API
resource "aws_api_gateway_rest_api" "api" {
  name        = var.api_gateway_name
  description = "애플리케이션용 API Gateway"
  tags        = var.tags
}

# API Gateway 커스텀 도메인
resource "aws_api_gateway_domain_name" "custom_domain" {
  domain_name              = var.api_gateway_domain_name
  certificate_arn          = var.api_gateway_acm_certificate_arn
}

# 기본 경로 매핑
resource "aws_api_gateway_base_path_mapping" "mapping" {
  api_id      = aws_api_gateway_rest_api.api.id
  stage_name  = var.api_gateway_stage_name
  domain_name = aws_api_gateway_domain_name.custom_domain.id
}