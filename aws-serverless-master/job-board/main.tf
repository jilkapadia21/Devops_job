provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "Resource1"
  location = "East US"
}

resource "azurerm_app_service_plan" "example" {
  name                = "appserviceplan1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier     = "Standard"
    size     = "S1"
  }
}

resource "azurerm_web_app" "frontend" {
  name                = "webapp-frontend"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
  site_config {
    app_settings = {
      "WEBSITE_RUN_FROM_PACKAGE" = "<your_package_location>"
    }
  }
}

resource "azurerm_web_app" "backend" {
  name                = "webapp-backend"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
  site_config {
    app_settings = {
      "WEBSITE_RUN_FROM_PACKAGE" = "<your_package_location>"
    }
  }
}