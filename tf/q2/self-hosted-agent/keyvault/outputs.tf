## outputs.tf

output "tags" {
  value = azurerm_key_vault.tags
}

output "kv_name" {
  value = azurerm_key_vault.name
}
