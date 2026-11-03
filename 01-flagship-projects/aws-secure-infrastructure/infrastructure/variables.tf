variable "aws_region" {
  type        = string
  description = "Target AWS region for infrastructure deployment."
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Deployment environment (dev, staging, prod)."
  default     = "prod"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: 'dev', 'staging', or 'prod'."
  }
}

variable "project_name" {
  type        = string
  description = "Project name identifier for resource naming."
  default     = "secure-core"
}

variable "vpc_cidr" {
  type        = string
  description = "Base CIDR block for the AWS VPC."
  default     = "10.20.0.0/16"
}

variable "tags" {
  type        = map(string)
  description = "Standard resource tags for AWS FinOps and governance."
  default = {
    Environment = "production"
    ManagedBy   = "Terraform"
    Project     = "AWS-Secure-Infrastructure"
    Owner       = "Vikas-Rao"
    Compliance  = "CIS-AWS-Benchmark-v1.4"
  }
}

