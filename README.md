Perfect — based on your clarifications, here is the **fully updated and corrected `README.md`** for your `Terraformado` repo:

- ✅ Uses **Azure DevOps Classic Editor**
- ✅ Has `create.yml` and `destroy.yml` pipelines in the root (not in a subfolder)
- ✅ No `/images` directory
- ✅ Includes accurate source attribution to **Piyush's GitHub and YouTube**

---

```markdown
# 🚀 Terraformado

Automated AKS Deployment using Terraform + Azure DevOps (Multi-Environment Setup)

---

## 📌 Overview

**Terraformado** is a fully automated Infrastructure-as-Code (IaC) setup that deploys Azure Kubernetes Service (AKS) clusters using:

- **Terraform** for infrastructure provisioning
- **Azure DevOps Classic Pipelines** for CI/CD
- **Azure Service Principal** and **Key Vault** for secure authentication
- **Reusable Terraform Modules** for consistency across environments

---

## 📁 Folder Structure

```bash
Terraformado/
├── dev/                         # Development environment Terraform configs
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
├── staging/                     # Staging environment Terraform configs
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
├── modules/                     # Reusable Terraform modules
│   ├── ServicePrincipal/        # Module for Azure Service Principal
│   ├── keyvault/                # Module for Azure Key Vault
│   └── aks/                     # Module for AKS cluster
├── scripts/                     # Shell scripts for automation
│   └── script.sh
├── create.yml                   # Azure DevOps Classic Pipeline - Create Infra
├── destroy.yml                  # Azure DevOps Classic Pipeline - Destroy Infra
├── provider.tf                  # Provider config
├── output.tf                    # Shared output values
└── README.md                    # This file
```

---

## 🧭 Architecture Overview

```
GitHub (push) ──> Azure DevOps Pipeline ──> Terraform
                                 |
                                 ├── Creates Resource Group
                                 ├── Creates Service Principal
                                 ├── Assigns Role
                                 ├── Stores secrets in Key Vault
                                 └── Deploys AKS Cluster
```

- **Terraform state** is stored remotely (e.g., Azure Storage)
- **Secrets** like client secrets are stored in Azure Key Vault
- **AKS** is configured to use the Service Principal
- Supports both **Dev** and **Staging** environments with separate state files and vars

---

## 🛠️ Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/danish-am/Terraformado.git
cd Terraformado/dev
```

---

### 2. Authenticate with Azure

```bash
az login
az account set --subscription "<YOUR_SUBSCRIPTION_ID>"
```

---

### 3. Initialize Terraform

```bash
terraform init
```

---

### 4. Apply Infrastructure

```bash
terraform apply
```

Confirm with `yes` when prompted.

---

### 5. Destroy Infrastructure

To clean up all resources:

```bash
terraform destroy
```

---

## 🚀 Azure DevOps Integration

This project uses **Classic Editor Pipelines**.

### Files:
- `create.yml` → used to provision infrastructure
- `destroy.yml` → used to tear down infrastructure

### Steps:
1. Go to **Azure DevOps** > Pipelines > **New pipeline**
2. Choose **Classic Editor**
3. Select YAML file (`create.yml` or `destroy.yml`) from your repo
4. Configure variables like:
   - `ARM_CLIENT_ID`
   - `ARM_CLIENT_SECRET`
   - `ARM_SUBSCRIPTION_ID`
   - `ARM_TENANT_ID`
5. Run pipeline to trigger Terraform

---

## 📦 Terraform Modules

| Module             | Description                            |
|--------------------|----------------------------------------|
| `ServicePrincipal` | Creates Azure AD SP with client secret |
| `keyvault`         | Creates Key Vault & sets access policy |
| `aks`              | Provisions AKS using the SP credentials |

---

## 🙏 Special Thanks

This project is based on the amazing tutorial series by **Piyush Sachdeva**.

📺 YouTube Series: [AKS + Terraform + Azure DevOps](https://www.youtube.com/watch?v=hj5gbhSmftE&list=PLl4APkPHzsUUHlbhuq9V02n9AMLPySoEQ&t=207s)  
📂 GitHub Reference: [Piyush's Repo](https://github.com/piyushsachdeva/Terraform-Full-Course-Azure/tree/main/lessons/day26)

> Huge shout-out to **Tech Tutorials With Piyush** for making cloud DevOps fun and easy to learn!

