variable "namespace" {
  type        = string
  description = "Namespace to install cert-manager"
}

variable "chart_version" {
  type        = string
  description = "Helm chart version for cert-manager"
}

variable "issuer_name" {
  type        = string
  description = "Name for the ClusterIssuer"
}

variable "cloudflare_api_token" {
  type        = string
  sensitive   = true
  description = "Cloudflare API token for DNS01 challenge"
}

variable "cloudflare_email" {
  type        = string
  description = "Cloudflare email associated with the API token"
}
