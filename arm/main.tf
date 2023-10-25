provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "hub_rg" {
  name     = "hub-rg"
  location = "East US"
}

resource "azurerm_resource_group" "spoke_rg" {
  name     = "spoke-rg"
  location = "West US"
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = "hub-vnet"
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_virtual_network" "spoke_vnet" {
  name                = "spoke-vnet"
  location            = azurerm_resource_group.spoke_rg.location
  resource_group_name = azurerm_resource_group.spoke_rg.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                         = "hub-to-spoke"
  resource_group_name          = azurerm_resource_group.hub_rg.name
  virtual_network_name         = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke_vnet.id
  allow_virtual_network_access = true
}

resource "azurerm_app_service" "web_app" {
  name                = "my-web-app"
  location            = azurerm_resource_group.spoke_rg.location
  resource_group_name = azurerm_resource_group.spoke_rg.name
  app_service_plan_id = azurerm_app_service_plan.my_app_service_plan.id
}