module "pihole" {
  source          = "../../modules/lxc"
  vm_name         = var.vm_name
  vm_tags         = var.vm_tags
  vm_memory       = var.vm_memory
  vm_id           = var.vm_id
  vm_cpu_cores    = var.vm_cpu_cores
  vm_ipv4_address = var.vm_ipv4_address
  vm_ipv4_gateway = var.vm_ipv4_gateway
  node_name       = var.node_name
  dns_server      = var.dns_server
  vm_description  = var.vm_description
  os_template     = var.os_template
  vm_disk_size    = var.vm_disk_size
}