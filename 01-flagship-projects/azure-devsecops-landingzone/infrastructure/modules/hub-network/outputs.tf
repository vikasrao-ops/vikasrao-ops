output "hub_rg_name" { value = azurerm_resource_group.hub.name }
output "hub_vnet_id" { value = azurerm_virtual_network.hub.id }
output "hub_vnet_name" { value = azurerm_virtual_network.hub.name }
output "firewall_subnet_id" { value = azurerm_subnet.firewall.id }
output "bastion_subnet_id" { value = azurerm_subnet.bastion.id }
output "mgmt_subnet_id" { value = azurerm_subnet.mgmt.id }
