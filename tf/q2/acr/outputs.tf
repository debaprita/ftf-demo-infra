## outputs.tf

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "tags" {
  value = azurerm_container_registry.acr.tags
}

output "name" {
  value = azurerm_container_registry.acr.name
}
