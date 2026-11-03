resource "random_string" "rand" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-terraform-poc-${var.environment}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_storage_account" "poc_storage" {
  name                     = "stpoc${var.environment}${random_string.rand.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
  tags                     = var.tags

  blob_properties {
    versioning_enabled = true
  }
}

resource "azurerm_storage_container" "data_container" {
  name                  = "artifacts"
  storage_account_name  = azurerm_storage_account.poc_storage.name
  container_access_type = "private"
}

