

resource "azurerm_virtual_network" "virtual_network_instance" {
  address_space =  ["10.0.0.0/16"]
  location = var.location
  name = var.vnet_name
  resource_group_name =var.rgp_name
  tags = {
    "name"="vnet"
  }
}

resource "azurerm_subnet" "subnetwork_instance" {
  name                 = var.subnet_name
  resource_group_name  = var.rgp_name
  virtual_network_name = azurerm_virtual_network.virtual_network_instance.name
  address_prefix       = "10.0.0.0/24"

}

resource "azurerm_public_ip" "instance_public_address" {
  allocation_method ="Static"
  location = var.location
  name =var.linux_vm_public_ip_name
  resource_group_name =var.rgp_name
}

