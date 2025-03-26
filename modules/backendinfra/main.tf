resource "azurerm_resource_group" "tfstate_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "dev" {
  name                     = var.dev_storage_account
  resource_group_name      = azurerm_resource_group.tfstate_rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account" "test" {
  name                     = var.test_storage_account
  resource_group_name      = azurerm_resource_group.tfstate_rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "dev" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.dev.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "test" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.test.name
  container_access_type = "private"
}
