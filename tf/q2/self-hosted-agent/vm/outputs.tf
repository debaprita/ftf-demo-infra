## outputs.tf

output "resource_group_name" {
  value = var.rg_name
}
output "pip" {
  value = azurerm_public_ip.pip.ip_address
}
