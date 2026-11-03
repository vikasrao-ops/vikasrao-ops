output "storage_account_name" {
  value       = azurerm_storage_account.poc_storage.name
  description = "Provisioned Storage Account name."
}

output "container_name" {
  value       = azurerm_storage_container.data_container.name
  description = "Provisioned Private Blob Container name."
}

