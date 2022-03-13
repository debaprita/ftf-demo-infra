## set the remote state location
provider "azurerm" {
  features {
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "deb-ftf-demo-tfstate-0"
    storage_account_name = "debftfdemotfstate0"
    container_name       = "tfstate"
    key                  = "debs/vnet-de-0.tfstate"
  }
}
data "azurerm_key_vault" "vault" {
  name                = var.keyvault_name
  resource_group_name = var.rg_name
}

data "azurerm_subnet" "self_hos_agent_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.subnet_vnet_name
  resource_group_name  = var.rg_name
}
