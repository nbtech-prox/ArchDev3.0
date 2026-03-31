# ArchDev 4.0 Safe Improvements

## Goal
Harden the 4.0 wrapper and docs without changing the install behavior that is already working well.

## Tasks
- [ ] Document the improved `scripts/archdev status` flow in `README.md` and 4.0 docs -> Verify: docs mention what `status` shows and where `host_vars` live
- [ ] Make wrapper profile validation file-driven from `inventories/group_vars/profiles/` -> Verify: invalid profile fails early; valid profiles still work
- [ ] Improve `status` to show available declarative profiles from the profile directory -> Verify: `bash scripts/archdev status` prints the profile list
- [ ] Run shell and repo validation for all wrapper/doc updates -> Verify: `bash -n scripts/archdev`, `ansible-playbook playbooks/site-4.yml --syntax-check -i inventory/hosts.yml`, and `git diff --check` pass

## Done When
- [ ] The wrapper is stricter and more informative without touching install roles or the stable 3.x flow
