output "traefik_version" {
  description = "Traefik version installed"
  value       = module.traefik.release_version
}

output "cert_manager_version" {
  description = "cert-manager version installed"
  value       = module.cert_manager.release_version
}

output "metallb_version" {
  description = "MetalLB version installed"
  value       = module.metallb.release_version
}

output "argocd_version" {
  description = "ArgoCD version installed"
  value       = module.argocd.release_version
}

output "argocd_url" {
  description = "ArgoCD web interface URL"
  value       = module.argocd.argocd_url
}

output "argocd_admin_password_command" {
  description = "Command to get the ArgoCD admin password"
  value       = module.argocd.argocd_admin_password_command
}