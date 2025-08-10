terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.96.0"
    }
  }
}

resource "azurerm_container_registry" "weather_app_acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_redis_cache" "redis_test" {
  name                = var.redis_test_name
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 1
  family              = "C"
  sku_name            = "Basic"
  enable_non_ssl_port = true
}

resource "azurerm_redis_cache" "redis_prod" {
  name                = var.redis_prod_name
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 1
  family              = "C"
  sku_name            = "Basic"
  enable_non_ssl_port = true
}

# Grant ACR Pull access to AKS Test cluster
resource "azurerm_role_assignment" "aks_test_acr_pull" {
  principal_id         = var.test_aks_identity_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.weather_app_acr.id

  lifecycle {
    ignore_changes = [
      principal_id,
      role_definition_name,
      scope
    ]
  }
}

# Grant ACR Pull access to AKS Prod cluster
resource "azurerm_role_assignment" "aks_prod_acr_pull" {
  principal_id         = var.prod_aks_identity_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.weather_app_acr.id

  lifecycle {
    ignore_changes = [
      principal_id,
      role_definition_name,
      scope
    ]
  }
}
