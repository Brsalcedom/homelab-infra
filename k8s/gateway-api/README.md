# 🚀 Gateway API — Homelab Terraform Bootstrap

This repository bootstraps **Gateway API** in a homelab using Terraform.  
It separates the stack into **two logical stages** for safe and modular provisioning:

1️⃣ `crds/` — Installs **Custom Resource Definitions (CRDs)**  
2️⃣ `infra/` — Installs **Helm charts** (NGINX Gateway Fabric, cert-manager) and base infrastructure (ClusterIssuer, GatewayClass, Gateway, secrets, etc.)

---

## 📦 Folder Structure

```
k8s/gateway-api/
├── crds/     # Stage 1: install CRDs using kubectl
├── infra/    # Stage 2: install infrastructure via Helm and Kubernetes providers
```

---

## ⚙️ Prerequisites

✅ Kubernetes cluster (Docker Desktop, K3s, etc.)  
✅ `kubectl` installed and configured  
✅ `terraform` >= 1.5 installed  
✅ Cloudflare API token (if using DNS-01 for cert-manager)

---

## 🚀 How to Use

### 1️⃣ **Stage 1 — Install CRDs**

Navigate to the `crds` folder and apply:

```bash
cd k8s/gateway-api/crds

# Initialize
terraform init

# Apply only CRDs (Gateway API & cert-manager)
terraform apply
```

This ensures the cluster can validate all Gateway API and cert-manager resource kinds during plan/apply.

---

### 2️⃣ **Stage 2 — Install Infrastructure**

Navigate to the `infra` folder and apply:

```bash
cd ../infra

# Initialize
terraform init

# Apply the base infrastructure:
# - NGINX Gateway Fabric (Helm)
# - cert-manager (Helm)
# - Cloudflare API token Secret
# - ClusterIssuer for Let's Encrypt DNS-01
# - GatewayClass and Gateway
terraform apply
```

---

## 🗝️ What This Deploys

| Stage | What |
|-------|------|
| ✅ **CRDs** | Gateway API CRDs, cert-manager CRDs |
| ✅ **Infra** | NGINX Gateway Fabric, cert-manager, ClusterIssuer, Cloudflare Secret, GatewayClass, Gateway |

---

## 📌 Best Practice

- **Never mix workloads here:** Only infrastructure must live in this Terraform project.
- **Applications & Routes:** Deploy using Argo CD, Kustomize, or Helm **outside Terraform**.

---

## 🧹 Clean Up

You can destroy each stage independently:

```bash
# Destroy infra (Helm releases, secrets, manifest resources)
cd infra
terraform destroy

# Destroy CRDs
cd ../crds
terraform destroy
```

---

## ✨ Tip

✅ If you update the Gateway API version, update `gateway_api_crds_url` in `crds/terraform.tfvars`.

✅ If you update cert-manager, check both the CRDs and Helm chart version in `infra/`.


