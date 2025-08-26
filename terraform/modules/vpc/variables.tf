variable "vpc_cidr" {
  type        = string
}

variable "aws_region" {
  type        = string
}

variable "tags" {
  type        = map(string)
}

variable "vpc_endpoint_subnet_ids" {
  type        = list(string)
}

# variable "vpc_endpoint_security_group_ids" {
#   type        = list(string)
# }
variable "project_name" {}

variable "ecr_api_endpoint_service_name" {}
variable "ecr_dkr_endpoint_service_name" {}

variable "prefix_list_id" {
  type = string
}

variable "s3_gateway_id" {
  description = "VPC s3 Endpoint id"
  type = string
}