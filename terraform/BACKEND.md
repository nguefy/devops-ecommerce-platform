# Terraform Remote State Backend

## Purpose

The Terraform configuration currently uses local state for development and validation.

For collaborative or production deployments, Terraform state should be stored remotely in Azure Storage.

The remote backend provides:

- Centralized Terraform state
- State locking
- Access control through Azure
- Encryption at rest
- Safer collaboration between engineers and CI/CD pipelines

## Target Architecture

```text
Bootstrap Terraform
        |
        v
Azure Resource Group
        |
        v
Azure Storage Account
        |
        v
Blob Container
        |
        v
Terraform Remote State
        |
        v
Main Terraform Infrastructure
        |
        +------------------+
        |                  |
        v                  v
       VNet               AKS
                            |
                            v
                         Subnet
