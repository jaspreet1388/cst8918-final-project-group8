terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.117.0"
    }
  }
}


provider "azurerm" {
  features {}
}

# Automatically pick latest supported GA version for your location
data "azurerm_kubernetes_service_versions" "current" {
  location        = var.location
  include_preview = false
}

# ----------------- TEST CLUSTER -----------------
# tfsec:ignore:azure-container-limit-authorized-ips tfsec:ignore:azure-container-logging
resource "azurerm_kubernetes_cluster" "test" {
  name                = var.test_aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.test_aks_name}-dns"

  kubernetes_version = data.azurerm_kubernetes_service_versions.current.latest_version

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_B2s"
    vnet_subnet_id = var.vnet_subnet_id_test
    type           = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    service_cidr   = "10.240.0.0/16"
    dns_service_ip = "10.240.0.10"
  }

  api_server_access_profile {
    authorized_ip_ranges = ["0.0.0.0/0"]
  }

  tags = {
    environment = "test"
  }
}

# ----------------- PROD CLUSTER -----------------
# tfsec:ignore:azure-container-limit-authorized-ips tfsec:ignore:azure-container-logging
resource "azurerm_kubernetes_cluster" "prod" {
  name                = var.prod_aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.prod_aks_name}-dns"

  kubernetes_version = data.azurerm_kubernetes_service_versions.current.latest_version

  default_node_pool {
    name                = "default"
    min_count           = 1
    max_count           = 3
    enable_auto_scaling = true
    vm_size             = "Standard_B2s"
    vnet_subnet_id      = var.vnet_subnet_id_prod
    type                = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    service_cidr   = "10.241.0.0/16"
    dns_service_ip = "10.241.0.10"
  }

  api_server_access_profile {
    authorized_ip_ranges = ["0.0.0.0/0"]
  }

  tags = {
    environment = "prod"
  }
}
