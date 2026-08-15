# Kubernetes prerequisites role

The `kubernetes_prerequisites` role prepares Linux hosts with the kernel prerequisites required for Kubernetes networking and container workloads.

## Responsibilities

The role currently:

- loads the required Linux kernel modules
- persists the kernel modules across system reboots
- configures the required Kubernetes kernel parameters
- applies the kernel parameters immediately and persists them

## Kernel modules

The default modules are:

- `overlay`
- `br_netfilter`

They are loaded using `community.general.modprobe` and persisted in:

```text
/etc/modules-load.d/kubernetes.conf