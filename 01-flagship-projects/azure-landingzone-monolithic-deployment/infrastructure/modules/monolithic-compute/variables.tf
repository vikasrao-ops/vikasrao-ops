variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "app_subnet_id" {
  type = string
}

variable "key_vault_id" {
  type = string
}

variable "vm_admin_username" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "tags" {
  type = map(string)
}
