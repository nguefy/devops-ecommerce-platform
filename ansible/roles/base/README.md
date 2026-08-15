# Base role

The `base` role provides common system validation and baseline configuration for hosts managed by Ansible.

## Responsibilities

The role currently:

- validates that the target host belongs to the expected operating system family and distribution
- ensures that required baseline packages are installed
- configures the system timezone

## Variables

| Variable | Default | Description |
|---|---|---|
| `base_expected_os_family` | `Debian` | Expected Ansible operating system family |
| `base_expected_distribution` | `Ubuntu` | Expected Ansible operating system distribution |
| `base_required_packages` | `ca-certificates`, `curl`, `git`, `unzip` | Packages that must be installed on the target host |
| `base_timezone` | `Europe/Berlin` | System timezone configured on the target host |

## Requirements

- Ansible Core 2.16 or later
- Target host with Python available to Ansible
- Debian-based target system with `apt`
- `community.general` Ansible collection

## Dependencies

None.
