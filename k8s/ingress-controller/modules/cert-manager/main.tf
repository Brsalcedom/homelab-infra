resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = var.namespace
  version          = var.chart_version
  create_namespace = false

  set = [
    {
      name  = "crds.enabled"
      value = "true"
    }
  ]

  set_list = [
  {
    name  = "extraArgs"
    value = ["--dns01-recursive-nameservers=1.1.1.1:53,1.0.0.1:53", "--dns01-recursive-nameservers-only"]
  }
  ]
}

resource "kubectl_manifest" "cloudflare_api_token_secret" {
  yaml_body = <<YAML
    apiVersion: v1
    kind: Secret
    metadata:
      name: cloudflare-api-token-secret
      namespace: ${var.namespace}
    type: Opaque
    data:
      api-token: ${base64encode(var.cloudflare_api_token)}
YAML
}



resource "kubectl_manifest" "cert_manager_clusterissuer" {
  yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: ${var.issuer_name}
spec:
  acme:
    email: ${var.cloudflare_email}
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: cloudflare-clusterissuer-account-key
    solvers:
    - dns01:
        cloudflare:
          email: ${var.cloudflare_email}
          apiTokenSecretRef:
            name: cloudflare-api-token-secret
            key: api-token
YAML

  depends_on = [
    helm_release.cert_manager,
    kubectl_manifest.cloudflare_api_token_secret
  ]
}
