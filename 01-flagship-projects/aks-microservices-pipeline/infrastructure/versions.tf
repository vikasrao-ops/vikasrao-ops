terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-prod"
    storage_account_name = "sttfstateakspipeline"
    container_name       = "tfstate"
    key                  = "aks-microservices-pipeline.tfstate"
  }
}

provider "azurerm" {
  features {}
}
