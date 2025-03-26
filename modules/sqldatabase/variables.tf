variable "resource_group_name" {
  type        = string
  default     = "terraformado-sql-rg"
}

variable "location" {
  type        = string
  default     = "canadacentral"
}

variable "server_name" {
  type        = string
  default     = "terraformadosqlserver"
}

variable "database_name" {
  type        = string
  default     = "terraformadodb"
}

variable "admin_username" {
  type        = string
  default     = "sqladminuser"
}

variable "admin_password" {
  type        = string
  default     = "MyComplexPassword123!"  # Change this to a secure one or use variable injection
  sensitive   = true
}

variable "sku_name" {
  type        = string
  default     = "Basic"
}

variable "vm_public_ip" {
  type        = string
  description = "Public IP address of the VM to allow SQL access"
  default     = "YOUR.VM.IP.HERE"  # Update or inject in root config
}
