output "hub_vnet_id" {
  value       = module.hub_network.vnet_id
  description = "The Resource ID of the Central Hub VNet."
}

output "spoke_vnet_id" {
  value       = module.spoke_network.vnet_id
  description = "The Resource ID of the Workload Spoke VNet."
}

output "log_analytics_workspace_id" {
  value       = module.monitoring.workspace_id
  description = "Central Log Analytics Workspace ID for diagnostics."
}

output "storage_account_name" {
  value       = azurerm_storage_account.secure_storage.name
  description = "Name of the secure storage account with private link."
}

output "storage_private_endpoint_ip" {
  value       = azurerm_private_endpoint.storage_pe.private_service_connection[0].private_ip_address
  description = "Private IP address allocated to the storage account private endpoint."
}

