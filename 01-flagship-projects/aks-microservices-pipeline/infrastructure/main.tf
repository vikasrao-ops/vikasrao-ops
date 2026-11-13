# ==============================================================================
# Production Azure Kubernetes Service (AKS) & Azure Container Registry (ACR)
# ==============================================================================

resource "azurerm_resource_group" "aks_rg" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
  tags     = var.tags
}

# Virtual Network with Azure CNI Subnet
resource "azurerm_virtual_network" "aks_vnet" {
  name                = "vnet-${var.project_name}-${var.environment}"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  address_space       = var.vnet_cidr
  tags                = var.tags
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "snet-aks-nodes-${var.environment}"
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = [var.aks_subnet_cidr]
}

# Azure Container Registry (ACR)
resource "random_string" "acr_suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_container_registry" "acr" {
  name                = "cr${var.project_name}${var.environment}${random_string.acr_suffix.result}"
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  sku                 = "Premium"
  admin_enabled       = false
  tags                = var.tags
}

# Azure Kubernetes Service (AKS) Managed Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.project_name}-${var.environment}"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "aks-${var.project_name}-${var.environment}"
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                = "systempool"
    node_count          = var.system_node_count
    vm_size             = var.vm_size
    vnet_subnet_id      = azurerm_subnet.aks_subnet.id
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 4
    only_critical_addons_enabled = true
    tags                = var.tags
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
  }

  tags = var.tags
}

# Dedicated User Node Pool for Microservices Workloads
resource "azurerm_kubernetes_cluster_node_pool" "user_pool" {
  name                  = "workloadpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.vm_size
  node_count            = var.user_node_count
  vnet_subnet_id        = azurerm_subnet.aks_subnet.id
  enable_auto_scaling   = true
  min_count             = 2
  max_count             = 6
  mode                  = "User"
  tags                  = var.tags
}

# Grant AKS Kubelet Managed Identity "AcrPull" on Container Registry
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
