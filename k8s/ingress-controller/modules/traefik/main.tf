resource "helm_release" "traefik" {
  name             = "traefik"
  repository       = "https://helm.traefik.io/traefik"
  chart            = "traefik"
  namespace        = var.namespace
  version          = var.chart_version
  create_namespace = false
}

locals {
  traefik_config = <<-EOT
    entryPoints:
      web:
        address: ":80"
        http:
          redirections:
            entryPoint:
              to: "websecure"
              scheme: "https"
              permanent: true
      websecure:
        address: ":443"
    providers:
      kubernetesCRD: {}
      kubernetesIngress: {}
    certificatesResolvers:
      letsencrypt:
        acme:
          email: "${var.acme_email}"
          storage: "/data/acme.json"
          httpChallenge:
            entryPoint: web
  EOT
}

resource "kubernetes_config_map" "traefik_config" {
  metadata {
    name      = "traefik-config"
    namespace = var.namespace
  }

  data = {
    "traefik.yml" = local.traefik_config
  }

  depends_on = [helm_release.traefik]
}
