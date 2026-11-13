variable "project_name" { type = string }
variable "environment" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "spoke_vnet_id" { type = string }
variable "keyvault_subnet_id" { type = string }
variable "tags" { type = map(string) }
