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
    key                  = "debs/self-host-iden-de-0.tfstate"
  }
}

data "azurerm_key_vault" "vault" {
  name                = var.keyvault_name
  resource_group_name = var.rg_name
}


data "azurerm_client_config" "current" {}
