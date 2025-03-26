variable "location" {
  description = "Azure region to deploy AKS cluster in"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group for AKS"
  type        = string
}

variable "service_principal_name" {
  description = "Name of the service principal used by AKS"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key used for AKS node authentication"
  type        = string
}

variable "client_id" {
  description = "Client ID of the service principal"
  type        = string
}

variable "client_secret" {
  description = "Client secret of the service principal"
  type        = string
  sensitive   = true
}

variable "node_pool_name" {
  description = "Name of the AKS node pool"
  type        = string
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}
