variable "resource_group_name" {
  type        = string
  description = "Name of the resource group hosting hub connectivity."
}

variable "location" {
  type        = string
  description = "Azure region for the hub network."
}

variable "address_space" {
  type        = list(string)
  description = "CIDR block for the Hub Virtual Network."
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
}

