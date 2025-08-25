variable "private_subnets" {
  type        = map(object({
    az_name = string
    cidr    = string
  }))
}

variable "public_subnets" {
  type        = map(object({
    az_name = string
    cidr    = string
  }))
}

# variable "availability_zones" {
#   type        = list(string)
# }

variable "tags" {
  type        = map(string)
}
variable "project_name" {
  type        = string
}

variable "environment" {
  type        = string
}

variable "vpc_id" {
  type        = string
}

variable "prefix_list_id" {
  type        = string
}

variable "s3_gateway_id" {
  type        = string
}

variable "aws_internet_gateway_id" {
  description = "The id of the internet gateway."
  type = string
}