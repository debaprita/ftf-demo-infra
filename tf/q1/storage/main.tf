
provider "azurerm" {
  features {
  }
  storage_use_azuread = "true"
  alias               = "sa_using_aad"

}
locals {
  az_env = lookup(var.az_env_lookup, format("%s_%s", var.location, var.environment))

  dynamic_tags = {
    source             = "terraform"
    app_code           = var.app_code
    environment        = var.environment
    cost_center_number = var.cost_center_number
  }
  name = "${var.app_code}_${var.app_name}_${local.az_env}_${var.index}"
  tags = local.dynamic_tags
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
