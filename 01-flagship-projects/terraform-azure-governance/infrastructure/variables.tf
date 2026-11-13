variable "environment" {
  type        = string
  description = "Target environment."
  default     = "prod"
}

variable "location" {
  type        = string
  description = "Compliant Azure deployment region."
  default     = "eastus"
}

variable "project_name" {
  type        = string
  description = "Prefix identifier for resources."
  default     = "azgov"
}

variable "vnet_cidr" {
  type        = list(string)
  description = "Virtual network address space."
  default     = ["10.200.0.0/16"]
}

variable "subnet_cidrs" {
  type        = map(string)
  description = "Subnet prefixes."
  default = {
    workload = "10.200.1.0/24"
    data     = "10.200.2.0/24"
  }
}

variable "tags" {
  type        = map(string)
  description = "Mandatory OPA tags required across all resources."
  default = {
    Environment = "prod"
    Owner       = "vikas.rao"
    Project     = "terraform-azure-governance"
    CostCenter  = "GOV-770"
    ManagedBy   = "Terraform"
  }
}
