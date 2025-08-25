variable "dynamodb_table_name" {
  type        = string
}

variable "dynamodb_partition_key" {
  type        = string
}

variable "dynamodb_partition_key_type" {
  type        = string
}

variable "dynamodb_capacity_mode" {
  type        = string
}

variable "tags" {
  type        = map(string)
}