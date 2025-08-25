variable "vpc_id" {
  type        = string
}

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

# variable "security_group_ids" {
#   type        = list(string)
# }

variable "ecr_repository_name" {
  type        = string
}

variable "image_tag" {
  type        = string
}

variable "image_count_to_retain" {
  type        = number
}

variable "container_image" {
  type        = string
}

variable "container_port" {
  type        = number
}

variable "task_cpu" {
  type        = number
}

variable "task_memory" {
  type        = number
}

variable "desired_count" {
  type        = number
}

variable "environment_variables" {
  description = "컨테이너에 전달할 환경 변수 맵입니다."
  type        = map(string)
  default     = {}
}

variable "target_group_name" {
  description = "ALB 타겟 그룹의 이름입니다."
  type        = string
}

variable "target_group_port" {
  description = "타겟 그룹이 트래픽을 수신하는 포트입니다."
  type        = number
}

variable "alb_listener_port" {
  description = "ALB 리스너 포트입니다."
  type        = number
}

variable "alb_ssl_certificate_arn" {
  type        = string
}

variable "alb_name" {
  type        = string
}

variable "log_group_name" {
  type        = string
}

variable "tags" {
  type        = map(string)
}

variable "aws_region" {
  type        = string
}

variable "project_name" {
  type        = string
}