variable "environment" {
  type        = string
  description = "Target deployment environment tier (dev, staging, prod)."
  default     = "prod"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: 'dev', 'staging', or 'prod'."
  }
}

variable "location" {
  type        = string
  description = "Primary Azure region for landing zone resources."
  default     = "eastus"
}

variable "workload_name" {
  type        = string
  description = "Short identifier for the primary business workload."
  default     = "core"
}

variable "hub_address_space" {
  type        = list(string)
  description = "CIDR prefix range for the central Hub Virtual Network."
  default     = ["10.100.0.0/16"]
}

variable "spoke_address_space" {
  type        = list(string)
  description = "CIDR prefix range for the Workload Spoke Virtual Network."
  default     = ["10.101.0.0/16"]
}

variable "log_retention_days" {
  type        = number
  description = "Log Analytics retention window in days."
  default     = 30

  validation {
    condition     = var.log_retention_days >= 30 && var.log_retention_days <= 730
    error_message = "Log retention days must be between 30 and 730."
  }
}

variable "tags" {
  type        = map(string)
  description = "Standard corporate resource tags for FinOps and governance."
  default = {
    Environment        = "production"
    ManagedBy          = "Terraform"
    Owner              = "Cloud-Platform-Team"
    CostCenter         = "CC-INFRA-1042"
    SecurityCompliance = "CIS-Azure-v2.0"
  }
}

