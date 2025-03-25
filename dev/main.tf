# Create a Resource Group in the specified location
resource "azurerm_resource_group" "rg1" {
  name     = var.rgname              # Name of the resource group from variables
  location = var.location            # Azure region (e.g., canadacentral)
}

# Create a Service Principal using a custom module
module "ServicePrincipal" {
  source                 = "../modules/ServicePrincipal"  # Path to your SP module
  service_principal_name = var.service_principal_name     # SP name from variables

  depends_on = [
    azurerm_resource_group.rg1  # Ensure the resource group is created first
  ]
}

# Assign the "Contributor" role to the Service Principal at the subscription level
resource "azurerm_role_assignment" "rolespn" {
  scope                = "/subscriptions/${var.SUB_ID}"  # The scope for the role (entire subscription)
  role_definition_name = "Contributor"                   # The role to assign
  principal_id         = module.ServicePrincipal.service_principal_object_id  # SP's object ID

  depends_on = [
    module.ServicePrincipal  # Ensure SP is created before assigning role
  ]
}

# Deploy a Key Vault using a module, and grant access to the Service Principal
module "keyvault" {
  source                      = "../modules/keyvault"  # Path to your Key Vault module
  keyvault_name               = var.keyvault_name      # Key Vault name from variables
  location                    = var.location           # Azure region
  resource_group_name         = var.rgname             # Resource group name
  service_principal_name      = var.service_principal_name
  service_principal_object_id = module.ServicePrincipal.service_principal_object_id
  service_principal_tenant_id = module.ServicePrincipal.service_principal_tenant_id

  depends_on = [
    module.ServicePrincipal  # Ensure SP is created before key vault
  ]
}

# Store the Service Principal's client secret as a secret in the Key Vault
resource "azurerm_key_vault_secret" "example" {
  name         = module.ServicePrincipal.client_id   # Use SP client ID as the secret name
  value        = module.ServicePrincipal.client_secret  # Store the SP's client secret
  key_vault_id = module.keyvault.keyvault_id         # ID of the Key Vault to store the secret in

  depends_on = [
    module.keyvault  # Ensure Key Vault is created before storing the secret
  ]
}

# Deploy an Azure Kubernetes Service (AKS) cluster using the Service Principal
module "aks" {
  source                 = "../modules/aks/"              # Path to your AKS module
  service_principal_name = var.service_principal_name     # SP name from variables
  client_id              = module.ServicePrincipal.client_id     # SP client ID
  client_secret          = module.ServicePrincipal.client_secret  # SP secret
  location               = var.location
  resource_group_name    = var.rgname
  cluster_name           = var.cluster_name               # AKS cluster name
  node_pool_name         = var.node_pool_name             # Node pool name

  depends_on = [
    module.ServicePrincipal  # Ensure SP is ready before deploying AKS
  ]
}

# Output the AKS kubeconfig file locally so users can connect to the cluster
resource "local_file" "kubeconfig" {
  depends_on = [module.aks]                # Wait for AKS to be fully deployed
  filename   = "./kubeconfig"              # Path where kubeconfig will be saved
  content    = module.aks.config           # Kubeconfig content from the AKS module output
}
