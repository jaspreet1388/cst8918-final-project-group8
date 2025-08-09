output "vnet_name" {
  value = azurerm_virtual_network.main_vnet.name
}
output "resource_group_name" {

  value = azurerm_resource_group.network_rg.name

}

output "test_subnet_id" {

  value = azurerm_subnet.test.id

}

output "prod_subnet_id" {

  value = azurerm_subnet.prod.id

}

 