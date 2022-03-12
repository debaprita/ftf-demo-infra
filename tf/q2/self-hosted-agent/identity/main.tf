# main.tf

module "locals" {
  source             = "../../modules/locals"
  app_code           = var.app_code
  app_name           = var.app_name
  cost_center_number = var.cost_center_number
  location           = var.location
}

locals {
  name = "${var.app_code}_${var.app_name}_${module.locals.az_env}_${var.index}"
}

# user_identity
resource "azurerm_user_assigned_identity" "user_iden" {
  location            = var.location
  resource_group_name = var.rg_name
  name                = local.name
  tags                = module.locals.tags
}

# add_to_keyvault
resource "azurerm_key_vault_access_policy" "access-policy" {
  key_vault_id = data.azurerm_key_vault.vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.user_iden.principal_id

  secret_permissions = [
    "Get",
  ]
}
