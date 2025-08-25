# AWS Provider 설정
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# 로컬 변수: 공통적으로 사용되는 태그를 정의합니다.
locals {
  common_tags = var.tags
}

# VPC 모듈 호출
module "vpc" {
  source = "./modules/vpc"

  # 입력 변수 전달
  vpc_cidr                     = var.vpc_cidr
  aws_region                   = var.aws_region
  tags                         = local.common_tags
  project_name                 = var.project_name
  vpc_endpoint_subnet_ids      = var.vpc_endpoint_subnet_ids
  # vpc_endpoint_security_group_ids = var.vpc_endpoint_security_group_ids
  ecr_api_endpoint_service_name = var.ecr_api_endpoint_service_name
  ecr_dkr_endpoint_service_name = var.ecr_dkr_endpoint_service_name
  prefix_list_id = var.prefix_list_id
}

module "network" {
  source = "./modules/network"

  # availability_zones = [var.availability_zones]
  environment    = var.environment
  prefix_list_id = module.vpc.prefix_list_id
  private_subnets = var.private_subnets
  project_name   = var.project_name
  s3_gateway_id  = var.s3_gateway_id
  tags = local.common_tags
  vpc_id         = var.vpc_id
  aws_internet_gateway_id = ""
  public_subnets = var.public_subnets
}

# S3, CloudFront, Route 53 모듈 호출
module "s3_cloudfront_route53" {
  source = "./modules/s3-cloudfront-route53"

  # 입력 변수 전달
  s3_bucket_name         = var.s3_bucket_name
  cloudfront_aliases     = var.cloudfront_aliases
  ssl_certificate_arn    = var.ssl_certificate_arn
  cloudfront_default_ttl = var.cloudfront_default_ttl
  cloudfront_oai_comment = var.cloudfront_oai_comment
  domain_name            = var.domain_name
  subdomain_name         = var.subdomain_name
  tags                   = local.common_tags
}

# Cognito, API Gateway 모듈 호출
module "cognito_api_gateway" {
  source = "./modules/cognito-api-gateway"

  # 입력 변수 전달
  cognito_user_pool_name          = var.cognito_user_pool_name
  cognito_app_client_name         = var.cognito_app_client_name
  cognito_domain_prefix           = var.cognito_domain_prefix
  cognito_callback_urls           = var.cognito_callback_urls
  cognito_logout_urls             = var.cognito_logout_urls
  api_gateway_name                = var.api_gateway_name
  api_gateway_stage_name          = var.api_gateway_stage_name
  api_gateway_domain_name         = var.api_gateway_domain_name
  api_gateway_acm_certificate_arn = var.api_gateway_acm_certificate_arn
  tags                            = local.common_tags
}

# DynamoDB 모듈 호출
module "dynamodb" {
  source = "./modules/dynamodb"

  # 입력 변수 전달
  dynamodb_table_name         = var.dynamodb_table_name
  dynamodb_partition_key      = var.dynamodb_partition_key
  dynamodb_partition_key_type = var.dynamodb_partition_key_type
  dynamodb_capacity_mode      = var.dynamodb_capacity_mode
  tags                        = local.common_tags
}

# CloudWatch 모듈 호출
module "cloudwatch" {
  source = "./modules/cloudwatch"

  # 입력 변수 전달
  log_group_name            = var.log_group_name
  log_retention_in_days     = var.log_retention_in_days
  ecs_cluster_name          = "${var.project_name}-cluster"
  cpu_alarm_threshold       = var.cpu_alarm_threshold
  memory_alarm_threshold    = var.memory_alarm_threshold
  tags                      = local.common_tags
}

# ECS Fargate 모듈 호출
module "ecs_fargate" {
  source = "./modules/ecs-fargate"

  # 다른 모듈의 출력값과 변수 전달
  vpc_id                = module.vpc.vpc_id
  private_subnets       = var.private_subnets
  # security_group_ids    = module.vpc.security_group_ids
  ecr_repository_name   = var.ecr_repository_name
  image_tag             = var.image_tag
  image_count_to_retain = var.image_count_to_retain
  container_image       = var.container_image
  container_port        = var.container_port
  task_cpu              = var.task_cpu
  task_memory           = var.task_memory
  desired_count         = var.desired_count
  environment_variables = var.environment_variables
  target_group_name     = var.target_group_name
  target_group_port     = var.target_group_port
  alb_listener_port     = var.alb_listener_port
  alb_ssl_certificate_arn = var.alb_ssl_certificate_arn
  alb_name              = var.alb_name
  log_group_name        = var.log_group_name
  tags                  = local.common_tags
  aws_region            = var.aws_region
  project_name          = var.project_name
  public_subnets        = var.public_subnets
}