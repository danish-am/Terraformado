output "dev_storage_account" {
  value = azurerm_storage_account.dev.name
}

output "test_storage_account" {
  value = azurerm_storage_account.test.name
}

output "container_name" {
  value = var.container_name
}
