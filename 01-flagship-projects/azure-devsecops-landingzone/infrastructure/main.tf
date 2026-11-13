# ==============================================================================
# Azure DevSecOps Landing Zone - Root Orchestrator
# ==============================================================================

module "hub_network" {
  source        = "./modules/hub-network"
  project_name  = var.project_name
  environment   = var.environment
  location      = var.location
  hub_vnet_cidr = var.hub_vnet_cidr
  hub_subnets   = var.hub_subnets
  tags          = var.tags
}

module "spoke_network" {
  source          = "./modules/spoke-network"
  project_name    = var.project_name
  environment     = var.environment
  location        = var.location
  spoke_vnet_cidr = var.spoke_vnet_cidr
  spoke_subnets   = var.spoke_subnets
  hub_rg_name     = module.hub_network.hub_rg_name
  hub_vnet_id     = module.hub_network.hub_vnet_id
  hub_vnet_name   = module.hub_network.hub_vnet_name
  tags            = var.tags
}

module "security_vault" {
  source              = "./modules/security-vault"
  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = module.spoke_network.spoke_rg_name
  spoke_vnet_id       = module.spoke_network.spoke_vnet_id
  keyvault_subnet_id  = module.spoke_network.keyvault_subnet_id
  tags                = var.tags
}

module "waf_gateway" {
  source              = "./modules/waf-gateway"
  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = module.spoke_network.spoke_rg_name
  appgw_subnet_id     = module.spoke_network.appgw_subnet_id
  tags                = var.tags
}
