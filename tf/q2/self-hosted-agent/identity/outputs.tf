## outputs.tf

output "principal_id" {
  value = azurerm_user_assigned_identity.user_iden.principal_id
}

