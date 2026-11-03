variable "aws_region" {
  type        = string
  description = "AWS region."
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Environment tier."
  default     = "prod"
}

variable "tags" {
  type = map(string)
  default = {
    Platform  = "MultiCloud-Automation"
    Cloud     = "AWS"
    ManagedBy = "Terraform"
  }
}
