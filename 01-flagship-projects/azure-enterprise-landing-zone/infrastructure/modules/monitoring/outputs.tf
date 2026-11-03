output "workspace_id" {
  value       = azurerm_log_analytics_workspace.core.id
  description = "Resource ID of the central Log Analytics Workspace."
}

output "workspace_customer_id" {
  value       = azurerm_log_analytics_workspace.core.workspace_id
  description = "The Workspace (customer) ID for agent configuration."
}

output "workspace_name" {
  value       = azurerm_log_analytics_workspace.core.name
  description = "The name of the Log Analytics Workspace."
}

