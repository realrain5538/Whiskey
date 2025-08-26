# 이 파일은 variables.tf에 정의된 변수들의 실제 값을 설정합니다.
# 변수 이름과 값은 일치해야 하며, 문자열은 ""로 묶어줍니다.

# General
environment  = "dev"
project_name = "i-love-whiskey"
tags = {
  Environment = "dev"
  Project     = "i-love-whiskey"
  Owner       = "realrain"
}

# AWS Region (기본값과 동일하므로 변경 불필요 시 주석 처리)
# aws_region = "ap-northeast-2"

# VPC (필수 입력 변수)
# vpc_cidr = "10.3.0.0/16" # 기본값 사용

# S3 (기본값 사용)
# s3_bucket_name = "i-love-whiskey-bucket"

# CloudFront
# cloudfront_aliases = ["whiskey.nextcloudlab.com"]
ssl_certificate_arn = "arn:aws:acm:ap-northeast-2:077672914621:certificate/59c563eb-95dd-41ff-bd65-ec52b9271c22"

# Route 53 (기본값 사용)
# domain_name    = "nextcloudlab.com"
# subdomain_name = "whiskey"

# Cognito (실제 URL로 교체)
cognito_callback_urls = ["https://whiskey.nextcloudlab.com/callback"]
cognito_logout_urls   = ["https://whiskey.nextcloudlab.com/logout"]

# API Gateway (기본값 사용)
# api_gateway_domain_name         = "api.whiskey.nextcloudlab.com"
api_gateway_acm_certificate_arn = "arn:aws:acm:ap-northeast-2:077672914621:certificate/ac0d8ecc-1cac-471e-8418-4ef8755363a3"

# ECR (기본값 사용)
# ecr_repository_name = "i-love-whiskey"

# ECS - Fargate (필수 입력 변수)

# DynamoDB (기본값 사용)
# dynamodb_table_name = "my-app-session-table"

# CloudWatch (기본값 사용)
# log_group_name = "/aws/fargate/my-app"