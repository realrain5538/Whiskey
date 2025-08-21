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
  default     = "realrain"
}

variable "tags" {
  description = "A map of tags"
  type        = map(string)
  default     = {
    "Environment" = "dev"
    "Project"     = "realrain"
    "Owner"       = "realrain"
  }
}

variable "container_port" {
	default = 80
}

variable "cloudfront_oai_comment" {
  description = "The comment for the CloudFront Origin Access Identity."
  default     = "OAI for my website"
}

variable "s3_bucket_name" {
  description = "The name for the S3 bucket to host the static website."
  default     = "realrain-bucket"
}
