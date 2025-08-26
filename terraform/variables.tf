variable "environment" {
  description = "The deployment environment (e.g., 'prod', 'dev', 'staging')."
  default     = "dev"
}

variable "project_name" {
  description = "project name"
  default     = "i-love-whiskey"
}

variable "tags" {
  description = "A map of tags"
  type        = map(string)
  default     = {
    "Environment" = "dev"
    "Project"     = "i-love-whiskey"
    "Owner"       = "realrain"
  }
}

#region
variable "aws_region" {
  default = "ap-northeast-2"
  validation {
    condition     = contains(["ap-northeast-2"], var.aws_region)
    error_message = "AWS 리전은 'ap-northeast-2'만 사용합니다."
  }
}

#vpc
variable "vpc_cidr" {
	default = "10.3.0.0/16"
}

variable "vpc_id" {
  type = string
}

variable "ecr_api_endpoint_service_name" {
  description = "The service name for the ECR API VPC Endpoint."
  default     = "com.amazonaws.ap-northeast-2.ecr.api"
}

variable "ecr_dkr_endpoint_service_name" {
  description = "The service name for the ECR Docker registry VPC Endpoint."
  default     = "com.amazonaws.ap-northeast-2.ecr.dkr"
}

variable "vpc_endpoint_subnet_ids" {
  description = "A list of private subnet IDs for the VPC Endpoints."
  type        = list(string)
  default = ["10.3.0.0/19","10.3.64.0/19"]
}

variable "aws_internet_gateway_id" {
  description = "The id of the internet gateway."
  type = string
}

#network
variable "public_subnets" {
  description = "The list of public subnet IDs for Fargate tasks"
  type        = map(object({
    az_name = string
    cidr    = string
  }))
  default = {
    "public_a_1" = {
      az_name = "ap-northeast-2a"
      cidr    = "10.3.32.0/19"
    }
    "public_c_1" = {
      az_name = "ap-northeast-2c"
      cidr    = "10.3.96.0/19"
    }
  }
}

variable "private_subnets" {
  description = "The list of private subnet IDs for Fargate tasks"
  type        = map(object({
    az_name = string
    cidr    = string
  }))
  default = {
    "private_a_1" = {
      az_name = "ap-northeast-2a"
      cidr    = "10.3.0.0/19"
    }
    "private_c_1" = {
      az_name = "ap-northeast-2c"
      cidr    = "10.3.64.0/19"
    }
  }
}

variable "availability_zones" {
  description = "A list of Availability Zones to use."
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}

# variable "vpc_endpoint_security_group_ids" {
#   description = "A list of security group IDs for the VPC Endpoints."
#   type        = list(string)
# }

variable "prefix_list_id" {
  description = "VPC s3 Endpoint prefix_list_id"
  type = string
}

variable "s3_gateway_id" {
  description = "VPC s3 Endpoint id"
  type = string
}

# s3
variable "s3_bucket_name" {
  description = "The name for the S3 bucket to host the static website."
  default     = "i-love-whiskey-bucket"
}

# cloudfront
variable "cloudfront_aliases" {
  description = "A list of alternate domain names to associate with the distribution."
  type        = list(string)
  default     = ["whiskey.nextcloudlab.com"]
}

variable "ssl_certificate_arn" {
  description = "The ARN of the ACM certificate for HTTPS."
}

variable "cloudfront_default_ttl" {
  description = "The default time-to-live for CloudFront cache."
  default     = 3600
}

variable "cloudfront_oai_comment" {
  description = "The comment for the CloudFront Origin Access Identity."
  default     = "OAI for my website"
}

# route 53
variable "domain_name" {
  description = "domain name"
  default     = "nextcloudlab.com"
}

variable "subdomain_name" {
  default = "whiskey"
}

variable "api_gateway_subdomain_name" {
  default = "api.whiskey"
}

# cognito
variable "cognito_user_pool_name" {
  description = "The name for the Cognito User Pool."
  default     = "i-love-whiskey-UserPool"
}

