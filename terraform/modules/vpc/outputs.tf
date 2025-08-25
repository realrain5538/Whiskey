output "vpc_id" {
  description = "생성된 VPC의 ID입니다."
  value       = aws_vpc.main.id
}

output "private_subnets" {
  description = "VPC Endpoint용으로 사용된 프라이빗 서브넷 목록입니다."
  value       = var.vpc_endpoint_subnet_ids
}

output "security_group_ids" {
  description = "VPC Endpoint용으로 사용된 보안 그룹 ID 목록입니다."
  value       = var.vpc_endpoint_security_group_ids
}

output "prefix_list_id" {
  description = "VPC s3 Endpoint prefix_list_id"
  value       = aws_vpc_endpoint.s3_gateway.prefix_list_id
}

output "s3_gateway_id" {
  description = "VPC s3 Endpoint id"
  value = aws_vpc_endpoint.s3_gateway.id
}

output "aws_internet_gateway_id" {
  value = aws_internet_gateway.main.id
}