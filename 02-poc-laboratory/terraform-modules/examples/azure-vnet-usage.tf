module "prod_network" {
  source              = "../modules/azure-vnet"
  vnet_name           = "vnet-enterprise-prod"
  resource_group_name = "rg-network-prod"
  location            = "eastus"
  address_space       = ["10.50.0.0/16"]

  subnets = {
    "snet-web" = { address_prefix = "10.50.1.0/24" }
    "snet-app" = { address_prefix = "10.50.2.0/24" }
  }

  tags = {
    Environment = "prod"
    ManagedBy   = "Terraform"
  }
}

