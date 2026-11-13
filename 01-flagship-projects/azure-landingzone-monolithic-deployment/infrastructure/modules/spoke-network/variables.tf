variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "spoke_vnet_address_space" {
  type = list(string)
}

variable "app_subnet_prefix" {
  type = string
}

variable "data_subnet_prefix" {
  type = string
}

variable "keyvault_subnet_prefix" {
  type = string
}

variable "appgw_subnet_prefix" {
  type = string
}

variable "hub_vnet_address_space" {
  type = list(string)
}

variable "hub_rg_name" {
  type = string
}

variable "hub_vnet_id" {
  type = string
}

variable "hub_vnet_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
