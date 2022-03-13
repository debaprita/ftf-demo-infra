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

# resource group
resource "azurerm_resource_group" "rg" {
  name     = local.name
  location = var.location
  tags     = module.locals.tags
}

# vnet
resource "azurerm_virtual_network" "self_hos_agent_vnet" {
  name                = "${var.app_code}_${var.app_name}_vnet_${module.locals.az_env}_${var.index}"
  address_space       = var.vnet_ip_address_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# subnet
resource "azurerm_subnet" "self_hos_agent_subnet" {
  name                 = "${var.app_code}_${var.app_name}_subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.self_hos_agent_vnet.name
  address_prefixes     = var.subnet_ip_address_prefix
}

# nsg
resource "azurerm_network_security_group" "self_hos_agent_subnet_nsg" {
  name                = "${var.app_code}_${var.app_name}_nsg_${module.locals.az_env}_${var.index}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# nsg_rule
resource "azurerm_network_security_rule" "self_hos_agent_subnet_nsg_rule_0" {
  name                        = "0_SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.self_hos_agent_subnet_nsg.name
}

# nsg_subnet_assoc
resource "azurerm_subnet_network_security_group_association" "self_hos_agent_subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.self_hos_agent_subnet.id
  network_security_group_id = azurerm_network_security_group.self_hos_agent_subnet_nsg.id
}
