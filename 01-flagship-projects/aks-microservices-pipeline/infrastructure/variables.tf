variable "environment" {
  type        = string
  description = "Target environment (dev, staging, prod)."
  default     = "prod"
}

variable "location" {
  type        = string
  description = "Primary Azure region."
  default     = "eastus"
}

variable "project_name" {
  type        = string
  description = "Project resource prefix."
  default     = "aksmicro"
}

variable "vnet_cidr" {
  type        = list(string)
  description = "AKS VNet address prefix."
  default     = ["10.240.0.0/16"]
}

variable "aks_subnet_cidr" {
  type        = string
  description = "Subnet prefix for AKS Azure CNI pods and nodes."
  default     = "10.240.0.0/20"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes control plane version."
  default     = "1.28.3"
}

variable "system_node_count" {
  type        = number
  description = "Initial system nodepool VM count."
  default     = 2
}

variable "user_node_count" {
  type        = number
  description = "Initial user microservices nodepool VM count."
  default     = 3
}

variable "vm_size" {
  type        = string
  description = "VM SKU for Kubernetes node instances."
  default     = "Standard_D2s_v5"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all AKS cluster resources."
  default = {
    Environment = "prod"
    Project     = "aks-microservices-pipeline"
    ManagedBy   = "Terraform"
    Tier        = "ContainerPlatform"
  }
}
