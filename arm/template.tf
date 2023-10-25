resource "azurerm_app_service_plan" "my_app_service_plan" {
  name                = "my-app-service-plan"
  location            = azurerm_resource_group.spoke_rg.location
  resource_group_name = azurerm_resource_group.spoke_rg.name
  kind                = "Windows"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}