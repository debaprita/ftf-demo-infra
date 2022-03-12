## set the remote state location
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "deb-ftf-demo-tfstate-0"
    storage_account_name = "debftfdemotfstate0"
    container_name       = "tfstate"
    key                  = "debs/self-host-kv-de-0.tfstate"
  }
}

data "azurerm_client_config" "current" {}
