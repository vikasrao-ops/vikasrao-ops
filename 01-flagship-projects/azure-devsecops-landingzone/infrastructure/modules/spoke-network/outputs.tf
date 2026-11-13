output "spoke_rg_name" { value = azurerm_resource_group.spoke.name }
output "spoke_vnet_id" { value = azurerm_virtual_network.spoke.id }
output "spoke_vnet_name" { value = azurerm_virtual_network.spoke.name }
output "app_subnet_id" { value = azurerm_subnet.app.id }
output "data_subnet_id" { value = azurerm_subnet.data.id }
output "keyvault_subnet_id" { value = azurerm_subnet.keyvault.id }
output "appgw_subnet_id" { value = azurerm_subnet.appgw.id }
