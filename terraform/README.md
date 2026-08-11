# Terraform Infrastructure

This directory contains the Infrastructure as Code foundation for the DevOps E-Commerce Platform.

## Architecture

The current Terraform configuration defines:

- Azure Resource Manager provider
- Azure Resource Group
- Terraform variables for the Azure region and resource group name
- Terraform outputs for the resource group name and location

```text
Terraform
    |
    v
AzureRM Provider
    |
    v
Azure Resource Group
```

## Files

| File | Purpose |
|------|---------|
| `versions.tf` | Terraform and provider version constraints |
| `main.tf` | Azure provider and infrastructure resources |
| `variables.tf` | Configurable Terraform variables |
| `outputs.tf` | Infrastructure outputs |
| `.terraform.lock.hcl` | Locked provider version and integrity hashes |

The `.terraform/` directory is generated locally by Terraform and is excluded from Git.

## Validation

The configuration has been validated locally with:

```bash
terraform -chdir=terraform init
terraform -chdir=terraform fmt -check
terraform -chdir=terraform validate
```

## Azure Deployment

The Terraform configuration is prepared for Azure deployment.

No Azure resources have been created during this sprint because the current Azure account does not have an accessible Azure subscription.

Once an Azure subscription is available, the infrastructure can be reviewed and deployed with:

```bash
terraform -chdir=terraform plan
terraform -chdir=terraform apply
```

Never commit Azure credentials or secrets to the repository.
