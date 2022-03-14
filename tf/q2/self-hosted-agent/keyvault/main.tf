# main.tf

module "locals" {
  source             = "../../../modules/locals"
  app_code           = var.app_code
  app_name           = var.app_name
  cost_center_number = var.cost_center_number
  environment        = var.environment
  location           = var.location
}

locals {
  name = "${var.app_code}_${var.app_name}_${module.locals.az_env}_${var.index}"
}

# keyvault
resource "azurerm_key_vault" "kv" {
  name                        = replace(local.name, "/-|_/", "")
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = var.sku_size

  tags = module.locals.tags
}
