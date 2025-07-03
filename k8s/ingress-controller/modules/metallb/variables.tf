variable "namespace" {
  type = string
}

variable "chart_version" {
  type = string
}

variable "ip_range" {
  type = string
}

variable "pool_name" {
  type = string
  default = "metallb-ipaddresspool"
}

variable "l2_advertisement_name" {
  type = string
  default = "metallb-l2advertisement"
}