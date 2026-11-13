output "hub_resource_group" {
  value = module.hub_network.hub_rg_name
}

output "spoke_resource_group" {
  value = module.spoke_network.spoke_rg_name
}

output "hub_vnet_name" {
  value = module.hub_network.hub_vnet_name
}

output "spoke_vnet_name" {
  value = module.spoke_network.spoke_vnet_name
}

output "key_vault_uri" {
  value = module.security_vault.key_vault_uri
}

output "application_gateway_public_ip" {
  value = module.waf_gateway.appgw_public_ip
}
