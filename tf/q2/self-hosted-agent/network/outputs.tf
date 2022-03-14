## outputs.tf

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vnet_name" {
  value = azurerm_virtual_network.self_hos_agent_vnet.name
}

output "vnet_name_prefix" {
  value = azurerm_virtual_network.self_hos_agent_vnet.address_space
}

output "subnet_name" {
  value = azurerm_subnet.self_hos_agent_subnet.name
}

output "subnet_prefix" {
  value = azurerm_subnet.self_hos_agent_subnet.address_prefix
}
