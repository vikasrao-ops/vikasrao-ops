variable "subscription_id" {
  type        = string
  description = "Target subscription ID for governance policy application."
  default     = ""
}

variable "resource_group_id" {
  type        = string
  description = "Resource Group ID for scope assignment."
}

variable "allowed_locations" {
  type        = list(string)
  description = "List of permitted Azure regions for deployment."
  default     = ["eastus", "eastus2", "centralus"]
}

