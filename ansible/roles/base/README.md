# Base role

The `base` role provides common system validation and configuration for hosts managed by Ansible.

## Responsibilities

The role currently validates that the target host belongs to the expected operating system family.

## Variables

| Variable | Default | Description |
|---|---|---|
| `base_expected_os_family` | `Debian` | Expected Ansible operating system family |

## Requirements

- Ansible Core 2.16 or later
- Target host with Python available to Ansible

## Dependencies

None.
