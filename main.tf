#sourced from https://github.com/F5Networks/f5-bigip-runtime-init/tree/main/examples/terraform/azure
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.97.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}
data "azurerm_virtual_network" "vnet" {
  resource_group_name = var.resource_group_name
  name = var.vnet
}
data "azurerm_subnet" "mgmt" {
  name = var.mgmt_subnet
  resource_group_name = var.resource_group_name
  virtual_network_name = var.vnet
}
data "azurerm_subnet" "internal1" {
  name = var.internal_subnet
  resource_group_name = var.resource_group_name
  virtual_network_name = var.vnet
}
data "azurerm_subnet" "internal2" {
  name = var.internal_subnet_2
  resource_group_name = var.resource_group_name
  virtual_network_name = var.vnet
}
data "azurerm_subnet" "external1" {
  name = var.external_subnet
  resource_group_name = var.resource_group_name
  virtual_network_name = var.vnet
}
data "azurerm_subnet" "external2" {
  name = var.external_subnet_2
  resource_group_name = var.resource_group_name
  virtual_network_name = var.vnet
}
data "azurerm_network_security_group" "mgmt" {
  name = var.mgmt_nsg
  resource_group_name = var.resource_group_name
}

data "azurerm_network_security_group" "internal" {
  name = var.internal_nsg
  resource_group_name = var.resource_group_name
}
data "azurerm_network_security_group" "external" {
  name = var.external_nsg
  resource_group_name = var.resource_group_name
}
