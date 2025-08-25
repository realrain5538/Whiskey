variable "s3_bucket_name" {
  type        = string
}

variable "cloudfront_aliases" {
  type        = list(string)
}

variable "ssl_certificate_arn" {
  type        = string
}

variable "cloudfront_default_ttl" {
  type        = number
}

variable "cloudfront_oai_comment" {
  type        = string
}

variable "domain_name" {
  type        = string
}

variable "subdomain_name" {
  type        = string
}

variable "tags" {
  type        = map(string)
}