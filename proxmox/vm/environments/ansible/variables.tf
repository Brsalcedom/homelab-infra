variable "proxmox_endpoint" {
  description = "Proxmox API endpoint"
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox API token in the format user@realm!token=uuid"
  type        = string
}

variable "vm_name" {
  description = "Name of the VM"
  type        = string
  default     = "ubuntu-clone"
}

variable "vm_id" {
  description = "ID of the VM to create or clone"
  type        = number
}

variable "vm_memory" {
  description = "Memory allocated to the VM in MB"
  type        = number
  default     = 768
}

variable "vm_cpu_cores" {
  description = "Number of CPU cores allocated to the VM"
  type        = number
  default     = 1
}

variable "vm_ipv4_address" {
  description = "IPv4 address configuration for the VM"
  type        = string
}

variable "vm_ipv4_gateway" {
  description = "IPv4 gateway for the VM"
  type        = string
}

variable "vm_username" {
  description = "Username for the VM user account"
  type        = string
  default     = "ubuntu"
}

variable "vm_description" {
  description = "Description of the VM"
  type        = string
}

variable "node_name" {
  description = "Proxmox node name where the VM will be created"
  type        = string
  default     = "pve"
}

variable "clone_vm_id" {
  description = "ID of the VM to clone from"
  type        = number
}

variable "dns_servers" {
  description = "List of DNS servers to use for the VM"
  type        = list(string)
}

variable "packages" {
  description = "List of packages to install on the VM"
  type        = list(string)
  default     = ["curl", "unzip", "kubectl", "jq"]
}

variable "runcmd" {
  description = "Commands to run after the VM is initialized"
  type        = list(string)
  default     = []
}

variable "vm_tags" {
  description = "List of tags to apply to the VM"
  type        = list(string)
  default     = ["terraform"]
}
