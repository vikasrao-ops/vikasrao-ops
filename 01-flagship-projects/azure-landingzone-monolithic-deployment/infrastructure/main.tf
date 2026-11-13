# ==============================================================================
# Azure Landing Zone & Secure Monolithic Application Deployment
# Root Orchestration Module
# ==============================================================================

module "hub_network" {
  source                     = "./modules/hub-network"
  project_name               = var.project_name
  environment                = var.environment
  location                   = var.location
  hub_vnet_address_space     = var.hub_vnet_address_space
  hub_firewall_subnet_prefix = var.hub_firewall_subnet_prefix
  hub_bastion_subnet_prefix  = var.hub_bastion_subnet_prefix
  hub_mgmt_subnet_prefix     = var.hub_mgmt_subnet_prefix
  tags                       = var.tags
}

module "spoke_network" {
  source                   = "./modules/spoke-network"
  project_name             = var.project_name
  environment              = var.environment
  location                 = var.location
  spoke_vnet_address_space = var.spoke_vnet_address_space
  app_subnet_prefix        = var.app_subnet_prefix
  data_subnet_prefix       = var.data_subnet_prefix
  keyvault_subnet_prefix   = var.keyvault_subnet_prefix
  appgw_subnet_prefix      = var.appgw_subnet_prefix
  hub_vnet_address_space   = var.hub_vnet_address_space
  hub_rg_name              = module.hub_network.hub_rg_name
  hub_vnet_id              = module.hub_network.hub_vnet_id
  hub_vnet_name            = module.hub_network.hub_vnet_name
  tags                     = var.tags
}

module "key_vault" {
  source              = "./modules/key-vault"
  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = module.spoke_network.spoke_rg_name
  keyvault_subnet_id  = module.spoke_network.keyvault_subnet_id
  spoke_vnet_id       = module.spoke_network.spoke_vnet_id
  tags                = var.tags
}

module "monolithic_compute" {
  source              = "./modules/monolithic-compute"
  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = module.spoke_network.spoke_rg_name
  app_subnet_id       = module.spoke_network.app_subnet_id
  key_vault_id        = module.key_vault.key_vault_id
  vm_admin_username   = var.vm_admin_username
  vm_size             = var.vm_size
  tags                = var.tags
}

module "application_gateway" {
  source                = "./modules/application-gateway"
  project_name          = var.project_name
  environment           = var.environment
  location              = var.location
  resource_group_name   = module.spoke_network.spoke_rg_name
  appgw_subnet_id       = module.spoke_network.appgw_subnet_id
  backend_vm_private_ip = module.monolithic_compute.vm_private_ip
  tags                  = var.tags
}

module "monitoring" {
  source              = "./modules/monitoring"
  project_name        = var.project_name
  environment         = var.environment
  location            = var.location
  resource_group_name = module.spoke_network.spoke_rg_name
  key_vault_id        = module.key_vault.key_vault_id
  tags                = var.tags
}
