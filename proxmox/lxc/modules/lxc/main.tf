resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "proxmox_lxc" "lxc_container" {
  hostname    = var.vm_name
  description = var.vm_description
  vmid        = var.vm_id
  target_node = var.node_name
  tags        = var.vm_tags
  ostemplate  = "local:vztmpl/${var.os_template}"
  cores       = var.vm_cpu_cores
  memory      = var.vm_memory
  swap        = var.vm_memory
  rootfs {
    storage = "local-lvm"
    size    = "${var.vm_disk_size}G"
  }
  nameserver = var.dns_server
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = var.vm_ipv4_address
    gw     = var.vm_ipv4_gateway
  }
  features {
    nesting = true
  }
  unprivileged    = true
  ssh_public_keys = tls_private_key.private_key.public_key_openssh
  onboot          = true
}
