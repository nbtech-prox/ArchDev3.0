# ArchDev 4.0 - Real Machine Apply Checklist

## Goal

This page is the short, practical checklist for applying ArchDev 4.0 on a real workstation.

It is intentionally brief and operational.

## Before You Start

- Be on Arch Linux
- Make sure the repository is up to date
- Review `inventories/host_vars/<hostname>.yml`
- Confirm monitor, GPU, RAM, and `wlsunset` values are correct for the target machine
- Make sure you are comfortable restarting services and rebooting if needed

## Recommended Pre-Flight Order

Run these from the repository root:

```bash
bash scripts/archdev status
bash scripts/archdev explain full
bash scripts/archdev doctor
ansible-playbook playbooks/site-4.yml --syntax-check -i inventory/hosts.yml
ansible-playbook playbooks/site-4.yml -i inventory/hosts.yml -e archdev_profile=full --list-tasks
ansible-playbook playbooks/site-4.yml -i inventory/hosts.yml -e archdev_profile=full --check --diff -K
```

What you want to see:

- `status` shows the expected host and host vars file
- `explain full` shows the expected feature set and host context
- `doctor` has no unexpected blockers
- `--syntax-check` passes
- `--list-tasks` includes the roles you expect
- `--check --diff -K` finishes with `failed=0`

## Apply

If the pre-flight checks look good:

```bash
bash scripts/archdev apply full
```

For narrower installs:

```bash
bash scripts/archdev apply minimal
bash scripts/archdev apply dev
```

## After Apply

Run:

```bash
bash scripts/archdev doctor
```

Then complete the practical post-install steps in:

- `POST-INSTALL.md`

Typical next actions:

- reboot
- test Hyprland session
- test Docker without sudo after re-login
- test `laravel`, `opencode`, `psql`, and helper scripts

## Rollback Safety

If `snapper` is configured, use:

```bash
scripts/archdev rollback list
archdev-rollback list
archdev-rollback last
```

Use rollback only when necessary and with clear intent.

## Machine-Specific Notes

Keep machine-specific values in:

```text
inventories/host_vars/<hostname>.yml
```

Examples:

- monitor layout
- primary Waybar output
- GPU override paths
- `wlsunset` coordinates
- PostgreSQL tuning overrides

Do not push machine-specific defaults into global variables unless they are safe for everyone.
