# outputs.tf

output "aci_id" {
  value = azurerm_container_group.aci.id
}

output "aci_ip_address" {
  value = azurerm_container_group.aci.ip_address
}

output "aci_fqdn" {
  value = azurerm_container_group.aci.fqdn
}
