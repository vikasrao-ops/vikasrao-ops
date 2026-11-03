output "policy_assignment_id" {
  value       = azurerm_resource_group_policy_assignment.allowed_locations.id
  description = "Resource ID of the applied Azure Policy assignment."
}

