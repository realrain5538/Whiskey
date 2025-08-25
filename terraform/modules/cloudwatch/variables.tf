variable "log_group_name" {
  type        = string
}

variable "log_retention_in_days" {
  type        = number
}

variable "ecs_cluster_name" {
  type        = string
}

variable "cpu_alarm_threshold" {
  type        = number
}

variable "memory_alarm_threshold" {
  type        = number
}

variable "tags" {
  type        = map(string)
}