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

# resource group
resource "azurerm_resource_group" "rg" {
  name     = local.name
  location = var.location
  tags     = module.locals.tags
}

resource "azurerm_virtual_machine" "self-hos-vm" {
  name                  = "${var.app_code}_${var.app_name}_vm_${module.locals.az_env}"
  location              = azurerm_resource_group.tamops.location
  resource_group_name   = azurerm_resource_group.tamops.name
  network_interface_ids = []
  vm_size               = var.sku_size

  storage_os_disk {
    name              = var.vm_osdisk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "${var.app_code}_${var.app_name}_vm_${module.locals.az_env}"
    admin_username = "agentadmin"
  }

}
