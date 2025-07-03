variable "namespace" {
  description = "Name of the namespace where ArgoCD will be installed"
  type        = string
}


variable "chart_version" {
  description = "Version of the ArgoCD Helm chart to deploy"
  type        = string
}

variable "fqdn" {
  description = "Fully qualified domain name for the ArgoCD web interface"
  type        = string
}

variable "traefik_entrypoint" {
  description = "Traefik entrypoint to use for ArgoCD"
  type        = string
}

variable "cert_manager_issuer" {
  description = "Cluster issuer for cert-manager to use with ArgoCD"
  type        = string
}