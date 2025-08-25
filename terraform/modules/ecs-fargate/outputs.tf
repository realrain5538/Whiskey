output "ecs_cluster_id" {
  description = "ECS 클러스터의 ID입니다."
  value       = aws_ecs_cluster.main.id
}

output "alb_dns_name" {
  description = "ALB의 DNS 이름입니다."
  value       = aws_lb.main.dns_name
}

output "ecr_repository_url" {
  description = "ECR 리포지토리의 URL입니다."
  value       = aws_ecr_repository.app.repository_url
}