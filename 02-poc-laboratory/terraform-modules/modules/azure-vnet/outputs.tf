output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "Virtual Network ID."
}

output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "Virtual Network Name."
}

output "subnet_ids" {
  value       = { for k, v in azurerm_subnet.subnet : k => v.id }
  description = "Map of created subnet IDs."
}

