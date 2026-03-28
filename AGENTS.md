# AGENTS.md

## Scope
This file applies to the whole `ArchDev3.0` repository.

ArchDev3.0 is an Ansible-based Arch Linux workstation bootstrap. The main flow is:

```bash
./setup.sh -> ansible-playbook playbooks/site.yml
```

Main technologies in this repo:

- Ansible YAML in `playbooks/`, `roles/`, `inventory/`
- Bash in `setup.sh` and `roles/**/files/*.sh`
- Lua in `roles/dotfiles/files/nvim/`
- Jinja templates in `roles/**/templates/`
- Zsh dotfiles in `roles/dotfiles/files/zsh/`

No Cursor rules were found in `.cursor/rules/` or `.cursorrules`.
No Copilot rules were found in `.github/copilot-instructions.md`.

## Repository Map
- `setup.sh`: Arch-only bootstrap wrapper; prompts for sudo once and runs the playbook
- `playbooks/site.yml`: main playbook for `localhost`
- `inventory/hosts.yml`: inventory definition
- `inventory/group_vars/all.yml`: package lists, paths, user settings, coordinates
- `roles/common`: base packages, services, firewall, AUR, fail2ban
- `roles/system`: user dirs and Btrfs work
- `roles/desktop`: Hyprland, SDDM, themes, assets
- `roles/dev`: Docker, PHP/Laravel, Python, MariaDB, helpers
- `roles/dotfiles`: Zsh, Neovim, Hyprland, Waybar, Kitty, Rofi configs
- `POST-INSTALL.md`: manual follow-up tasks after install

## Build, Lint, and Test Commands

There is no traditional build step and no automated unit-test suite. Validation is mostly Ansible syntax, dry runs, tags, and script parsing.

Run from repo root:

```bash
cd /path/to/ArchDev3.0
```

Full install:

```bash
chmod +x setup.sh
./setup.sh
```

Core validation:

```bash
ansible-playbook playbooks/site.yml --syntax-check
ansible-playbook playbooks/site.yml --list-tasks
ansible-playbook playbooks/site.yml --list-tags
ansible-playbook playbooks/site.yml --check --diff
```

Run full playbook directly:

```bash
ansible-playbook playbooks/site.yml
```

Run a single area with tags:

```bash
ansible-playbook playbooks/site.yml --tags "system"
ansible-playbook playbooks/site.yml --tags "desktop"
ansible-playbook playbooks/site.yml --tags "dev"
ansible-playbook playbooks/site.yml --tags "aur"
ansible-playbook playbooks/site.yml --tags "docker"
ansible-playbook playbooks/site.yml --tags "php"
ansible-playbook playbooks/site.yml --tags "python"
ansible-playbook playbooks/site.yml --tags "dotfiles"
```

Closest equivalent to a single test:

```bash
ansible-playbook playbooks/site.yml --tags "postgresql"
ansible-playbook playbooks/site.yml --tags "opencode"
ansible-playbook playbooks/site.yml --tags "git-autosync"
ansible-playbook playbooks/site.yml --start-at-task "Install Composer globally"
```

Useful local checks:

```bash
bash -n setup.sh
git diff --check
```

Optional if installed locally:

```bash
shellcheck setup.sh
ansible-lint playbooks/site.yml
```

## Recommended Validation Workflow
- For most edits, run `ansible-playbook playbooks/site.yml --syntax-check`
- Then run `ansible-playbook playbooks/site.yml --check --diff`
- Then run the smallest relevant tag set for the touched role
- For shell edits, also run `bash -n` on each changed script
- For task-order debugging, use `--list-tasks` or `--start-at-task`

## Code Style

### General
- Match the existing style in the file you edit
- Prefer small, surgical changes over large refactors
- Preserve Portuguese operator-facing text unless the file is already English-led
- Keep comments brief and practical
- Do not add new tooling conventions unless the repo already uses them

### Ansible YAML
- Start task and handler files with `---`
- Use explicit imperative task names like `Install Developer Tools`
- Use 2-space indentation consistently
- Prefer Ansible modules over `shell` or `command`
- Use `shell` only when shell features are required
- If Bash semantics are needed, set `args.executable: /bin/bash`
- Mark read-only commands with `changed_when: false`
- Use `creates:` for one-time initialization where possible
- Use `notify` + handlers for restarts instead of inline restarts when possible
- Use tags carefully; extend the current tag taxonomy instead of inventing unrelated tags
- Reuse variables from `inventory/group_vars/all.yml` rather than hardcoding paths
- Keep package-list changes centralized in `inventory/group_vars/all.yml`

### Shell Scripts
- Follow the existing Bash style in `setup.sh` and helper scripts
- Quote variable expansions unless unquoted expansion is intentional
- Keep flow simple and readable; avoid dense Bash tricks
- Preserve idempotence where practical
- Validate risky operations explicitly
- Avoid destructive commands without guards
- Keep interactive prompts stable if the script is user-facing

### Lua / Neovim
- Keep modules focused and small
- Match the current 2-space Lua indentation
- Keep `require(...)` near the top unless a lazy callback needs local loading
- Extend the existing Lazy.nvim plugin structure; do not add a second plugin-management pattern
- Prefer declarative plugin specs and minimal inline logic

### Zsh / Dotfiles
- Keep shell config modular; prefer editing `core.zsh`, `aliases.zsh`, `dev.zsh`, or `env.zsh` instead of bloating `.zshrc`
- Preserve the current sourcing order in `.zshrc`
- Use aliases for short wrappers and functions for interactive workflows
- Do not commit secrets; this repo already expects local secrets like `~/.gemini_key` to stay outside version control

### Naming and Structure
- Variables use snake_case: `target_user`, `projects_dir`, `packages_dev_tools`
- Helper commands use the `archdev-` prefix
- Filenames stay lowercase with hyphens or underscores matching nearby files
- Role/task names stay descriptive and human-readable

### Error Handling
- Fail early on hard prerequisites such as Arch-only assumptions
- For optional AUR/desktop integrations, degrade gracefully and emit a clear message
- Use `ignore_errors: true` or relaxed `failed_when` only when failure is intentionally non-fatal
- If a task may fail safely, make that obvious in the task name or comment

## Agent Guidance
- Treat this repo as infrastructure code for a live workstation; defaults affect real machines
- Be careful with `/etc`, systemd, firewall rules, package installs, bootloader hooks, and filesystem automation
- Edit source files in the repo, not generated files on the host
- If adding packages, place them in the correct official or AUR list rather than scattering them across roles
- If adding a helper script, install it under `~/.config/helpers/` and expose it via `/usr/local/bin` to match the existing pattern
- If adding a new task group, add useful tags so targeted runs remain possible
