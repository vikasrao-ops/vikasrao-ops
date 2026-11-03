variable "resource_group_name" {
  type        = string
  description = "Name of the resource group hosting centralized telemetry."
}

variable "location" {
  type        = string
  description = "Azure region for monitoring services."
}

variable "retention_in_days" {
  type        = number
  description = "Data retention window in days."
  default     = 30
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
}

