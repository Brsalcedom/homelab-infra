output "release_version" {
  value = helm_release.argocd.version
}

output "argocd_url" {
  description = "ArgoCD web interface URL"
  value       = "https://${var.fqdn}"
}

output "argocd_admin_password_command" {
  description = "Command to get the initial ArgoCD admin password with kubectl"
  value       = "kubectl get secret argocd-initial-admin-secret -n ${var.namespace} -o jsonpath='{.data.password}' | base64 -d && echo"
}

