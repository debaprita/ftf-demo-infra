
provider "azurerm" {
  features {
  }
  storage_use_azuread = "true"
  alias               = "sa_using_aad"

}

module "locals" {
  source             = "../../modules/locals"
  app_code           = var.app_code
  app_name           = var.app_name
  cost_center_number = var.cost_center_number
  environment        = var.environment
  location           = var.location
}

locals {
  az_env = module.locals.az_env
  name   = "${var.app_code}_${var.app_name}_${local.az_env}_${var.index}"
  tags   = module.locals.tags
}

## resource group
resource "azurerm_resource_group" "rg" {
  name     = local.name
  location = var.location
  tags     = local.tags
}

# storage acc
resource "azurerm_storage_account" "sa" {
  provider                  = azurerm.sa_using_aad
  name                      = replace(local.name, "/-|_/", "")
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = var.location
  account_tier              = var.account_tier
  account_kind              = var.account_kind
  allow_blob_public_access  = var.allow_blob_public_access
  shared_access_key_enabled = var.shared_access_key_enabled
  enable_https_traffic_only = var.enable_https_traffic_only
  account_replication_type  = var.account_replication_type
  min_tls_version           = "TLS1_2"

  network_rules {
    default_action = "Allow"
  }

  tags = local.tags
}

# container 
resource "azurerm_storage_container" "files" {
  provider              = azurerm.sa_using_aad
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "blob"
}
