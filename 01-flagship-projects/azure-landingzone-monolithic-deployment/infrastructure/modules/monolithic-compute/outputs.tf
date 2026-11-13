output "vm_id" {
  value = azurerm_linux_virtual_machine.monolith.id
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.monolith.name
}

output "vm_private_ip" {
  value = azurerm_network_interface.vm_nic.private_ip_address
}

output "vm_principal_id" {
  value = azurerm_linux_virtual_machine.monolith.identity[0].principal_id
}
