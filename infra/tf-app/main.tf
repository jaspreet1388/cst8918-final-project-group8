provider "azurerm" {
  features {}
}

module "network" {
  source   = "./modules/network"
  location = var.location
}

module "aks" {
  source              = "./modules/aks"
  location            = var.location
  resource_group_name = module.network.resource_group_name
  vnet_subnet_id_test = module.network.test_subnet_id
  vnet_subnet_id_prod = module.network.prod_subnet_id
  test_aks_name       = "grp3akstest"
  prod_aks_name       = "grp3aksprod"
}

module "acr" {
  source               = "./modules/acr"
  location             = var.location
  resource_group_name  = module.network.resource_group_name
  acr_name             = "grp3weatheracr"
  redis_test_name      = "grp3redistest"
  redis_prod_name      = "grp3redisprod"
  test_aks_identity_id = module.aks.test_aks_identity_id
  prod_aks_identity_id = module.aks.prod_aks_identity_id
}