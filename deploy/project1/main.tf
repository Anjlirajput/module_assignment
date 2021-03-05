terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.50.0"
    }
  }
}

provider "azurerm" {
  features {}
}


module "storage" {
  source = "../../modules/blob"
  location = var.location
  rgp_name = var.rgp_name
  storage_account_name = "assignmentstorage"
  storage_container_name = "assignmentcontainer"
  file_name = "test2.txt"



}

module "vnet" {
  source = "../../modules/vnet"
  linux_vm_public_ip_name = "assignmentpublicipvm"
  location = var.location
  subnet_name = "assignmentsubnet"
  vnet_name = "assignmentvnet"
  rgp_name = var.rgp_name


}

module "vm" {
  source = "../../modules/linux_vm"
  linux_vm_name = "assignmentlinuxvm"
  linux_vm_nic_name = "assignmentnic"
  location = var.location
  username = "rajput"
  pub_id = module.vnet.public_ip_id
  storage_access_key = module.storage.storage_access_key
  rgp_name = var.rgp_name
  storage_account_name = module.storage.storage_account_name
  storage_container_name = module.storage.storage_container_name
  subnet_id = module.vnet.subnet_id
  depends_on = [module.storage,module.vnet]

}