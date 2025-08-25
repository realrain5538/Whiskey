output "cloudfront_domain_name" {
  description = "CloudFront 배포의 도메인 이름입니다."
  value       = aws_cloudfront_distribution.website.domain_name
}

output "s3_bucket_id" {
  description = "생성된 S3 버킷의 ID입니다."
  value       = aws_s3_bucket.website.id
}