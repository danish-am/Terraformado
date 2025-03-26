resource "azurerm_resource_group" "sql_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = var.server_name
  resource_group_name          = azurerm_resource_group.sql_rg.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  minimum_tls_version          = "1.2"
}

resource "azurerm_mssql_database" "sql_db" {
  name           = var.database_name
  server_id      = azurerm_mssql_server.sql_server.id
  sku_name       = var.sku_name
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = 2
}

# Allow all Azure services (like VMs in same region)
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Allow connection from your VM public IP
resource "azurerm_mssql_firewall_rule" "allow_vm" {
  name             = "AllowMyVM"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = var.vm_public_ip
  end_ip_address   = var.vm_public_ip
}
