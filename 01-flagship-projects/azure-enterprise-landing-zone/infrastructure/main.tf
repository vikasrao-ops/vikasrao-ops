# Resource Group 1: Central Hub Connectivity
resource "azurerm_resource_group" "hub" {
  name     = "rg-connectivity-hub-${var.environment}"
  location = var.location
  tags     = var.tags
}

# Resource Group 2: Workload Spoke
resource "azurerm_resource_group" "spoke" {
  name     = "rg-workload-spoke-${var.environment}"
  location = var.location
  tags     = var.tags
}

# Resource Group 3: Operations & Central Monitoring
resource "azurerm_resource_group" "operations" {
  name     = "rg-operations-mgmt-${var.environment}"
  location = var.location
  tags     = var.tags
}

# Module 1: Hub Connectivity (VNet, Gateway, Firewall, Bastion, Management subnets)
module "hub_network" {
  source              = "./modules/hub-network"
  resource_group_name = azurerm_resource_group.hub.name
  location            = var.location
  address_space       = var.hub_address_space
  tags                = var.tags
}

# Module 2: Workload Spoke Network & Bi-directional Peering
module "spoke_network" {
  source                  = "./modules/spoke-network"
  resource_group_name     = azurerm_resource_group.spoke.name
  location                = var.location
  hub_vnet_id             = module.hub_network.vnet_id
  hub_vnet_name           = module.hub_network.vnet_name
  hub_resource_group_name = azurerm_resource_group.hub.name
  address_space           = var.spoke_address_space
  tags                    = var.tags
}

# Module 3: Centralized Operations & Monitoring
module "monitoring" {
  source              = "./modules/monitoring"
  resource_group_name = azurerm_resource_group.operations.name
  location            = var.location
  retention_in_days   = var.log_retention_days
  tags                = var.tags
}

# Module 4: Enterprise Governance & Azure Policy
module "governance" {
  source            = "./modules/governance"
  resource_group_id = azurerm_resource_group.spoke.id
  allowed_locations = [var.location, "eastus2"]
}

# Random suffix for globally unique resources (Storage, Key Vault)
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Hardened Azure Storage Account with Private Endpoint
resource "azurerm_storage_account" "secure_storage" {
  name                          = "stcore${var.environment}${random_string.suffix.result}"
  resource_group_name           = azurerm_resource_group.spoke.name
  location                      = var.location
  account_tier                  = "Standard"
  account_replication_type      = "GRS"
  account_kind                  = "StorageV2"
  https_traffic_only_enabled    = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = false # Zero-Trust: disable public IP ingress
  tags                          = var.tags

  blob_properties {
    versioning_enabled = true
    delete_retention_policy {
      days = 14
    }
  }
}

# Private DNS Zone for Azure Blob Storage
resource "azurerm_private_dns_zone" "blob_dns" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.spoke.name
  tags                = var.tags
}

# Link Private DNS Zone to Spoke Virtual Network
resource "azurerm_private_dns_zone_virtual_network_link" "blob_dns_link" {
  name                  = "link-blob-to-spoke"
  resource_group_name   = azurerm_resource_group.spoke.name
  private_dns_zone_name = azurerm_private_dns_zone.blob_dns.name
  virtual_network_id    = module.spoke_network.vnet_id
}

# Private Endpoint connecting Storage Account inside Spoke Subnet
resource "azurerm_private_endpoint" "storage_pe" {
  name                = "pe-stcore-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.spoke.name
  subnet_id           = module.spoke_network.private_endpoints_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-stcore-blob"
    private_connection_resource_id = azurerm_storage_account.secure_storage.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "pdz-group-blob"
    private_dns_zone_ids = [azurerm_private_dns_zone.blob_dns.id]
  }
}
