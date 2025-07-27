provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  insecure  = true
  api_token = var.proxmox_api_token
  ssh {
    agent       = true
    username    = "terraform"
    private_key = file("C:\\Users\\Cervant\\.ssh\\id_rsa_terraform")
  }
}