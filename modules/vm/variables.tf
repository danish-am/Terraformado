variable "resource_group_name" {
  type        = string
  default     = "terraformado-vm-rg"
  description = "Name of the resource group for the VM"
}

variable "location" {
  type        = string
  default     = "canadacentral"
  description = "Azure region"
}

variable "vm_name" {
  type        = string
  default     = "ubuntu-dev"
  description = "Name of the virtual machine"
}

variable "vm_size" {
  type        = string
  default     = "Standard_B1s"
  description = "Size of the VM"
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
  description = "Admin username for the VM"
}

variable "ssh_public_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCu123EXAMPLEfakeSSHkeyonly"
  description = "SSH public key for authentication"
}
