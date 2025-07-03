module "metallb_namespace" {
  source = "./modules/namespace"
  name   = var.metallb_namespace
  labels = {
    "pod-security.kubernetes.io/enforce" = "privileged"
    "pod-security.kubernetes.io/audit"   = "privileged"
    "pod-security.kubernetes.io/warn"    = "privileged"
  }
}

module "metallb" {
  source        = "./modules/metallb"
  namespace     = var.metallb_namespace
  chart_version = var.metallb_version
  ip_range      = var.metallb_ip_range

  depends_on = [module.metallb_namespace]
}


module "traefik_namespace" {
  source = "./modules/namespace"
  name   = var.traefik_namespace
}

module "traefik" {
  source        = "./modules/traefik"
  namespace     = var.traefik_namespace
  chart_version = var.traefik_version
  acme_email    = var.traefik_acme_email

  depends_on = [module.traefik_namespace]
}

module "cert_manager_namespace" {
  source = "./modules/namespace"
  name   = var.cert_manager_namespace
}

module "cert_manager" {
  source               = "./modules/cert-manager"
  namespace            = var.cert_manager_namespace
  chart_version        = var.cert_manager_version
  issuer_name          = var.cert_manager_issuer
  cloudflare_api_token = var.cloudflare_api_token
  cloudflare_email     = var.cloudflare_email

  depends_on = [module.cert_manager_namespace]
}

module "argocd_namespace" {
  source = "./modules/namespace"
  name   = var.argocd_namespace
}

module "argocd" {
  source              = "./modules/argocd"
  namespace           = var.argocd_namespace
  chart_version       = var.argocd_version
  fqdn                = var.argocd_fqdn
  traefik_entrypoint  = var.traefik_entrypoint
  cert_manager_issuer = var.cert_manager_issuer

  depends_on = [module.argocd_namespace]
}