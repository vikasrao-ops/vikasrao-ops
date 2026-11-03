variable "subnet_id" {
  type        = string
  description = "Target public subnet ID for Bastion."
}

variable "security_group_id" {
  type        = string
  description = "Bastion security group ID."
}

variable "instance_profile" {
  type        = string
  description = "IAM instance profile name for SSM access."
}

variable "project_name" {
  type        = string
  description = "Project name prefix."
}

variable "environment" {
  type        = string
  description = "Environment identifier."
}

