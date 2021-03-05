output "vnet_name" {
  value = azurerm_virtual_network.virtual_network_instance.name
}
output "subnet_id" {
  value = azurerm_subnet.subnetwork_instance.id
}

output "public_ip" {
  value = azurerm_public_ip.instance_public_address.ip_address
}

output "public_ip_id" {
  value = azurerm_public_ip.instance_public_address.id
}