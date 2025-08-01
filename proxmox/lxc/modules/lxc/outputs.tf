output "ssh_private_key" {
  description = "SSH private key generated by Terraform for connecting to the VM"
  value       = tls_private_key.private_key.private_key_pem
  sensitive   = true
}