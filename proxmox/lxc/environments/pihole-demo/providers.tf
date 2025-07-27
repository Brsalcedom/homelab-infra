provider "proxmox" {
  pm_api_url          = var.proxmox_endpoint
  pm_tls_insecure     = true
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
}