variable "cognito_app_client_name" {
  description = "The name for the Cognito User Pool App Client."
  default     = "i-love-whiskey-AppClient"
}

variable "cognito_domain_prefix" {
  description = "The domain prefix for the Cognito User Pool."
  default     = "whiskey"
}

variable "cognito_callback_urls" {
  description = "A list of callback URLs for the app client."
  type        = list(string)
  default     = ["http://localhost:3000/callback"]
}

variable "cognito_logout_urls" {
  description = "A list of logout URLs for the app client."
  type        = list(string)
  default     = ["http://localhost:3000/logout"]
}

# api gateway
variable "api_gateway_name" {
  description = "The name for the API Gateway."
  default     = "i-love-whiskey-API"
}

variable "api_gateway_stage_name" {
  description = "The name of the API Gateway stage."
  default     = "dev"
}

variable "api_gateway_domain_name" {
  description = "The custom domain name for the API Gateway."
  default     = "api.whiskey.nextcloudlab.com"
}

variable "api_gateway_acm_certificate_arn" {
  description = "The ARN of the ACM certificate for the custom domain."
}

variable "lambda_function_name" {
  description = "The name of the backend Lambda function."
  default     = "i-love-whiskey-lambda"
}

# ECR
variable "ecr_repository_name" {
  description = "The name for the ECR repository."
  default     = "i-love-whiskey"
}

variable "image_tag" {
  description = "The tag for the Docker image (e.g., 'latest', 'v1.0.0')."
  default     = "latest"
}

variable "image_count_to_retain" {
  description = "The number of images to retain in the repository."
  default     = 5
}

# ECS - fargate
variable "container_image" {
  description = "Docker image for the application"
  type        = string
}

variable "container_port" {
  description = "Port the container will expose"
  type        = number
  default = 80
}

variable "task_cpu" {
  description = "CPU units for the Fargate task (1024 = 1 vCPU)"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Memory for the Fargate task (GB)"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "The number of desired tasks"
  type        = number
  default     = 2
}

variable "environment_variables" {
  description = "A map of environment variables to pass to the container"
  type        = map(string)
  default     = {}
}

# variable "security_group_ids" {
#   description = "The list of security group IDs for Fargate tasks"
#   type        = list(string)
# }

# target group
variable "target_group_name" {
  description = "The name for the ALB Target Group."
  default     = "i-love-whiskey-tg"
}

variable "target_group_port" {
  description = "The port on which the targets receive traffic."
  default     = 80
}

# ALB
variable "alb_name" {
  description = "The name for the Application Load Balancer."
  default     = "i-love-whiskey-alb"
}

variable "alb_listener_port" {
  description = "The listener port for the ALB."
  default     = 80
}

variable "alb_ssl_certificate_arn" {
  description = "The ARN of the ACM certificate for HTTPS listener."
  default     = "arn:aws:acm:ap-northeast-2:077672914621:certificate/59c563eb-95dd-41ff-bd65-ec52b9271c22"
}

# DynamoDB
variable "dynamodb_table_name" {
  description = "The name for the DynamoDB table."
  default     = "i-love-whiskey-table"
}

variable "dynamodb_partition_key" {
  description = "The name of the primary partition key."
  default     = "id"
}

variable "dynamodb_partition_key_type" {
  description = "The type of the primary partition key (S, N, or B)."
  default     = "S"
}

variable "dynamodb_capacity_mode" {
  description = "The capacity mode for the table (PROVISIONED or PAY_PER_REQUEST)."
  default     = "PAY_PER_REQUEST" # 온디맨드 모드 (PAY_PER_REQUEST) 사용
}

# cloudWatch
variable "log_group_name" {
  description = "The name of the CloudWatch Log Group for the application."
  default     = "/aws/fargate/i-love-whiskey"
}

variable "log_retention_in_days" {
  description = "The number of days to retain log events."
  default     = 30
}

variable "cpu_alarm_threshold" {
  description = "The CPU utilization threshold for the alarm."
  default     = 80
}

variable "memory_alarm_threshold" {
  description = "The memory utilization threshold for the alarm."
  default     = 80
}
