resource "azurerm_resource_group" "spoke" {
  name     = "rg-${var.project_name}-spoke-${var.environment}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "spoke" {
  name                = "vnet-spoke-${var.location}-${var.environment}"
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  address_space       = var.spoke_vnet_address_space
  tags                = var.tags
}

# Subnet 1: Monolithic App Tier (Private - No public IPs)
resource "azurerm_subnet" "app" {
  name                 = "snet-monolith-app-${var.environment}"
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [var.app_subnet_prefix]
}

# Subnet 2: Data Tier (Private DB / Storage)
resource "azurerm_subnet" "data" {
  name                 = "snet-monolith-data-${var.environment}"
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [var.data_subnet_prefix]
}

# Subnet 3: Key Vault Private Endpoints
resource "azurerm_subnet" "keyvault" {
  name                 = "snet-monolith-keyvault-${var.environment}"
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [var.keyvault_subnet_prefix]
}

# Subnet 4: Application Gateway Ingress
resource "azurerm_subnet" "appgw" {
  name                 = "snet-monolith-appgw-${var.environment}"
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [var.appgw_subnet_prefix]
}

# NSG for App Subnet - Strictly isolate inbound traffic
resource "azurerm_network_security_group" "app" {
  name                = "nsg-monolith-app-${var.environment}"
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name

  # Allow HTTP traffic from Application Gateway only
  security_rule {
    name                       = "Allow-AppGw-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = var.appgw_subnet_prefix
    destination_address_prefix = var.app_subnet_prefix
  }

  # Allow SSH from Hub Bastion / Mgmt subnet only
  security_rule {
    name                       = "Allow-Bastion-SSH"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.hub_vnet_address_space[0]
    destination_address_prefix = var.app_subnet_prefix
  }

  # Explicitly block all other Internet inbound
  security_rule {
    name                       = "Deny-Internet-Inbound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.app.id
}

# NSG for Key Vault Subnet - Only App Subnet can reach Key Vault Private Endpoint
resource "azurerm_network_security_group" "keyvault" {
  name                = "nsg-monolith-kv-${var.environment}"
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name

  security_rule {
    name                       = "Allow-App-To-KeyVault"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = var.app_subnet_prefix
    destination_address_prefix = var.keyvault_subnet_prefix
  }

  security_rule {
    name                       = "Deny-All-Inbound"
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

resource "azurerm_subnet_network_security_group_association" "keyvault" {
  subnet_id                 = azurerm_subnet.keyvault.id
  network_security_group_id = azurerm_network_security_group.keyvault.id
}

# Bidirectional VNet Peering: Hub <--> Spoke
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                         = "peer-hub-to-spoke-${var.environment}"
  resource_group_name          = var.hub_rg_name
  virtual_network_name         = var.hub_vnet_name
  remote_virtual_network_id    = azurerm_virtual_network.spoke.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                         = "peer-spoke-to-hub-${var.environment}"
  resource_group_name          = azurerm_resource_group.spoke.name
  virtual_network_name         = azurerm_virtual_network.spoke.name
  remote_virtual_network_id    = var.hub_vnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = false
}
