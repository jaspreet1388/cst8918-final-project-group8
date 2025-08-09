output "acr_login_server" {
  value = azurerm_container_registry.weather_app_acr.login_server
}

output "redis_test_hostname" {
  value = azurerm_redis_cache.redis_test.hostname
}

output "redis_prod_hostname" {
  value = azurerm_redis_cache.redis_prod.hostname
}