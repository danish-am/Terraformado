variable "rgname" {
  description = "Name of the resource group"
  type        = string
  default     = "terraformado-test-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "canadacentral"
}

variable "SUB_ID" {
  description = "Azure Subscription ID"
  type        = string
}

variable "service_principal_name" {
  description = "Name of the Service Principal"
  type        = string
  default     = "terraformado-test-sp"
}

variable "keyvault_name" {
  description = "Name of the Azure Key Vault"
  type        = string
  default     = "terraformado-kv-test"
}

variable "cluster_name" {
  description = "AKS Cluster name"
  type        = string
  default     = "terraformado-aks-test"
}

variable "node_pool_name" {
  description = "Name of the AKS node pool"
  type        = string
  default     = "np-test"
}

# ───────────────────────────────────────────────
# VM Variables
variable "vm_admin_username" {
  description = "Admin username for the Ubuntu VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "Public SSH key for the VM"
  type        = string
}

# ───────────────────────────────────────────────
# SQL DB Variables
variable "sql_admin_password" {
  description = "Admin password for SQL Database"
  type        = string
  sensitive   = true
}
