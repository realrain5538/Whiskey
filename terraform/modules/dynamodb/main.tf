resource "aws_dynamodb_table" "sessions" {
  name         = var.dynamodb_table_name
  billing_mode = var.dynamodb_capacity_mode
  hash_key     = var.dynamodb_partition_key

  attribute {
    name = var.dynamodb_partition_key
    type = var.dynamodb_partition_key_type
  }
  tags = var.tags
}