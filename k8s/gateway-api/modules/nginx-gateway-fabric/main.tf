resource "null_resource" "install_gateway_api_crds" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${var.gateway_api_crds_url}"
  }
}

resource "helm_release" "nginx_gateway_fabric" {
  name             = "nginx-gateway-fabric"
  chart            = "oci://ghcr.io/nginx/charts/nginx-gateway-fabric"
  namespace        = var.namespace
  version          = var.chart_version 
  create_namespace = false

  set = [
    {
      name  = "controller.replicaCount"
      value = "1"
    }
  ]
  depends_on = [null_resource.install_gateway_api_crds]
}


resource "kubectl_manifest" "gateway" {
  yaml_body = <<YAML
    apiVersion: gateway.networking.k8s.io/v1
    kind: Gateway
    metadata:
      name: nginx-gateway
      namespace: ${var.namespace}
    spec:
      gatewayClassName: nginx
      listeners:
        - name: https
          protocol: HTTPS
          port: 443
          hostname: "*.home.cervant.net"
          tls:
            mode: Terminate
            certificateRefs:
            - kind: Secret
              name: tls-cert
              namespace: ${var.namespace}
          allowedRoutes:
            namespaces:
              from: All
        - name: http
          protocol: HTTP
          port: 80
          hostname: "*.home.cervant.net"
          allowedRoutes:
            namespaces:
              from: All
YAML
  depends_on = [helm_release.nginx_gateway_fabric]
}


resource "kubectl_manifest" "certificate" {
  yaml_body = <<YAML
    apiVersion: cert-manager.io/v1
    kind: Certificate
    metadata:
      name: wildcard-certificate
      namespace: ${var.namespace}
    spec:
      secretName: tls-cert
      issuerRef:
        name: ${var.issuer_name}
        kind: ClusterIssuer
      commonName: "*.home.cervant.net"
      dnsNames:
        - "*.home.cervant.net"
YAML
  depends_on = [helm_release.nginx_gateway_fabric]
}
