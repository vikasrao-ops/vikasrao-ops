output "azure_storage_account_name" {
  value       = azurerm_storage_account.storage.name
  description = "Name of the Azure Storage Account."
}

output "azure_resource_group" {
  value       = azurerm_resource_group.rg.name
  description = "Azure Resource Group."
}

