variable "namespace" {
  type = string
}

variable "chart_version" {
  type = string
}

variable "acme_email" {
  type        = string
  description = "Email address for ACME registration with Traefik"
}