variable "proxmox_endpoint" {
  description = "Proxmox API endpoint"
  type        = string
}

variable "vm_name" {
  description = "Name of the LXC container"
  type        = string
}

variable "vm_id" {
  description = "ID of the LXC to create or clone"
  type        = number
}

variable "vm_memory" {
  description = "Memory allocated to the LXC in MB"
  type        = number
  default     = 768
}

variable "vm_cpu_cores" {
  description = "Number of CPU cores allocated to the LXC"
  type        = number
  default     = 1
}

variable "vm_ipv4_address" {
  description = "IPv4 address configuration for the LXC"
  type        = string
}

variable "vm_ipv4_gateway" {
  description = "IPv4 gateway for the LXC"
  type        = string
}

variable "vm_description" {
  description = "Description of the LXC"
  type        = string
}

variable "node_name" {
  description = "Proxmox node name where the LXC will be created"
  type        = string
  default     = "pve"
}

variable "dns_server" {
  description = "DNS server to use for the LXC container"
  type        = string
}

variable "vm_tags" {
  description = "List of tags to apply to the LXC container"
  type        = string
  default     = "terraform;lxc"
}

variable "os_template" {
  description = "OS template to use for the LXC container"
  type        = string
}

variable "vm_disk_size" {
  description = "Disk size for the LXC in GB"
  type        = number
  default     = 4
}

variable "pm_api_token_id" {
  description = "Proxmox API token ID"
  type        = string
}
variable "pm_api_token_secret" {
  description = "Proxmox API token secret"
  type        = string
}