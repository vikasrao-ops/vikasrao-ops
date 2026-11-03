variable "vpc_cidr" {
  type        = string
  description = "CIDR range for the VPC."
}

variable "project_name" {
  type        = string
  description = "Project prefix for resource naming."
}

variable "environment" {
  type        = string
  description = "Environment identifier."
}

