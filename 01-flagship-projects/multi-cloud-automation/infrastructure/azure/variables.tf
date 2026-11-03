variable "location" {
  type        = string
  description = "Azure region."
  default     = "eastus"
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
    Cloud     = "Azure"
    ManagedBy = "Terraform"
  }
}
