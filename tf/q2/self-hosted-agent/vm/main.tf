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
  name                          = "${var.app_code}_${var.app_name}_${module.locals.az_env}_${var.index}"
  ip_type                       = "dynamic"
  enable_accelerated_networking = true
}

# resource group
# resource "azurerm_resource_group" "rg" {
#   name     = local.name
#   location = var.location
#   tags     = module.locals.tags
# }

#pip
resource "azurerm_public_ip" "pip" {
  name                = "${var.app_code}_${var.app_name}_pip_${module.locals.az_env}_${var.index}"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
}

# nic
resource "azurerm_network_interface" "nic" {
  name                          = "${var.app_code}_${var.app_name}_nic_${module.locals.az_env}_${var.index}"
  location                      = var.location
  resource_group_name           = var.rg_name
  enable_accelerated_networking = local.enable_accelerated_networking
  tags                          = module.locals.tags
  ip_configuration {
    name                          = "${var.app_code}_${var.app_name}_${module.locals.az_env}_${var.index}"
    subnet_id                     = data.azurerm_subnet.self_hos_agent_subnet.id
    private_ip_address_allocation = local.ip_type
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_virtual_machine" "self-hos-vm" {
  name                          = "${var.app_code}_${var.app_name}_vm_${module.locals.az_env}_${var.index}"
  location                      = var.location
  resource_group_name           = var.rg_name
  network_interface_ids         = [azurerm_network_interface.nic.id]
  vm_size                       = var.sku_size
  tags                          = module.locals.tags
  delete_os_disk_on_termination = true
  storage_os_disk {
    name          = "${var.app_code}_${var.app_name}_${module.locals.az_env}_${var.index}"
    caching       = "ReadWrite"
    disk_size_gb  = var.disk_size_gb
    create_option = "FromImage"
  }
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = replace("${var.app_code}_${var.app_name}_vm_${module.locals.az_env}_${var.index}", "/_|-/", "")
    admin_username = "agentadm"
    custom_data    = data.template_file.cloud-init.rendered
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/agentadm/.ssh/authorized_keys"
      key_data = file("files/authorized_keys")
    }
  }

  # identity {
  #   type         = "UserAssigned"
  #   identity_ids = var.user_assigned_identity_ids
  # }
}

data "azurerm_key_vault_secrets" "v_secrets" {
  key_vault_id = data.azurerm_key_vault.vault.id
}
data "azurerm_key_vault_secret" "secret_vals" {
  for_each     = toset(data.azurerm_key_vault_secrets.v_secrets.names)
  name         = each.key
  key_vault_id = data.azurerm_key_vault.vault.id
}
data "template_file" "cloud-init" {
  template = file("${path.module}/files/cloud-init.yaml")
  vars = {
    environment          = var.environment
    app_code             = var.app_name
    pat                  = data.azurerm_key_vault_secret.secret_vals["pat"].value
    az_devops_url        = data.azurerm_key_vault_secret.secret_vals["az-devops-url"].value
    az_devops_agent_pool = data.azurerm_key_vault_secret.secret_vals["az-devops-agent-pool"].value
  }
}
