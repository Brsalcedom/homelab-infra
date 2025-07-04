
# 🏠 Homelab Infra – Terraform Kubernetes Bootstrap

Este repositorio contiene la infraestructura base para un homelab autogestionado. Está orientado a entornos locales donde se requiere desplegar Kubernetes con funcionalidades modernas como balanceo de carga, certificados TLS automatizados y GitOps, utilizando herramientas de código abierto como Terraform, Helm y ArgoCD.

## ⚙️ Requisitos

- [Terraform v1.9.0+](https://www.terraform.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Acceso a un clúster Kubernetes válido (ej. K3s, MicroK8s, Proxmox VM, etc.)
- Acceso a Cloudflare (token API + email)
- Helm Provider configurado
- Conexión a Internet desde los nodos del clúster
- Dominio público registrado (DNS)

## 📁 Estructura del Proyecto

```plaintext
.
└── k8s
    └── ingress-controller
        ├── modules
        │   ├── argocd/
        │   ├── cert-manager/
        │   ├── metallb/
        │   ├── namespace/
        │   └── traefik/
        ├── main.tf
        ├── outputs.tf
        ├── providers.tf
        ├── terraform.tfstate
        ├── terraform.tfstate.backup
        ├── terraform.tfvars
        ├── variables.tf
        └── versions.tf
```

## 📦 Subproyectos principales
- [k8s/ingress-controller](./k8s/ingress-controller/README.md): Infraestructura básica del clúster Kubernetes, enfocada en instalar lo básico para desplegar aplicaciones de forma segura y escalable. Incluye módulos para MetalLB, Traefik, cert-manager y ArgoCD.


## 🚀 ¿Cómo empezar?

Consulta el [README](./k8s/ingress-controller/README.md) del subproyecto de ingress-controller para comenzar a desplegar tu clúster Kubernetes en tu homelab.