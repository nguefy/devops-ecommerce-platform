# Terraform Infrastructure

This directory contains the Infrastructure as Code foundation for the DevOps E-Commerce Platform.

The Terraform configuration provisions the Azure infrastructure required to host the application on Azure Kubernetes Service (AKS).

## Architecture

The current Terraform configuration defines:

* Azure Resource Manager provider
* Azure Resource Group
* Azure Virtual Network
* Dedicated AKS subnet
* Azure Kubernetes Service cluster
* System-assigned managed identity
* Azure CNI Overlay networking
* Kubernetes RBAC
* AKS OIDC issuer
* Azure Workload Identity support
* Configurable AKS networking parameters
* Terraform outputs for infrastructure and network resource IDs

```text
Terraform
    |
    v
AzureRM Provider
    |
    +----------------------+
    |                      |
    v                      v
Resource Group          Virtual Network
                            |
                            v
                       AKS Subnet
                            |
                            v
                       AKS Cluster
                            |
                 +----------+----------+
                 |                     |
                 v                     v
          OIDC / Workload        Kubernetes RBAC
             Identity
```

## Files

| File                       | Purpose                                            |
| -------------------------- | -------------------------------------------------- |
| `versions.tf`              | Terraform and AzureRM provider version constraints |
| `main.tf`                  | Azure provider and infrastructure resources        |
| `variables.tf`             | Configurable Terraform variables                   |
| `outputs.tf`               | Infrastructure and network outputs                 |
| `terraform.tfvars.example` | Example Terraform variable configuration           |
| `.terraform.lock.hcl`      | Locked provider version and integrity hashes       |

The `.terraform/` directory is generated locally by Terraform and is excluded from Git.

Local `.tfvars` and Terraform state files are also excluded from Git.

## Prerequisites

The following tools are required:

* Terraform
* Azure CLI
* kubectl

Current development environment versions have been validated with:

```bash
terraform version
az version
kubectl version --client
```

An Azure subscription with sufficient permissions is required before provisioning resources.

## Configuration

The default variable values are defined in `variables.tf`.

For a custom deployment, create a local variable file from the provided example:

```bash
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
```

Edit `terraform/terraform.tfvars` according to the target Azure environment.

Never commit `terraform.tfvars` or other files containing credentials, secrets, or environment-specific sensitive values.

## Authentication

Authenticate with Azure CLI before running Terraform:

```bash
az login
```

Verify that an accessible subscription is available:

```bash
az account show
az account list --output table
```

Terraform uses the authenticated Azure CLI context through the AzureRM provider.

## Initialization

Initialize the Terraform working directory:

```bash
terraform -chdir=terraform init
```

The AzureRM provider version is constrained to the `~> 4.0` series and the selected provider version is recorded in `.terraform.lock.hcl`.

## Formatting and Validation

Format the Terraform configuration:

```bash
terraform -chdir=terraform fmt
```

Check formatting without modifying files:

```bash
terraform -chdir=terraform fmt -check
```

Validate the configuration:

```bash
terraform -chdir=terraform validate
```

The configuration should pass validation before planning or applying infrastructure changes.

## Planning

Review the infrastructure changes before deployment:

```bash
terraform -chdir=terraform plan
```

When using a custom variable file:

```bash
terraform -chdir=terraform plan -var-file=terraform.tfvars
```

Always review the Terraform plan before applying changes.

## Deployment

Apply the Terraform configuration:

```bash
terraform -chdir=terraform apply
```

For a custom variable file:

```bash
terraform -chdir=terraform apply -var-file=terraform.tfvars
```

Terraform will request confirmation before making infrastructure changes unless automatic approval is explicitly configured.

## Outputs

After a successful deployment, inspect the Terraform outputs:

```bash
terraform -chdir=terraform output
```

The configuration exposes information including:

* Resource Group name and location
* AKS cluster name and resource ID
* AKS FQDN
* AKS OIDC issuer URL
* AKS kubelet identity object ID
* Virtual Network name and resource ID
* AKS subnet name and resource ID

## Connecting to AKS

After the AKS cluster has been deployed, retrieve its Kubernetes credentials:

```bash
az aks get-credentials \
  --resource-group "$(terraform -chdir=terraform output -raw resource_group_name)" \
  --name "$(terraform -chdir=terraform output -raw aks_cluster_name)"
```

Verify access to the cluster:

```bash
kubectl get nodes
```

## Current Azure Deployment Status

The Terraform configuration has been validated locally.

No Azure resources have been created from this repository because the current Azure account does not have an accessible Azure subscription.

The infrastructure can therefore be safely developed and validated locally until an Azure subscription becomes available.

## Security

Never commit:

* Azure credentials
* client secrets
* access tokens
* passwords
* private keys
* `terraform.tfvars`
* Terraform state files

Terraform state can contain sensitive infrastructure information and must be protected appropriately in a real deployment environment.

For production usage, a remote Terraform backend with appropriate access controls and state protection should be configured.

## Validation Workflow

Recommended workflow before committing Terraform changes:

```bash
terraform -chdir=terraform fmt
terraform -chdir=terraform fmt -check
terraform -chdir=terraform validate
git diff --check
git status
```

Terraform changes should be reviewed and validated before being committed and pushed to the repository.
