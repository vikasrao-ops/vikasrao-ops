output "vnet_id" {
  value       = azurerm_virtual_network.hub.id
  description = "Resource ID of the central Hub Virtual Network."
}

output "vnet_name" {
  value       = azurerm_virtual_network.hub.name
  description = "Name of the central Hub Virtual Network."
}

output "management_subnet_id" {
  value       = azurerm_subnet.management.id
  description = "Resource ID of the Hub Management Subnet."
}

output "firewall_subnet_id" {
  value       = azurerm_subnet.firewall.id
  description = "Resource ID of the Azure Firewall Subnet."
}

