## 🌐 Kubernetes Ingress Controller Setup

Este directorio contiene la configuración principal de infraestructura para levantar la capa de red de un clúster Kubernetes en tu homelab. Aquí se despliegan herramientas críticas como:

- MetalLB: para balanceo de carga en redes locales.
- Traefik: como Ingress Controller con ACME.
- Cert-Manager: para certificados TLS con Let's Encrypt.
- ArgoCD: para gestión GitOps aplicaciones.

## 🧱 Estructura de directorios

```plaintext
k8s/ingress-controller/
├── main.tf              # Composición general de los módulos
├── variables.tf         # Definición de variables
├── outputs.tf           # Resultados exportados
├── providers.tf         # Proveedores usados (Helm, Kubernetes)
├── versions.tf          # Versiones de Terraform y proveedores
├── terraform.tfvars     # Valores personalizados
└── modules/             # Módulos reutilizables por componente
```

## 📥 Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/Brsalcedom/homelab-infra.git
cd homelab-infra
```

### 2. Crear archivo `terraform.tfvars`

Ejemplo:

```hcl
kubeconfig              = "C:\\Users\\Cervant\\.kube\\config"
kubeconfig_context      = "default"
metallb_ip_range        = "192.168.1.240-192.168.1.250"
traefik_acme_email      = "you@example.com"
cloudflare_api_token    = "your-cloudflare-token"
cloudflare_email        = "you@example.com"
argocd_fqdn             = "argocd.yourdomain.com"
```

Para ver la lista completa de variables revisar el archivo [variables.tf](./k8s/ingress-controller/variables.tf). 

**Se recomienda especificar y validar la ruta y contexto de kubernetes antes de aplicar con terraform**.

### 3. Inicializar Terraform

```bash
terraform init
```

### 4. Aplicar configuración

```bash
terraform apply
```

## 🧾 Variables principales

| Nombre                    | Descripción                                               | Tipo     | Default                |
|---------------------------|-----------------------------------------------------------|----------|------------------------|
| `metallb_ip_range`        | Rango IP para MetalLB                                     | `string` | —                      |
| `traefik_acme_email`      | Email para certificados ACME                             | `string` | —                      |
| `cloudflare_api_token`    | Token de API de Cloudflare                               | `string` | —                      |
| `cloudflare_email`        | Email de tu cuenta de Cloudflare                         | `string` | —                      |
| `argocd_fqdn`             | Dominio para acceder a ArgoCD                            | `string` | —                      |
| `traefik_entrypoint`      | Entrypoint de Traefik (ej. `websecure`)                  | `string` | `"websecure"`          |
| `argocd_namespace`        | Namespace para ArgoCD                                    | `string` | `"argocd"`             |
| `cert_manager_version`    | Versión de cert-manager (Helm)                           | `string` | `"v1.18.0"`            |
| `metallb_version`         | Versión de MetalLB (Helm)                                | `string` | `"v0.15.2"`            |
| `traefik_version`         | Versión de Traefik (Helm)                                | `string` | `"v36.1.0"`            |

## 📤 Outputs

| Nombre                        | Descripción                                 |
|------------------------------|---------------------------------------------|
| `traefik_version`            | Versión instalada de Traefik                |
| `cert_manager_version`       | Versión instalada de cert-manager           |
| `metallb_version`            | Versión instalada de MetalLB                |
| `argocd_version`             | Versión instalada de ArgoCD                 |
| `argocd_url`                 | URL para acceder a la UI de ArgoCD          |
| `argocd_admin_password_command` | Comando para obtener contraseña admin ArgoCD |


## 🔐 Certificados TLS con cert-manager + Cloudflare

Este setup utiliza el **desafío DNS-01 de Let's Encrypt** a través de la API de Cloudflare para emitir certificados válidos para Traefik y ArgoCD.

- Recuerda crear un `ClusterIssuer` para poder emitir certificados automáticamente. Por defecto es nombrado `cloudflare-clusterissuer`
- Asegúrate que tu dominio esté delegando correctamente los registros DNS en Cloudflare

## 🔗 Módulos reutilizables

Este repositorio está diseñado de forma modular. Cada componente (como ArgoCD, Traefik, MetalLB, etc.) está encapsulado en su propio **módulo de Terraform** ubicado dentro de la carpeta `modules/`. Esto permite reutilizar y mantener separadas las distintas funcionalidades del clúster.

### 📦 ¿Qué es un módulo en Terraform?

Un módulo es una colección de archivos Terraform que encapsulan una funcionalidad específica. En este proyecto, por ejemplo:

- `modules/metallb/`: instala y configura MetalLB mediante Helm.
- `modules/traefik/`: despliega el controlador de ingress Traefik.
- `modules/cert-manager/`: configura cert-manager con soporte ACME.
- `modules/argocd/`: instala ArgoCD con HTTPS y configuración inicial.
- `modules/namespace/`: crea namespaces personalizados para los módulos anteriores.

Cada módulo acepta variables (`variables.tf`) y expone salidas (`outputs.tf`) para facilitar su integración.

## ⚙️ Personalización del despliegue

Puedes personalizar tu entorno modificando el archivo `main.tf`. Aquí defines **qué módulos deseas incluir**, en qué orden y con qué configuraciones.

### Ejemplo: añadir solo Traefik y ArgoCD

```hcl
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
```

Puedes comentar, eliminar o agregar módulos según tus necesidades.

## 🚀 ArgoCD – GitOps para Kubernetes

ArgoCD es una herramienta declarativa de entrega continua (CD) para Kubernetes. Permite gestionar la configuración de tu clúster directamente desde repositorios Git, siguiendo el enfoque GitOps. Toda la infraestructura y aplicaciones se sincronizan automáticamente con los manifiestos definidos en Git.

### Acceder a la interfaz web de ArgoCD

Una vez desplegado el entorno con Terraform, puedes obtener la URL y credenciales para acceder a la interfaz web:

```bash
# Obtener la URL de acceso
terraform output -raw argocd_url

# Obtener la contraseña del usuario admin
terraform output -raw argocd_admin_password_command
```
| 💡 El usuario por defecto es admin.

### 🔐 Primer acceso

1. Abre la URL generada en tu navegador.
2. Inicia sesión con el usuario `admin` y la contraseña proporcionada.
3. Desde la interfaz puedes:
   - Conectar repositorios Git con manifiestos declarativos
   - Definir aplicaciones y sincronizarlas con el clúster
   - Observar el estado de tus despliegues y cambios en tiempo real

## 🧹 Desinstalación

```bash
terraform destroy
```

## 📝 Licencia

MIT © [Brsalcedom](https://github.com/Brsalcedom)

## 🙌 Créditos

Este proyecto fue desarrollado para facilitar la creación de clústeres Kubernetes auto-gestionados en un entorno de laboratorio local, con enfoque GitOps, TLS automatizado y alta reutilización de módulos Helm.
