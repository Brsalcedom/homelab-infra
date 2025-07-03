resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = false

  values = [
    yamlencode({
      global = {
        domain = var.fqdn
      }

      configs = {
        params = {
          "server.insecure" = true
        }
      }

      server = {
        service = {
          type = "ClusterIP"
        }

        ingress = {
          enabled          = true
          ingressClassName = "traefik"
          annotations = {
            "traefik.ingress.kubernetes.io/router.entrypoints" = var.traefik_entrypoint
            "traefik.ingress.kubernetes.io/router.tls"         = "true"
            "cert-manager.io/cluster-issuer"                   = var.cert_manager_issuer
          }
          hosts = [
            var.fqdn
          ]
          tls = [{
            hosts      = [var.fqdn]
            secretName = "${var.fqdn}-tls"
          }]
        }
      }
    })
  ]
}
