output "vnet_id" {
  value       = azurerm_virtual_network.spoke.id
  description = "Resource ID of the Workload Spoke Virtual Network."
}

output "vnet_name" {
  value       = azurerm_virtual_network.spoke.name
  description = "Name of the Workload Spoke Virtual Network."
}

output "app_subnet_id" {
  value       = azurerm_subnet.app.id
  description = "Resource ID of the App Subnet."
}

output "data_subnet_id" {
  value       = azurerm_subnet.data.id
  description = "Resource ID of the Database Subnet."
}

output "private_endpoints_subnet_id" {
  value       = azurerm_subnet.private_endpoints.id
  description = "Resource ID of the Private Endpoints Subnet."
}

