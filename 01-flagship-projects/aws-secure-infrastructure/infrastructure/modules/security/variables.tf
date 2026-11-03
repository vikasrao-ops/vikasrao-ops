variable "vpc_id" {
  type        = string
  description = "Target VPC ID for security groups."
}

variable "project_name" {
  type        = string
  description = "Project name prefix."
}

variable "environment" {
  type        = string
  description = "Environment identifier."
}

