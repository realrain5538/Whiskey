# VPC 모듈의 주요 출력값
output "vpc_id" {
  description = "생성된 VPC의 ID입니다."
  value       = module.vpc.vpc_id
}

# output "private_subnet_ids" {
#   description = "프라이빗 서브넷의 ID 리스트입니다."
#   value       = module.network.private_subnet_ids
# }

# output "public_subnet_ids" {
#   description = "퍼블릭 서브넷의 ID 리스트입니다."
#   value       = module.network.public_subnet_ids
# }

# ECS Fargate 모듈의 주요 출력값
# output "ecs_cluster_name" {
#   description = "생성된 ECS 클러스터의 이름입니다."
#   value       = module.ecs_fargate.ecs_cluster_name
# }

output "alb_dns_name" {
  description = "Application Load Balancer의 DNS 이름입니다."
  value       = module.ecs_fargate.alb_dns_name
}

# S3, CloudFront, Route 53 모듈의 주요 출력값
output "cloudfront_domain_name" {
  description = "CloudFront 배포 도메인 이름입니다."
  value       = module.s3_cloudfront_route53.cloudfront_domain_name
}

# DynamoDB 모듈의 주요 출력값
output "dynamodb_table_name" {
  description = "생성된 DynamoDB 테이블의 이름입니다."
  value       = module.dynamodb.dynamodb_table_name
}

# Cognito, API Gateway 모듈의 주요 출력값
# output "api_gateway_url" {
#   description = "API Gateway의 호출 URL입니다."
#   value       = module.cognito_api_gateway.api_gateway_url
# }