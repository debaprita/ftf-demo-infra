
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

# acr
resource "azurerm_container_registry" "acr" {
  name                = replace("${var.app_code}_${var.app_name}_${local.az_env}", "/_|-/", "")
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = var.acr_admin_enabled

  tags = local.tags
}
