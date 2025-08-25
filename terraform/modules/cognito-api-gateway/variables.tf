variable "cognito_user_pool_name" {
  type        = string
}

variable "cognito_app_client_name" {
  type        = string
}

variable "cognito_domain_prefix" {
  type        = string
}

variable "cognito_callback_urls" {
  type        = list(string)
}

variable "cognito_logout_urls" {
  type        = list(string)
}

variable "api_gateway_name" {
  type        = string
}

variable "api_gateway_stage_name" {
  type        = string
}

variable "api_gateway_domain_name" {
  type        = string
}

variable "api_gateway_acm_certificate_arn" {
  type        = string
}

variable "tags" {
  type        = map(string)
}