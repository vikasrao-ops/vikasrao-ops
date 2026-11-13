resource "azurerm_resource_group" "spoke" {
  name     = "rg-${var.project_name}-spoke-${var.environment}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "spoke" {
  name                = "vnet-spoke-${var.environment}"
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  address_space       = var.spoke_vnet_cidr
  tags                = var.tags
}

resource "azurerm_subnet" "app" {
  name                 = "snet-workload-app-${var.environment}"
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [var.spoke_subnets["app"]]
}

resource "azurerm_subnet" "data" {
  name                 = "snet-workload-data-${var.environment}"
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [var.spoke_subnets["data"]]
}

resource "azurerm_subnet" "keyvault" {
  name                 = "snet-workload-kv-${var.environment}"
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [var.spoke_subnets["keyvault"]]
}

resource "azurerm_subnet" "appgw" {
  name                 = "snet-workload-appgw-${var.environment}"
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [var.spoke_subnets["appgw"]]
}

# NSG for App Subnet
resource "azurerm_network_security_group" "app" {
  name                = "nsg-workload-app-${var.environment}"
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name

  security_rule {
    name                       = "Allow-AppGateway-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = var.spoke_subnets["appgw"]
    destination_address_prefix = var.spoke_subnets["app"]
  }

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

# Bi-directional VNet Peering: Hub <--> Spoke
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                         = "peer-hub-to-spoke"
  resource_group_name          = var.hub_rg_name
  virtual_network_name         = var.hub_vnet_name
  remote_virtual_network_id    = azurerm_virtual_network.spoke.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                         = "peer-spoke-to-hub"
  resource_group_name          = azurerm_resource_group.spoke.name
  virtual_network_name         = azurerm_virtual_network.spoke.name
  remote_virtual_network_id    = var.hub_vnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
