variable "resource_group_name" {
  type        = string
  description = "Name of the resource group hosting workload spoke."
}

variable "location" {
  type        = string
  description = "Azure region for the spoke network."
}

variable "hub_vnet_id" {
  type        = string
  description = "Resource ID of the central Hub VNet for peering."
}

variable "hub_vnet_name" {
  type        = string
  description = "Name of the central Hub VNet."
}

variable "hub_resource_group_name" {
  type        = string
  description = "Name of the resource group hosting the Hub VNet."
}

variable "address_space" {
  type        = list(string)
  description = "CIDR block for the Workload Spoke Virtual Network."
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
}

