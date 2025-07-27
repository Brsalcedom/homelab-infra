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