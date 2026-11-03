resource "random_string" "az_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-multicloud-${var.environment}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_storage_account" "storage" {
  name                     = "stmc${var.environment}${random_string.az_suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
  tags                     = var.tags
}

