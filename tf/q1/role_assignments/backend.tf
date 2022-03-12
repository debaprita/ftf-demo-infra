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
    key                  = "debs/storage-role-asgn-de-0.tfstate"
  }
}

data "azurerm_storage_account" "sa_d_ref" {
  name                = var.str_acc_name
  resource_group_name = var.str_acc_rg_name
}

data "azuread_user" "q1_writer_user" {
  #provider            = azurerm.aad_provider
  user_principal_name = var.ug_principal_name
}
