variable "environment" {
  type        = string
  description = "Target deployment environment (dev, staging, prod)."
  default     = "prod"
}

variable "location" {
  type        = string
  description = "Primary Azure region for all Landing Zone resources."
  default     = "eastus"
}

variable "project_name" {
  type        = string
  description = "Project resource prefix."
  default     = "lz-sec"
}

variable "hub_vnet_cidr" {
  type        = list(string)
  description = "Address prefix for Central Hub VNet."
  default     = ["10.100.0.0/16"]
}

variable "hub_subnets" {
  type        = map(string)
  description = "Subnet prefixes for Central Hub network services."
  default = {
    firewall = "10.100.1.0/24"
    bastion  = "10.100.2.0/24"
    mgmt     = "10.100.3.0/24"
  }
}

variable "spoke_vnet_cidr" {
  type        = list(string)
  description = "Address prefix for Workload Spoke VNet."
  default     = ["10.101.0.0/16"]
}

variable "spoke_subnets" {
  type        = map(string)
  description = "Subnet prefixes for Workload Spoke tiers."
  default = {
    app      = "10.101.1.0/24"
    data     = "10.101.2.0/24"
    keyvault = "10.101.3.0/24"
    appgw    = "10.101.4.0/24"
  }
}

variable "tags" {
  type        = map(string)
  description = "Standard resource tags for landing zone governance."
  default = {
    Environment = "prod"
    Project     = "azure-devsecops-landingzone"
    ManagedBy   = "Terraform"
    Compliance  = "CIS-Azure-v2.0"
    CostCenter  = "SEC-8080"
  }
}
