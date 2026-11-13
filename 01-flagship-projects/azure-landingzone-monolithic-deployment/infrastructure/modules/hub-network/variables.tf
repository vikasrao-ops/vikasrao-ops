variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "hub_vnet_address_space" {
  type = list(string)
}

variable "hub_firewall_subnet_prefix" {
  type = string
}

variable "hub_bastion_subnet_prefix" {
  type = string
}

variable "hub_mgmt_subnet_prefix" {
  type = string
}

variable "tags" {
  type = map(string)
}
