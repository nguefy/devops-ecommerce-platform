# Ansible

This directory contains the Ansible automation used to configure and manage the project's infrastructure and hosts.

## Structure

```text
ansible/
├── inventory/    # Target hosts and environments
├── playbooks/    # Main Ansible playbooks
└── roles/        # Reusable configuration roles
```

## Responsibilities

Ansible is used for configuration management and host automation.

The infrastructure provisioning responsibility remains with Terraform, while Kubernetes remains responsible for container orchestration.

```text
Terraform  → Infrastructure provisioning
Ansible    → Configuration management
Kubernetes → Container orchestration
Helm       → Kubernetes application packaging
```

## Requirements

The current development environment uses:

* Ubuntu 24.04 LTS
* Python 3.12
* Ansible Core 2.16

Verify the installation with:

```bash
ansible --version
ansible-playbook --version
```

Validate the local Ansible installation with:

```bash
ansible localhost -m ping
```

## Inventory

Inventories will define the hosts targeted by Ansible playbooks.

Environment-specific inventories should be kept separate when required.

## Playbooks

Playbooks contain the automation entry points used to configure hosts.

They should remain focused and reusable, with common configuration implemented through roles when appropriate.

## Roles

Roles contain reusable configuration logic.

A role should encapsulate a specific responsibility rather than combining unrelated system configuration tasks.
