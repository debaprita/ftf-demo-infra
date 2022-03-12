
module "locals" {
  source             = "../../modules/locals"
  app_code           = var.app_code
  app_name           = var.app_name
  cost_center_number = var.cost_center_number
  environment        = var.environment
  location           = var.location
}

locals {
  name = "${var.app_code}_${var.app_name}_${module.locals.az_env}_${var.index}"
  tags = module.locals.tags
}
## resource group
resource "azurerm_resource_group" "rg" {
  name     = local.name
  location = var.location
  tags     = local.tags
}

# acr
resource "azurerm_container_registry" "acr" {
  name                = replace("${var.app_code}_${var.app_name}_${module.locals.az_env}", "/_|-/", "")
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = var.acr_admin_enabled

  tags = local.tags
}
