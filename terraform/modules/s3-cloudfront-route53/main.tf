# 정적 웹사이트용 S3 버킷
resource "aws_s3_bucket" "website" {
  bucket = var.s3_bucket_name
  tags   = var.tags
}

# CloudFront Origin Access Identity (OAI)
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = var.cloudfront_oai_comment
}

# OAI 접근을 허용하는 S3 버킷 정책
resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.website.arn}/*"
      }
    ]
  })
}

# CloudFront 배포
resource "aws_cloudfront_distribution" "website" {
  enabled             = true
  aliases             = var.cloudfront_aliases
  comment             = "CloudFront for ${var.s3_bucket_name}"
  default_root_object = "index.html"

  origin {
    domain_name              = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id                = aws_s3_bucket.website.id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.website.id
    viewer_protocol_policy = "redirect-to-https"
    min_ttl     = 0
    default_ttl = var.cloudfront_default_ttl
    max_ttl     = var.cloudfront_default_ttl
    compress    = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.ssl_certificate_arn
    ssl_support_method  = "sni-only"
  }
}

# Route 53 호스팅 영역 데이터 소스
data "aws_route53_zone" "main" {
  name = var.domain_name
}

# CloudFront 배포를 가리키는 Route 53 레코드 세트
resource "aws_route53_record" "website" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${var.subdomain_name}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.website.domain_name
    zone_id                = aws_cloudfront_distribution.website.hosted_zone_id
    evaluate_target_health = true
  }
}