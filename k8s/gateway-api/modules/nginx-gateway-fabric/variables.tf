variable "namespace" {
  type = string
}

variable "chart_version" {
  type = string
}

variable "gateway_api_crds_url" {
  type    = string
}

variable "issuer_name" {
  type        = string
  description = "Name for the ClusterIssuer"
}

variable "base_domain" {
  type        = string
  description = "Base domain for the gateway"
}