variable "location" {
  type        = string
  description = "Azure region."
  default     = "eastus"
}

variable "environment" {
  type        = string
  description = "Deployment tier."
  default     = "poc"
}

variable "tags" {
  type        = map(string)
  default = {
    Environment = "POC"
    ManagedBy   = "Terraform"
    Project     = "Azure-Terraform-POC"
  }
}

