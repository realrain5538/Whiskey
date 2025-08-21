variable "aws_region" {
	default = "ap-northeast-2"
}

variable "vpc_cidr" {
	default = "10.3.0.0/16"
}

variable "private_subnets" {
	default = [
	"10.3.0.0/19",
	"10.3.32.0/19",
	"10.3.64.0/19",
	"10.3.96.0/19"
	]
}

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

variable "container_port" {
	default = 80
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
  default     = "arn:aws:acm:ap-northeast-2:077672914621:certificate/59c563eb-95dd-41ff-bd65-ec52b9271c22"
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
  default     = "arn:aws:acm:ap-northeast-2:077672914621:certificate/59c563eb-95dd-41ff-bd65-ec52b9271c22"
}

variable "lambda_function_name" {
  description = "The name of the backend Lambda function."
  default     = "i-love-whiskey-lambda"
}