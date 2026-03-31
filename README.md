# ArchDev 3.0

ArchDev is an Ansible-based Arch Linux workstation bootstrap focused on three things:

- a reproducible desktop (`Hyprland`, `Waybar`, `Rofi`, `Kitty`, `Neovim`)
- development-ready profiles (`minimal`, `dev`, `full`)
- safer maintenance with `Btrfs`, `Snapper`, `Limine`, `doctor`, and rollback helpers

The stable entrypoint is still `setup.sh`.

The newer `ArchDev 4.0` flow already exists in parallel and is being validated incrementally.

## What You Get

- Arch Linux desktop bootstrap with Ansible
- `Catppuccin Mocha`-based visual setup
- dynamic wallpaper-driven theming for the desktop
- optional development stack for Docker, Laravel/PHP, Python, PostgreSQL, Node, and OpenCode
- snapshots and rollback support for `Btrfs + Snapper`

## Profiles

### `minimal`
- desktop base
- browser, terminal, launcher, notifications, screenshots, clipboard
- security baseline
- `Btrfs`, `Snapper`, `UFW`, `Fail2ban`

### `dev`
- everything in `minimal`
- Docker
- Laravel / PHP / Composer
- Python / Poetry
- PostgreSQL
- Node / npm / OpenCode

### `full`
- everything in `dev`
- extra developer and productivity tooling
- Redis, DBeaver, pgcli, Bun, pnpm, yarn, tmux, just, shellcheck, ansible-lint, etc.

## Recommended Install Assumptions

For the best experience, install Arch with:

- bootloader: `Limine`
- filesystem: `Btrfs`
- audio: `PipeWire`
- base profile: `Minimal`

## Stable Install Flow

```bash
git clone https://github.com/nbtech-prox/ArchDev3.0.git
cd ArchDev3.0
chmod +x setup.sh
./setup.sh full
```

You can also choose:

```bash
./setup.sh minimal
./setup.sh dev
./setup.sh full
```

## 4.0 Preview Flow

The declarative 4.0 path is already usable for testing.

```bash
scripts/archdev init
scripts/archdev apply minimal
scripts/archdev apply dev
scripts/archdev apply full
scripts/archdev explain full
scripts/archdev profiles
scripts/archdev status
scripts/archdev doctor
```

`scripts/archdev status` is the safest way to inspect the 4.0 wrapper state before an apply.
It shows the detected host, the expected `inventories/host_vars/<hostname>.yml`, the effective profile context, and the declarative profiles currently available under `inventories/group_vars/profiles/`.

`scripts/archdev explain <perfil>` gives a read-only preview of what the wrapper will use for that profile: profile file, feature flags, feature files, and current host context.

`scripts/archdev profiles` gives a direct file-backed view of the declarative profiles known by the wrapper.

What is already true in the 4.0 flow:

- hardware detection + assisted confirmation
- per-host overrides in `inventories/host_vars/<hostname>.yml`
- profile-aware `doctor`
- VM-aware Hyprland/SDDM handling
- validated in clean Arch Linux VMs for `minimal` and `full`

## Post-Install Essentials

After installation:

```bash
sudo reboot
```

Useful helpers:

```bash
archdev-bitwarden-setup
sudo archdev-postgresql-setup
archdev-backup-keys
archdev-gpu-status
```

Wallpaper and dynamic theme:

- `Super+Shift+W` opens the ArchDev wallpaper picker
- in `Thunar`, right click an image and use `Set as ArchDev wallpaper`
- changing wallpaper updates `waybar`, `rofi`, `kitty`, `Hyprland`, `gtk`, and `qt/kvantum`

## Rollback Without Keeping The Repo

The system installs a standalone helper for rollback-related operations:

```bash
archdev-rollback list
archdev-rollback create pre-update-manual
archdev-rollback last
archdev-rollback 75
```

This helper is global and does not depend on keeping `~/ArchDev3.0` on disk.

## Docs / Wiki Index

The README is intentionally kept shorter now.

If you enable the GitHub Wiki for this repository, that should be the public long-form documentation surface.
The repository `docs/` folder should remain the versioned source of truth.

Detailed documentation lives in `docs/`:

- `docs/README.md`
- `docs/architecture-4.0.md`
- `docs/profiles-4.0.md`
- `docs/migration-4.0.md`
- `docs/doctor-4.0.md`
- `docs/wrapper-4.0.md`
- `docs/real-machine-apply.md`
- `POST-INSTALL.md`

Suggested Wiki pages:

- `Home`
- `Installation`
- `Profiles`
- `ArchDev-4.0`
- `Doctor`
- `Real-Machine-Apply`
- `Rollback`
- `Dynamic-Wallpaper-Theming`
- `Post-Install`
- `Troubleshooting`

## Repo Structure

```text
bootstrap/
docs/
inventories/
inventory/
playbooks/
roles/
scripts/
setup.sh
```

## Should README Be Simpler And Docs More Complete?

Yes.

For this project, the best documentation shape is:

- `README.md` = quick understanding + install + profiles + critical commands
- `docs/` = deeper operational and architectural reference
- `POST-INSTALL.md` = practical after-install checklist

That keeps the front door readable without losing the deeper material.

## License

MIT
