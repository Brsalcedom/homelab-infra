output "vm_username" {
  value     = module.ansible.vm_username
  sensitive = false
}

output "ssh_private_key" {
  description = "SSH private key generated by Terraform for connecting to the VM"
  value       = module.ansible.ssh_private_key
  sensitive   = true
}