# Base role

The `base` role provides common system validation and configuration for hosts managed by Ansible.

## Responsibilities

The role currently validates that the target host belongs to the expected operating system family and distribution.

## Variables

| Variable | Default | Description |
|---|---|---|
| `base_expected_os_family` | `Debian` | Expected Ansible operating system family |
| `base_expected_distribution` | `Ubuntu` | Expected Ansible operating system distribution |

## Requirements

- Ansible Core 2.16 or later
- Target host with Python available to Ansible

## Dependencies

None.
