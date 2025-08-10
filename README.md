# Final Project – Terraform, Azure AKS, and GitHub Actions

**Course**: CST8918 – DevOps: Infrastructure as Code  
**Professor**: Robert McKenney  
**Term**: 25S_CST8918_300  

---

## Project Overview

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

## Infrastructure Architecture

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

> **Pre-requisites**:
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

- GitHub Actions runs
- Workflow Prod: 
- <img width="2636" height="1532" alt="image" src="https://github.com/user-attachments/assets/6e3bb5ab-862b-4116-a134-49d039f4b092" />
- Workflow Dev : 
- <img width="2636" height="1532" alt="image" src="https://github.com/user-attachments/assets/3d8c9128-79ba-4472-9b42-befe067749ce" />

<img width="2636" height="1532" alt="image" src="https://github.com/user-attachments/assets/8920cb05-c4ef-4f3c-bfec-b80239e05164" />

<img width="2636" height="1532" alt="image" src="https://github.com/user-attachments/assets/83bee232-6ead-40e0-af4f-3140c6708fda" />

<img width="2636" height="1532" alt="image" src="https://github.com/user-attachments/assets/106fee42-42ee-4ba0-a2be-ecb93e5648aa" />

<img width="2636" height="1506" alt="image" src="https://github.com/user-attachments/assets/d0cac546-39f9-4436-904d-1cdd75439787" />

<img width="2636" height="1532" alt="image" src="https://github.com/user-attachments/assets/a7dfcc5d-4b00-4b86-b81c-ae83ffd72eb7" />

<img width="2636" height="1532" alt="image" src="https://github.com/user-attachments/assets/2557dd05-706d-4a26-878c-3d5e30235071" />

<img width="2636" height="1532" alt="image" src="https://github.com/user-attachments/assets/b1f3272c-b384-4080-896e-c33756d1b9e9" />

<img width="2636" height="1532" alt="image" src="https://github.com/user-attachments/assets/3b033e74-d7a2-4df0-bfec-fa6c1793143d" />






---

## Cleanup Instructions

Once submitted, delete the deployed Azure resources to avoid unnecessary charges:

```bash
az group delete --name cst8918-final-project-group-<group-number>
```



---

## 📬 Submission Info

- Repository: [GitHub Project URL]
- Professor invited: `@rlmckenney`
- ubmitted on Brightspace: 

---
