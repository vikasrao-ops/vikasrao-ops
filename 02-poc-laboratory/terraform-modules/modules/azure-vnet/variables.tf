variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network."
}

variable "resource_group_name" {
  type        = string
  description = "Target Resource Group name."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "address_space" {
  type        = list(string)
  description = "CIDR prefix block."
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  type = map(object({
    address_prefix = string
  }))
  description = "Map of subnets to create."
  default     = {}
}

variable "tags" {
  type        = map(string)
  default     = {}
}

