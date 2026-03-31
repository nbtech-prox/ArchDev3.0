# ArchDev Docs Index

This folder works as the detailed documentation layer for ArchDev.

Use it as the "wiki" for deeper reading, while the root `README.md` stays focused on onboarding and quick usage.

## Start Here

- `../README.md` - quick overview, install flow, profiles, rollback basics
- `../POST-INSTALL.md` - practical after-install checklist

## ArchDev 4.0

- `architecture-4.0.md` - architecture direction and migration model
- `profiles-4.0.md` - profile model and hardware-aware flow
- `migration-4.0.md` - migration phases and current status
- `doctor-4.0.md` - how validation works in the new flow
- `wrapper-4.0.md` - operational guide for `profiles`, `status`, `doctor`, `apply`, and `rollback`
- `real-machine-apply.md` - short pre-flight and apply checklist for real workstations

## Recommended Reading Order

### New user
1. `../README.md`
2. `../POST-INSTALL.md`

### Evaluating the 4.0 flow
1. `architecture-4.0.md`
2. `profiles-4.0.md`
3. `doctor-4.0.md`
4. `migration-4.0.md`
5. `real-machine-apply.md`

### Maintaining or extending the repo
1. `architecture-4.0.md`
2. `migration-4.0.md`
3. inspect `playbooks/site-4.yml`
4. inspect the relevant role under `roles/`

## Documentation Strategy

The intended split is:

- root `README.md`: simple and readable
- `docs/`: complete reference and design notes
- `POST-INSTALL.md`: operational checklist

## Suggested GitHub Wiki Structure

If you enable the repository Wiki tab, use this page map:

- `Home`
  - quick overview
  - install entrypoints
  - links to the most important pages
- `Installation`
  - stable `setup.sh` flow
  - recommended Arch install assumptions
- `Profiles`
  - `minimal`
  - `dev`
  - `full`
- `ArchDev-4.0`
  - architecture direction
  - host-aware flow
  - migration status
- `Doctor`
  - profile-aware validation model
- `Real-Machine-Apply`
  - pre-flight checks
  - apply order
  - rollback notes
- `Rollback`
  - `archdev-rollback`
  - `snapper` workflow
- `Dynamic-Wallpaper-Theming`
  - picker
  - Thunar integration
  - palette sync behavior
- `Post-Install`
  - first reboot
  - helpers
  - practical checks
- `Troubleshooting`
  - VM issues
  - Hyprland/SDDM
  - Docker/PostgreSQL/PHP issues

If more deep-dive material is added later, it should go here instead of growing the root README again.
