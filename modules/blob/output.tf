
output "rgp_name" {
  value = azurerm_resource_group.rgp.name
}

output "storage_account_name" {
  value =azurerm_storage_account.storage_account_assignment.name

}

output "storage_container_name" {
  value =azurerm_storage_container.container_account_assignment.name

}
output "storage_access_key" {
  value =azurerm_storage_account.storage_account_assignment.primary_access_key

}