variable "kubeconfig" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "kubeconfig_context" {
  description = "Kubernetes context to use from the kubeconfig file"
  type        = string
  default     = "default"
}

variable "metallb_namespace" {
  description = "Namespace for the MetalLB installation"
  type        = string
  default     = "metallb-system"
}

variable "metallb_version" {
  description = "Version of the MetalLB Helm chart"
  type        = string
  default     = "v0.15.2"
}

variable "metallb_ip_range" {
  description = "IP range for MetalLB to use for LoadBalancer services"
  type        = string
}

variable "nginx_namespace" {
  description = "Namespace for the Nginx ingress controller"
  type        = string
  default     = "nginx"
}

variable "nginx_version" {
  description = "Version of the Nginx Helm chart"
  type        = string
  default     = "2.0.2"
}

variable "cert_manager_namespace" {
  description = "Namespace for the cert-manager release"
  type        = string
  default     = "cert-manager"
}

variable "cert_manager_version" {
  description = "Version of the cert-manager Helm chart"
  type        = string
  default     = "v1.18.0"
}

variable "cert_manager_issuer" {
  description = "Cluster issuer name for cert-manager to use with Nginx"
  type        = string
  default     = "cloudflare-clusterissuer"
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token for cert-manager"
  type        = string
}

variable "cloudflare_email" {
  description = "Email address associated with the Cloudflare account"
  type        = string
}

variable "argocd_namespace" {
  description = "Namespace for the ArgoCD installation"
  type        = string
  default     = "argocd"
}

variable "argocd_version" {
  description = "Version of the ArgoCD Helm chart"
  type        = string
  default     = "8.1.1"
}

variable "argocd_fqdn" {
  description = "Fully qualified domain name for the ArgoCD web interface"
  type        = string
}

variable "gateway_api_crds_url" {
  description = "URL for Gateway API CRDs"
  type        = string
  default     = "https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.3.0/standard-install.yaml"
}
