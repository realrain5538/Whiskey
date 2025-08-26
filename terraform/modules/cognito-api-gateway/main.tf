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

# data "aws_route53_zone" "main" {
#   name = var.domain_name
# }

# # API Gateway REST API
# resource "aws_api_gateway_rest_api" "api" {
#   name        = var.api_gateway_name
#   description = "애플리케이션용 API Gateway"
#   tags        = var.tags
# }

# # API Gateway를 가리키는 Route 53 레코드
# resource "aws_route53_record" "api_gateway" {
#   zone_id = data.aws_route53_zone.main.zone_id
#   name    = var.api_gateway_domain_name
#   type    = "A"
#
#   alias {
#     name                   = aws_api_gateway_domain_name.custom_domain.regional_domain_name
#     zone_id                = aws_api_gateway_domain_name.custom_domain.regional_zone_id
#     evaluate_target_health = true
#   }
# }

# # API Gateway 커스텀 도메인
# resource "aws_api_gateway_domain_name" "custom_domain" {
#   domain_name     = var.api_gateway_domain_name
#   certificate_arn = var.api_gateway_acm_certificate_arn
#
#   endpoint_configuration {
#     types = ["REGIONAL"]
#   }
# }

# # API Gateway 배포
# # 이 리소스는 API의 변경 사항이 있을 때마다 새로운 배포를 트리거합니다.
# resource "aws_api_gateway_deployment" "deployment" {
#   rest_api_id = aws_api_gateway_rest_api.api.id
#
#   triggers = {
#     # API의 body가 변경될 때마다 배포가 새로 생성되도록 합니다.
#     redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api))
#   }
# }
#
# # API Gateway 스테이지
# # 배포된 API를 특정 스테이지(예: dev, prod)에 연결합니다.
# resource "aws_api_gateway_stage" "stage" {
#   deployment_id = aws_api_gateway_deployment.deployment.id
#   rest_api_id   = aws_api_gateway_rest_api.api.id
#   stage_name    = var.api_gateway_stage_name
#   tags          = var.tags
# }
#
# # 기본 경로 매핑
# resource "aws_api_gateway_base_path_mapping" "mapping" {
#   api_id      = aws_api_gateway_rest_api.api.id
#   stage_name  = aws_api_gateway_stage.stage.stage_name # stage_name을 직접 참조합니다.
#   domain_name = aws_api_gateway_domain_name.custom_domain.domain_name # 도메인 이름을 참조합니다.
# }