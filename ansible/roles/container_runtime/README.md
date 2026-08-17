# Container runtime role

The `container_runtime` role installs and configures containerd as the container runtime for Kubernetes-managed Linux hosts.

## Responsibilities

The role currently:

- installs the `containerd` package
- creates the containerd configuration directory
- generates the default containerd configuration
- configures `SystemdCgroup = true` for the runc runtime
- enables the containerd systemd service
- ensures the containerd service is running

## Variables

| Variable | Default | Description |
|---|---|---|
| `container_runtime_package` | `containerd` | Container runtime package |
| `container_runtime_service` | `containerd` | Container runtime systemd service |
| `container_runtime_config_path` | `/etc/containerd/config.toml` | Containerd configuration file |

## Requirements

- Ansible Core 2.16 or later
- Ubuntu 24.04 or compatible Debian-based distribution
- Python available to Ansible
- `apt` package manager
- `systemd`
- `become` privileges

## Dependencies

None.

## Kubernetes compatibility

The role configures containerd to use systemd cgroups through:

```toml
SystemdCgroup = true
