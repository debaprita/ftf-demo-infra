## outputs.tf

output "tags" {
  value = azurerm_key_vault.kv.tags
}
output "kv_name" {
  value = azurerm_key_vault.kv.name
}
