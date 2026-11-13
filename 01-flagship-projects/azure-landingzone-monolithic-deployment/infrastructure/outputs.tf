output "hub_resource_group" {
  description = "Name of the central Hub resource group."
  value       = module.hub_network.hub_rg_name
}

output "spoke_resource_group" {
  description = "Name of the spoke resource group containing the monolithic application."
  value       = module.spoke_network.spoke_rg_name
}

output "hub_vnet_name" {
  description = "Name of the central Hub Virtual Network."
  value       = module.hub_network.hub_vnet_name
}

output "spoke_vnet_name" {
  description = "Name of the Spoke Virtual Network."
  value       = module.spoke_network.spoke_vnet_name
}

output "key_vault_name" {
  description = "Azure Key Vault name hosting application secrets."
  value       = module.key_vault.key_vault_name
}

output "key_vault_uri" {
  description = "Private URI for Azure Key Vault."
  value       = module.key_vault.key_vault_uri
}

output "monolithic_vm_private_ip" {
  description = "Private IP of the monolithic Linux VM (No public IP)."
  value       = module.monolithic_compute.vm_private_ip
}

output "application_gateway_public_ip" {
  description = "Public IP of the Application Gateway ingress WAF."
  value       = module.application_gateway.appgw_public_ip
}

output "log_analytics_workspace_name" {
  description = "Name of the centralized Log Analytics workspace."
  value       = module.monitoring.log_analytics_workspace_name
}
