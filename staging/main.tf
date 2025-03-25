resource "azurerm_resource_group" "rg1" {
  name     = var.rgname
  location = var.location
}

module "ServicePrincipal" {
  source                 = "../modules/ServicePrincipal"
  service_principal_name = var.service_principal_name

  depends_on = [
    azurerm_resource_group.rg1
  ]# Create a Resource Group
resource "azurerm_resource_group" "rg1" {
  name     = var.rgname
  location = var.location
}

# Create a Service Principal using a module
module "ServicePrincipal" {
  source                 = "../modules/ServicePrincipal"
  service_principal_name = var.service_principal_name

  # Ensure the resource group is created before the SP
  depends_on = [
    azurerm_resource_group.rg1
  ]
}

# Assign Contributor role to the Service Principal at the subscription level
resource "azurerm_role_assignment" "rolespn" {
  scope                = "/subscriptions/${var.SUB_ID}" # Target subscription
  role_definition_name = "Contributor"                  # Role to assign
  principal_id         = module.ServicePrincipal.service_principal_object_id

  # Wait for the SP to be created before assigning role
  depends_on = [
    module.ServicePrincipal
  ]
}

# Create a Key Vault using a module and grant access to the Service Principal
module "keyvault" {
  source                      = "../modules/keyvault"
  keyvault_name               = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.rgname
  service_principal_name      = var.service_principal_name
  service_principal_object_id = module.ServicePrincipal.service_principal_object_id
  service_principal_tenant_id = module.ServicePrincipal.service_principal_tenant_id

  # Ensure SP is created before creating the key vault
  depends_on = [
    module.ServicePrincipal
  ]
}

# Store the Service Principal's client secret in Azure Key Vault
resource "azurerm_key_vault_secret" "example" {
  name         = module.ServicePrincipal.client_id       # Secret name = client ID
  value        = module.ServicePrincipal.client_secret   # Secret value = client secret
  key_vault_id = module.keyvault.keyvault_id             # Target key vault

  # Wait for key vault to be available
  depends_on = [
    module.keyvault
  ]
}

# Create an Azure Kubernetes Service (AKS) cluster using the Service Principal
module "aks" {
  source                 = "../modules/aks/"
  service_principal_name = var.service_principal_name
  client_id              = module.ServicePrincipal.client_id
  client_secret          = module_

}

resource "azurerm_role_assignment" "rolespn" {

  scope                = "/subscriptions/${var.SUB_ID}"
  role_definition_name = "Contributor"
  principal_id         = module.ServicePrincipal.service_principal_object_id

  depends_on = [
    module.ServicePrincipal
  ]
}

module "keyvault" {
  source                      = "../modules/keyvault"
  keyvault_name               = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.rgname
  service_principal_name      = var.service_principal_name
  service_principal_object_id = module.ServicePrincipal.service_principal_object_id
  service_principal_tenant_id = module.ServicePrincipal.service_principal_tenant_id

  depends_on = [
    module.ServicePrincipal
  ]
}

resource "azurerm_key_vault_secret" "example" {
  name         = module.ServicePrincipal.client_id
  value        = module.ServicePrincipal.client_secret
  key_vault_id = module.keyvault.keyvault_id

  depends_on = [
    module.keyvault
  ]
}

#create Azure Kubernetes Service
module "aks" {
  source                 = "../modules/aks/"
  service_principal_name = var.service_principal_name
  client_id              = module.ServicePrincipal.client_id
  client_secret          = module.ServicePrincipal.client_secret
  location               = var.location
  resource_group_name    = var.rgname
  cluster_name           = var.cluster_name
  node_pool_name         = var.node_pool_name

  depends_on = [
    module.ServicePrincipal
  ]
}

resource "local_file" "kubeconfig" {
  depends_on   = [module.aks]
  filename     = "./kubeconfig"
  content      = module.aks.config
  
}
