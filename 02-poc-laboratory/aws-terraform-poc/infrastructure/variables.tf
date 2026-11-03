variable "aws_region" {
  type        = string
  description = "AWS region."
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Environment tier."
  default     = "poc"
}

variable "tags" {
  type        = map(string)
  default = {
    Environment = "POC"
    ManagedBy   = "Terraform"
    Project     = "AWS-Terraform-POC"
  }
}

