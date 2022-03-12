
provider "azuread" {
  feature {

  }
  tenant_id = "" # don't want to checkin tenant id
  alias     = "aad_provider"
}



# rolw assignment for q1-writer user
# /subscriptions/<subscription>/resourceGroups/<resource-group>/providers/Microsoft.Storage/storageAccounts/<storage-account>/blobServices/default/containers/<container>
resource "azurerm_role_assignment" "q1_writer_user" {
  scope                = "${data.azurerm_storage_account.sa_d_ref.id}/blobServices/default/containers/${var.container_name}"
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azuread_user.q1_writer_user.object_id
}

