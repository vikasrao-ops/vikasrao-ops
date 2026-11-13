variable "environment" {
  type        = string
  description = "Target deployment environment tier (dev, staging, prod)."
  default     = "prod"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "location" {
  type        = string
  description = "Primary Azure region for all Landing Zone resources."
  default     = "eastus"
}

variable "project_name" {
  type        = string
  description = "Short prefix for project resources."
  default     = "monolith"
}

variable "hub_vnet_address_space" {
  type        = list(string)
  description = "Address space for Central Hub Virtual Network."
  default     = ["10.0.0.0/16"]
}

variable "hub_firewall_subnet_prefix" {
  type        = string
  description = "CIDR for AzureFirewallSubnet in Hub VNet."
  default     = "10.0.1.0/24"
}

variable "hub_bastion_subnet_prefix" {
  type        = string
  description = "CIDR for AzureBastionSubnet in Hub VNet."
  default     = "10.0.2.0/24"
}

variable "hub_mgmt_subnet_prefix" {
  type        = string
  description = "CIDR for management jumpbox subnet in Hub VNet."
  default     = "10.0.3.0/24"
}

variable "spoke_vnet_address_space" {
  type        = list(string)
  description = "Address space for Application Spoke Virtual Network."
  default     = ["10.1.0.0/16"]
}

variable "app_subnet_prefix" {
  type        = string
  description = "CIDR prefix for monolithic application VM compute subnet."
  default     = "10.1.1.0/24"
}

variable "data_subnet_prefix" {
  type        = string
  description = "CIDR prefix for private data tier and storage private endpoints."
  default     = "10.1.2.0/24"
}

variable "keyvault_subnet_prefix" {
  type        = string
  description = "CIDR prefix for Azure Key Vault private endpoint."
  default     = "10.1.3.0/24"
}

variable "appgw_subnet_prefix" {
  type        = string
  description = "CIDR prefix for Azure Application Gateway public ingress."
  default     = "10.1.4.0/24"
}

variable "vm_admin_username" {
  type        = string
  description = "Administrator username for Linux monolithic VM instances."
  default     = "azureuser"
}

variable "vm_size" {
  type        = string
  description = "Azure VM SKU for the monolithic workload."
  default     = "Standard_B2ms"
}

variable "tags" {
  type        = map(string)
  description = "Standard resource tags enforced across Landing Zone."
  default = {
    Environment = "prod"
    Project     = "monolithic-app"
    ManagedBy   = "Terraform"
    Compliance  = "CIS-Azure-Baseline"
    CostCenter  = "CC-1042"
  }
}
