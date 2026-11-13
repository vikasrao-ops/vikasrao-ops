# Compliant Azure Infrastructure under OPA Governance Policy

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.project_name}-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_cidr
  tags                = var.tags
}

resource "azurerm_subnet" "workload" {
  name                 = "snet-workload-${var.environment}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidrs["workload"]]
}

# Compliant NSG (Restricts SSH to internal VNet CIDR only)
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.project_name}-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-Internal-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.vnet_cidr[0]
    destination_address_prefix = var.subnet_cidrs["workload"]
  }

  security_rule {
    name                       = "Deny-Internet-Inbound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "workload_assoc" {
  subnet_id                 = azurerm_subnet.workload.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "random_string" "storage_suffix" {
  length  = 6
  special = false
  upper   = false
}

# Compliant Secure Storage (HTTPS only, TLS 1.2 enforced)
resource "azurerm_storage_account" "secure_storage" {
  name                     = "st${var.project_name}${var.environment}${random_string.storage_suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"

  blob_properties {
    delete_retention_policy {
      days = 14
    }
  }

  tags = var.tags
}
