module "ansible" {
  source            = "../../modules/cloud-init"
  vm_name           = var.vm_name
  vm_tags           = var.vm_tags
  vm_memory         = var.vm_memory
  vm_id             = var.vm_id
  vm_cpu_cores      = var.vm_cpu_cores
  vm_ipv4_address   = var.vm_ipv4_address
  vm_ipv4_gateway   = var.vm_ipv4_gateway
  vm_username       = var.vm_username
  node_name         = var.node_name
  clone_vm_id       = var.clone_vm_id
  dns_servers       = var.dns_servers
  vm_description    = var.vm_description
  runcmd            = var.runcmd
  packages          = var.packages
}