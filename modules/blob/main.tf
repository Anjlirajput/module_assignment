resource "random_string" "random-name" {
  length  = 5
  upper   = false
  lower   = true
  number  = true
  special = false
}

resource "azurerm_resource_group" "rgp" {
  location = var.location
  name = var.rgp_name
}

resource "azurerm_storage_account" "storage_account_assignment" {
  account_replication_type = "LRS"
  account_tier = "Standard"
  location = var.location
  name = "${var.storage_account_name}${random_string.random-name.result}"
  resource_group_name =var.rgp_name

  tags = {
    "name"="blob storage"
  }
}


resource "azurerm_storage_container" "container_account_assignment" {
  name                  = "${var.storage_container_name}${random_string.random-name.result}"
  storage_account_name  = azurerm_storage_account.storage_account_assignment.name
  container_access_type = "blob"

}


resource "azurerm_storage_blob" "container_file" {
  name                   = "test2.txt"
  storage_account_name   = azurerm_storage_account.storage_account_assignment.name
  storage_container_name = azurerm_storage_container.container_account_assignment.name
  type                   = "Block"
  source                 = "test2.txt"

}