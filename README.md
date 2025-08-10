# Final Project – Terraform, Azure AKS, and GitHub Actions

**Course**: CST8918 – DevOps: Infrastructure as Code  
**Professor**: Robert McKenney  
**Term**: 25S_CST8918_300  

---

## 🌤️ Project Overview

This capstone project showcases the practical application of Infrastructure as Code (IaC) principles using **Terraform**, **Azure Kubernetes Service (AKS)**, and **GitHub Actions**. It builds upon the Remix Weather Application introduced in Week 3, deploying it across multiple environments (dev, test, prod) on Azure infrastructure.

Our solution is modular, secure, collaborative, and automated. The infrastructure code is organized into Terraform modules with a remote backend, and CI/CD workflows are fully automated using GitHub Actions with OIDC federated identity for Azure authentication.

---

## 👥 Team Members

| Name             | GitHub Username | Profile Link                                 |
|------------------|-----------------|----------------------------------------------|
| Jaspreet Singh   | @jaspreet1388   | https://github.com/jaspreet1388    |
| Romeo De Guzman II |  @degu0055    |  https://github.com/degu0055       |
| Akshay Malik     |  @mali0154      |  https://github.com/mali0154     |

> 🔗 **Note**: Professor `@rlmckenney` has been added as a collaborator to this repository.

---

## 🧱 Infrastructure Architecture

### Terraform Modules Structure:

- **Backend Configuration**  
  - Azure Blob Storage as Terraform backend

- **Networking Module**  
  - VNet CIDR: `10.0.0.0/14`  
  - Subnets:  
    - `prod` → `10.0.0.0/16`  
    - `test` → `10.1.0.0/16`  
    - `dev` → `10.2.0.0/16`  
    - `admin` → `10.3.0.0/16`  

- **AKS Module**  
  - Test: 1-node AKS (Standard B2s, Kubernetes v1.32)  
  - Prod: 1–3 node AKS (Standard B2s, Kubernetes v1.32, autoscaling)

- **Application Module**  
  - Remix Weather App containerized and deployed to AKS  
  - Azure Container Registry (ACR)  
  - Azure Redis Cache for test and prod  
  - Kubernetes services and deployments

---

## 🔁 GitHub Actions Workflows

| Workflow | Trigger | Purpose |
|---------|---------|---------|
| `terraform-static.yml` | On push to any branch | Run `terraform fmt`, `validate`, `tfsec` |
| `terraform-pr-check.yml` | On PR to `main` | Run `tflint`, `terraform plan` |
| `terraform-apply.yml` | On push to `main` | Run `terraform apply` |
| `build-and-push-image.yml` | On PR (app changes only) | Build Docker image, push to ACR (tagged with SHA) |
| `deploy-weather-test.yml` | On PR to `main` (app changes) | Deploy Weather App to **test** AKS |
| `deploy-weather-prod.yml` | On push to `main` (app changes) | Deploy Weather App to **prod** AKS |

✅ Branch Protection Rules:
- Require PRs with at least 1 approving review
- No direct push to `main`
- Status checks must pass
- Require branch to be up to date

---

## 🧪 Infrastructure Testing

- **Static Analysis**: `fmt`, `validate`, `tfsec`, `tflint`
- **Terraform Plan**: Ensures visibility of changes before apply
- **CI Validation**: Triggered on all PRs and commits

> *Application-level tests are not included per project guidelines.*

---

## Deployment Strategy

- **Pull Requests**:  
  - Application changes are built and deployed to **test**  
  - Infrastructure changes are validated with Terraform Plan

- **Post-Merge to Main**:  
  - `terraform apply` runs for infrastructure  
  - App is deployed to **prod** (if app code changed)

---

## How to Run the Project

> 💡 **Pre-requisites**:
- Azure CLI with access to your subscription
- GitHub repository access
- A federated identity created for GitHub Actions (OIDC)

### Steps:
1. Clone the repository and navigate into it
2. Initialize the Terraform backend:
   ```bash
   terraform init -backend-config="..."
   ```
3. Create a new branch for changes:
   ```bash
   git checkout -b feature/new-feature
   ```
4. Push your changes and open a pull request
5. Approve via PR review and merge into `main` to trigger deployments

---

## 📸 Screenshots

> Attach a screenshot here showing:
- GitHub Actions runs for `terraform-static`, `terraform-plan`, `terraform-apply`
- Successful deployments of test and prod environments

---

## 🧹 Cleanup Instructions

Once submitted, delete the deployed Azure resources to avoid unnecessary charges:

```bash
az group delete --name cst8918-final-project-group-<group-number>
```

> ⚠️ Failure to clean up resources may result in **10% grade penalty**.

---

## 📬 Submission Info

- ✅ Repository: [GitHub Project URL]
- 🧑‍🏫 Professor invited: ✅ `@rlmckenney`
- 📎 Submitted on Brightspace: ✅

---
