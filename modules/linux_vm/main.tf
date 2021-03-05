
resource "azurerm_network_security_group" "security_rules" {
  name                = "instance1_security_rules"
  location            = var.location
  resource_group_name =var.rgp_name


  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }



}


resource "azurerm_network_interface" "instance_network_interface" {
  location = var.location
  name = var.linux_vm_nic_name
  resource_group_name = var.rgp_name
  ip_configuration {
    name = "instance_NIC"
    subnet_id= var.subnet_id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id =var.pub_id

  }
}


//now create a vm

resource "azurerm_linux_virtual_machine" "linuxvm" {
  admin_username = var.username
  location = var.location
  name = var.linux_vm_name
  network_interface_ids = [azurerm_network_interface.instance_network_interface.id]
  resource_group_name = var.rgp_name
  size = "Standard_A1_v2"
  tags = {
    "name"="linuxvm"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  //az vm image list -p "Canonical"     for finding images

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  //The Public Key which should be used for authentication, which needs to be at least 2048-bit
  admin_ssh_key {
    username = var.username
    public_key =tls_private_key.keygen.public_key_openssh

  }


  provisioner "file" {
    source      = "./script.sh"
    destination = "script.sh"

    connection {
      type     = "ssh"
      user     = var.username
      private_key=tls_private_key.keygen.private_key_pem
      host     = self.public_ip_address

    }

  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = var.username
      private_key=tls_private_key.keygen.private_key_pem
      host     = self.public_ip_address

    }


    inline=[
      "echo ${var.storage_account_name} | cat > storage_name.txt",
      "echo ${var.storage_container_name} |cat > cotainer_name.txt",
      "echo ${var.storage_access_key} |cat > storage_key.txt",
      "echo 'congratulations Dear Assignment complete ' | cat > test1.txt",
      "chmod +x ./script.sh",
      "./script.sh"

    ]
  }




}













