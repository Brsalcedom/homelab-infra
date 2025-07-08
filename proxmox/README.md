# ☁️ Proxmox VM Automation con Terraform

Este directorio contiene la infraestructura y módulos necesarios para automatizar la provisión de máquinas virtuales (VMs) en un clúster Proxmox utilizando **Terraform** y **cloud-init**. El objetivo es facilitar la creación de entornos reproducibles y listos para automatización (ej. Ansible, Kubernetes, CI/CD runners, etc.).

---

## 📁 Estructura del directorio

```
proxmox/ 
├── README.md 
│   └── vm/ 
├── environments/ 
│   └── ansible/ 
│       ├── main.tf 
│       ├── outputs.tf 
│       ├── providers.tf 
│       ├── terraform.tfvars 
│       ├── variables.tf 
│       └── versions.tf 
└── modules/ 
    └── cloud-init/ 
        ├── main.tf 
        ├── outputs.tf 
        ├── variables.tf 
        └── versions.tf
```


- **environments/**: Ejemplos de entornos reutilizables (por ejemplo, una VM lista para Ansible).
- **modules/cloud-init/**: Módulo reutilizable para crear VMs en Proxmox usando cloud-init.

---

## 🚀 ¿Qué hace este proyecto?

- **Crea VMs en Proxmox** clonando una plantilla base.
- Configura automáticamente red, usuario, paquetes y comandos post-instalación usando cloud-init.
- Genera claves SSH para acceso seguro.
- Permite personalizar recursos (CPU, RAM, disco, red, etc.) y metadatos de la VM.
- Expone outputs útiles como el usuario y la clave privada SSH generada.

---

## ⚙️ Requisitos

- Proxmox VE con API habilitada.
- Plantilla base de VM con cloud-init instalado.
- [Terraform v1.9.0+](https://www.terraform.io/)
- Proveedor Terraform [bpg/proxmox](https://registry.terraform.io/providers/bpg/proxmox/latest)
- Token de API de Proxmox con permisos suficientes.
- Acceso SSH desde la máquina donde se ejecuta Terraform.

---

## 🧩 Módulo principal: `cloud-init`

Ubicado en [`vm/modules/cloud-init`](vm/modules/cloud-init/).

### Variables principales

| Variable                | Descripción                                 | Tipo           | Default                |
|-------------------------|---------------------------------------------|----------------|------------------------|
| `proxmox_endpoint`      | URL del API de Proxmox                      | `string`       | —                      |
| `proxmox_api_token`     | Token de API de Proxmox                     | `string`       | —                      |
| `vm_name`               | Nombre de la VM                             | `string`       | —                      |
| `vm_id`                 | ID de la VM                                 | `number`       | —                      |
| `clone_vm_id`           | ID de la plantilla base a clonar            | `number`       | —                      |
| `vm_memory`             | Memoria RAM (MB)                            | `number`       | `1024`                 |
| `vm_cpu_cores`          | Núcleos de CPU                              | `number`       | `1`                    |
| `vm_ipv4_address`       | Dirección IPv4                              | `string`       | —                      |
| `vm_ipv4_gateway`       | Gateway IPv4                                | `string`       | —                      |
| `dns_servers`           | Lista de DNS                                | `list(string)` | —                      |
| `vm_username`           | Usuario principal de la VM                  | `string`       | —                      |
| `vm_tags`               | Etiquetas para la VM                        | `list(string)` | `["terraform"]`        |
| `vm_description`        | Descripción de la VM                        | `string`       | `"VM created and managed by Terraform"` |
| `datastore_id`          | Datastore para cloud-init                   | `string`       | `"local"`              |
| `packages`              | Paquetes a instalar                         | `list(string)` | —                      |
| `runcmd`                | Comandos post-instalación                   | `list(string)` | —                      |
| `node_name`             | Nodo Proxmox destino                        | `string`       | `"pve"`                |

---

## 🏗️ Ejemplo de uso rápido

1. **Clona el repositorio y entra al entorno deseado:**

   ```bash
   git clone https://github.com/Brsalcedom/homelab-infra.git
   cd homelab-infra/proxmox/vm/environments/ansible

2. **Crea tu archivo terraform.tfvars:**
    ```bash
    proxmox_endpoint = "https://proxmox.local:8006/api2/json"
    proxmox_api_token = "user@pam!token=xxxxxxxx"
    vm_name = "ansible" 
    vm_id = 101 
    clone_vm_id = 9000 
    vm_ipv4_address = "192.168.1.100/24" 
    vm_ipv4_gateway = "192.168.1.1" 
    dns_servers = ["1.1.1.1", "8.8.8.8"] 
    packages = ["curl", "git", "ansible"] 
    runcmd = ["echo 'VM lista!'"]
    ```
3. **Inicializa y aplica Terraform:**

    ```bash
    terraform init
    terraform apply
    ```

4. **Obtén outputs:**
    ```bash
    terraform output -raw ssh_private_key > id_rsa_ansible
    chmod 600 id_rsa_ansible
    ```

## 📤 Outputs
- `vm_username`: Usuario principal creado en la VM.
- `ssh_private_key`: Clave privada SSH generada para acceder a la VM.

## 📝 Notas importantes

- **Plantilla base**: Debes tener una VM plantilla en Proxmox con cloud-init instalado y configurado.
- **Seguridad**: El output `ssh_private_key` es sensible. Protégelo adecuadamente.
- **Personalización**: Puedes modificar los módulos o crear nuevos entornos en `environments/` según tus necesidades (ej. runners de CI, nodos de Kubernetes, etc.).


## 📚 Referencias
- [Documentación oficial del proveedor Proxmox para Terraform](https://registry.terraform.io/providers/bpg/proxmox/latest/docs)
- [Cloud-init documentation](https://cloud-init.io/)
- [Terraform](https://www.terraform.io/)

🖋️ Licencia
MIT © [Brsalcedom](https://github.com/Brsalcedom)