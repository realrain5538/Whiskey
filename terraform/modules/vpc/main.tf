# VPC 생성
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(var.tags, {
    Name = "${var.project_name}-vpc"
  })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

# ECR VPC 엔드포인트 보안 그룹 생성
# 이 보안 그룹은 Fargate 태스크가 ECR에 접근하는 것을 허용합니다.
resource "aws_security_group" "vpc_endpoint" {
  name        = "${var.project_name}-ecr-vpc-endpoint-sg"
  description = "Security group for ECR VPC endpoints."
  vpc_id      = aws_vpc.main.id

  # 인바운드 규칙: ECS Fargate 태스크의 보안 그룹으로부터 HTTPS(443) 트래픽 허용
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    # ECS Fargate 태스크가 속한 보안 그룹 ID를 여기에 참조해야 합니다.
    # 예: security_groups = [aws_security_group.ecs_tasks.id]
  }

  # 아웃바운드 규칙: 모든 트래픽 허용 (선택 사항)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-ecr-endpoint-sg"
  }
}

# ECR API VPC 엔드포인트 생성
resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = aws_vpc.main.id
  service_name      = var.ecr_api_endpoint_service_name
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids        = var.vpc_endpoint_subnet_ids
  security_group_ids = [aws_security_group.vpc_endpoint.id]
  tags = merge(var.tags, {
    Name = "ecr-api-endpoint"
  })
}

# ECR DKR VPC 엔드포인트 생성
resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = aws_vpc.main.id
  service_name      = var.ecr_dkr_endpoint_service_name
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids        = var.vpc_endpoint_subnet_ids
  security_group_ids = [aws_security_group.vpc_endpoint.id]
  tags = merge(var.tags, {
    Name = "ecr-dkr-endpoint"
  })
}

resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.s3"
}