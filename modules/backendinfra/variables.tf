variable "resource_group_name" {
  type        = string
  default     = "terraform-state-rg"
}

variable "location" {
  type        = string
  default     = "canadacentral"
}

variable "dev_storage_account" {
  type        = string
  default     = "tfdevbackdanish"
}

variable "test_storage_account" {
  type        = string
  default     = "tfstagedanish"
}

variable "container_name" {
  type        = string
  default     = "tfstate"
}
