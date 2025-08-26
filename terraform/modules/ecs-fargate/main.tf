# ECR Repository
resource "aws_ecr_repository" "app" {
  name                 = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = var.tags
}

# ECR Lifecycle Policy (오래된 이미지 정리)
resource "aws_ecr_lifecycle_policy" "app" {
  repository = aws_ecr_repository.app.name
  policy     = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last ${var.image_count_to_retain} images",
        selection = {
          tagStatus   = "any",
          countType   = "imageCountMoreThan",
          countNumber = var.image_count_to_retain,
        },
        action = {
          type = "expire",
        },
      },
    ],
  })
}

# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"
  tags = var.tags
}

# ECS Task Definition (Fargate)
# resource "aws_ecs_task_definition" "main" {
#   family                   = "${var.project_name}-task"
#   requires_compatibilities = ["FARGATE"]
#   network_mode             = "awsvpc"
#   cpu                      = var.task_cpu
#   memory                   = var.task_memory
#   execution_role_arn       = aws_iam_role.ecs_task_execution.arn
#   container_definitions    = jsonencode([
#     {
#       name      = "${var.project_name}-container",
#       image     = var.container_image,
#       cpu       = var.task_cpu,
#       memory    = var.task_memory,
#       essential = true,
#       portMappings = [
#         {
#           containerPort = var.container_port,
#           hostPort      = var.container_port,
#           protocol      = "tcp"
#         }
#       ],
#       environment = [
#         for key, value in var.environment_variables : {
#           name  = key,
#           value = value
#         }
#       ],
#       logConfiguration = {
#         logDriver = "awslogs",
#         options = {
#           "awslogs-group"         = var.log_group_name,
#           "awslogs-region"        = var.aws_region,
#           "awslogs-stream-prefix" = "ecs"
#         }
#       }
#     }
#   ])
#   tags = var.tags
# }

# IAM Role for ECS Task Execution
# resource "aws_iam_role" "ecs_task_execution" {
#   name = "${var.project_name}-ecs-task-execution-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "ecs-tasks.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# IAM Policy to allow ECR and CloudWatch access
# resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
#   role       = aws_iam_role.ecs_task_execution.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }

# 1. ALB 보안 그룹 생성
resource "aws_security_group" "alb" {
  name        = "${var.project_name}-alb-sg"
  description = "Security group for the Application Load Balancer"
  vpc_id      = var.vpc_id # VPC ID는 상위 모듈에서 전달받아야 합니다.

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. ECS 태스크 보안 그룹 생성
resource "aws_security_group" "ecs_tasks" {
  name        = "${var.project_name}-ecs-tasks-sg"
  description = "Security group for ECS Fargate tasks"
  vpc_id      = var.vpc_id

  # 인바운드 규칙: ALB로부터의 HTTP 트래픽만 허용
  ingress {
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  # 아웃바운드 규칙: 모든 트래픽 허용 (ECR, DynamoDB 등)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Application Load Balancer
resource "aws_lb" "main" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = [for subnet in var.public_subnets : subnet.cidr]
  security_groups    = [aws_security_group.alb.id]
  tags = var.tags
}

# Target Group
resource "aws_lb_target_group" "main" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    path     = "/"
    protocol = "HTTP"
  }
  tags = var.tags
}

# ALB Listener (HTTPS)
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.alb_listener_port
  protocol          = "HTTPS"
  certificate_arn   = var.alb_ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

# ECS Service
# resource "aws_ecs_service" "main" {
#   name            = "${var.project_name}-service"
#   cluster         = aws_ecs_cluster.main.id
#   task_definition = aws_ecs_task_definition.main.arn
#   desired_count   = var.desired_count
#   launch_type     = "FARGATE"
#
#   network_configuration {
#     subnets          = [for subnet in var.private_subnets : subnet.cidr]
#     security_groups  = [aws_security_group.ecs_tasks.id]
#     assign_public_ip = false
#   }
#
#   load_balancer {
#     target_group_arn = aws_lb_target_group.main.arn
#     container_name   = "${var.project_name}-container"
#     container_port   = var.container_port
#   }
#
#   depends_on = [
#     aws_lb_listener.https
#   ]
#   tags = var.tags
# }