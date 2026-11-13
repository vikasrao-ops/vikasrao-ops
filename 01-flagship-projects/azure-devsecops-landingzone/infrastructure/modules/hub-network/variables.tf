variable "project_name" { type = string }
variable "environment" { type = string }
variable "location" { type = string }
variable "hub_vnet_cidr" { type = list(string) }
variable "hub_subnets" { type = map(string) }
variable "tags" { type = map(string) }
