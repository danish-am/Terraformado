output "vm_id" {
  value       = azurerm_linux_virtual_machine.vm.id
  description = "The ID of the created VM"
}

output "private_ip" {
  value       = azurerm_network_interface.nic.private_ip_address
  description = "The private IP of the VM"
}
