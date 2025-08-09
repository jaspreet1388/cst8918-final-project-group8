output "test_kube_config" {
  value     = azurerm_kubernetes_cluster.test.kube_config_raw
  sensitive = true
}

output "prod_kube_config" {
  value     = azurerm_kubernetes_cluster.prod.kube_config_raw
  sensitive = true
}

output "test_aks_identity_id" {
  value = azurerm_kubernetes_cluster.test.identity[0].principal_id
}

output "prod_aks_identity_id" {
  value = azurerm_kubernetes_cluster.prod.identity[0].principal_id
}