## outputs.tf

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "tags" {
  value = azurerm_storage_account.sa.tags
}

output "name" {
  value = azurerm_storage_account.sa.name
}
