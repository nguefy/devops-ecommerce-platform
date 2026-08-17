# Ansible

This directory contains the Ansible automation used to configure and manage the project's infrastructure hosts.

Ansible is responsible for **host configuration management and system-level automation**. Infrastructure provisioning remains the responsibility of Terraform, while Kubernetes handles container orchestration and Helm handles Kubernetes application packaging.

## Architecture

```text
Terraform  → Infrastructure provisioning
Ansible    → Host configuration management
Kubernetes → Container orchestration
Helm       → Kubernetes application packaging
```

The current Ansible implementation targets a local Ubuntu development host and prepares it for Kubernetes and container workloads.

## Structure

```text
ansible/
├── ansible.cfg
├── inventory/
│   ├── README.md
│   └── hosts.ini
├── playbooks/
│   ├── README.md
│   └── site.yml
└── roles/
    ├── README.md
    ├── base/
    ├── kubernetes_prerequisites/
    └── container_runtime/
```

## Requirements

The current development environment uses:

* Ubuntu 24.04 LTS
* Python 3.12
* Ansible Core 2.16 or later
* `community.general`
* `ansible.posix`
* `sudo` privileges

Verify the Ansible installation with:

```bash
ansible --version
ansible-playbook --version
```

Validate connectivity to the local Ansible target with:

```bash
ansible localhost -m ping
```

## Inventory

The current inventory targets the local host:

```ini
[local]
localhost ansible_connection=local
```

The inventory is configured automatically through `ansible.cfg`:

```ini
[defaults]
inventory = inventory/hosts.ini
roles_path = roles
interpreter_python = auto_silent
```

Environment-specific inventories can be introduced later when remote hosts are managed.

## Playbook

The main entry point is:

```text
ansible/playbooks/site.yml
```

It currently applies the following roles in order:

```text
base
  ↓
kubernetes_prerequisites
  ↓
container_runtime
```

Run the complete configuration with:

```bash
cd ansible
ansible-playbook playbooks/site.yml --ask-become-pass
```

The `--ask-become-pass` option asks Ansible for the local `sudo` password because several tasks require elevated privileges.

No password is stored in the repository.

## Roles

### `base`

The `base` role provides the common host baseline.

It:

* validates the operating system family
* validates the operating system distribution
* installs required baseline packages
* configures the system timezone

Default timezone:

```text
Europe/Berlin
```

### `kubernetes_prerequisites`

The `kubernetes_prerequisites` role prepares Linux kernel settings required by Kubernetes and container workloads.

It:

* loads `overlay`
* loads `br_netfilter`
* persists the modules in `/etc/modules-load.d/kubernetes.conf`
* enables IPv4 forwarding
* configures bridge network filtering

The configured kernel parameters are:

```text
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
```

### `container_runtime`

The `container_runtime` role installs and configures `containerd`.

It:

* installs the `containerd` package
* creates the containerd configuration directory
* generates the default configuration
* enables `SystemdCgroup = true`
* enables the containerd service
* ensures the service is running

## Validation

The playbook is validated before execution with:

```bash
ansible-playbook playbooks/site.yml --syntax-check
```

The targeted hosts can be inspected with:

```bash
ansible-playbook playbooks/site.yml --list-hosts
```

The tasks executed by the playbook can be inspected with:

```bash
ansible-playbook playbooks/site.yml --list-tasks
```

## Idempotence

The playbook is designed to be idempotent: running it repeatedly against an already configured host should not introduce unnecessary changes.

Idempotence is validated by running the playbook twice consecutively:

```bash
ansible-playbook playbooks/site.yml --ask-become-pass
ansible-playbook playbooks/site.yml --ask-become-pass
```

The validated result is:

```text
localhost : ok=13 changed=0 unreachable=0 failed=0 skipped=0
```

The second execution therefore produces no additional configuration changes.

## Functional validation

After applying the playbook, the resulting host configuration can be verified with:

```bash
timedatectl | grep -E 'Time zone|Universal time'
```

Expected timezone:

```text
Europe/Berlin
```

Verify Kubernetes kernel parameters:

```bash
sysctl net.ipv4.ip_forward
sysctl net.bridge.bridge-nf-call-iptables
sysctl net.bridge.bridge-nf-call-ip6tables
```

Verify persisted kernel modules:

```bash
cat /etc/modules-load.d/kubernetes.conf
```

Verify the container runtime:

```bash
systemctl is-enabled containerd
systemctl is-active containerd
grep -n 'SystemdCgroup' /etc/containerd/config.toml
containerd --version
```

The current validation confirmed:

```text
containerd: enabled
containerd: active
SystemdCgroup = true
containerd version: 2.2.1
```

## Design Principles

The Ansible implementation follows these principles:

* roles are focused on a single configuration responsibility
* configuration values are exposed through role defaults
* Ansible modules are preferred over shell commands
* handlers are used when service restarts are required
* repeated executions should remain idempotent
* secrets are not stored in the repository
* infrastructure provisioning and host configuration remain separated

## Future Integration

The current implementation prepares a host for Kubernetes and container workloads.

Future iterations can integrate the Ansible automation with:

* Terraform-provisioned infrastructure
* remote inventory management
* Kubernetes cluster bootstrap
* CI/CD validation
* environment-specific variables and inventories

Ansible remains focused on **configuration management**, while Terraform and Kubernetes retain their respective responsibilities.
