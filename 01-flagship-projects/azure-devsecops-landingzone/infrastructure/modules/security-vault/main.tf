data "azurerm_client_config" "current" {}

resource "random_string" "kv_suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_key_vault" "vault" {
  name                       = "kv-${var.project_name}-${var.environment}-${random_string.kv_suffix.result}"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 90
  purge_protection_enabled   = true
  enable_rbac_authorization  = true

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
  }

  tags = var.tags
}

resource "azurerm_private_dns_zone" "kv" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "kv" {
  name                  = "link-kv-spoke"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.kv.name
  virtual_network_id    = var.spoke_vnet_id
}

resource "azurerm_private_endpoint" "kv" {
  name                = "pe-kv-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.keyvault_subnet_id

  private_service_connection {
    name                           = "psc-kv-${var.project_name}"
    private_connection_resource_id = azurerm_key_vault.vault.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "dns-group-vault"
    private_dns_zone_ids = [azurerm_private_dns_zone.kv.id]
  }

  tags = var.tags
}
