resource "helm_release" "metallb" {
  name             = "metallb"
  repository       = "https://metallb.github.io/metallb"
  chart            = "metallb"
  namespace        = var.namespace
  version          = var.chart_version
  create_namespace = false

  set = [
  {
    name  = "crds.enabled"
    value = "true"
  },
  {
    name = "webhookCertGen.enabled"
    value = "false"
  }
  ]
}

resource "kubectl_manifest" "ipaddress_pool" {
  yaml_body = <<YAML
    apiVersion: metallb.io/v1beta1
    kind: IPAddressPool
    metadata:
      name: ${var.pool_name}
      namespace: ${var.namespace}
    spec:
      addresses:
        - ${var.ip_range}
YAML

  depends_on = [helm_release.metallb]
}


resource "kubectl_manifest" "l2_advertisement" {
  yaml_body = <<YAML
    apiVersion: metallb.io/v1beta1
    kind: L2Advertisement
    metadata:
      name: ${var.l2_advertisement_name}
      namespace: ${var.namespace}
    spec:
      ipAddressPools:
        - ${var.pool_name}
YAML

  depends_on = [kubectl_manifest.ipaddress_pool]
}
