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
      }
    })
  ]
}

resource "kubectl_manifest" "argocd_httproute" {
  yaml_body = <<YAML
    apiVersion: gateway.networking.k8s.io/v1
    kind: HTTPRoute
    metadata:
      name: argocd-route
      namespace: argocd
    spec:
      parentRefs:
        - name: nginx-gateway
          namespace: nginx
          sectionName: "https"
      hostnames:
      - "argocd.home.cervant.net"
      rules:
      - matches:
          - path:
              type: PathPrefix
              value: /
        backendRefs:
          - name: argocd-server
            port: 80
YAML
  depends_on = [helm_release.argocd]
}

resource "kubectl_manifest" "argocd_httproute_redirect" {
  yaml_body = <<YAML
    apiVersion: gateway.networking.k8s.io/v1
    kind: HTTPRoute
    metadata:
      name: argocd-redirect-route
      namespace: argocd
    spec:
      parentRefs:
        - name: nginx-gateway
          namespace: nginx
          sectionName: "http"
      hostnames:
      - "argocd.home.cervant.net"
      rules:
      - matches:
          - path:
              type: PathPrefix
              value: /
        filters:
          - type: RequestRedirect
            requestRedirect:
              scheme: "https"
              statusCode: 301
YAML
  depends_on = [helm_release.argocd]
}
