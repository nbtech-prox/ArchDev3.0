# ArchDev 4.0 - Doctor

O comando de diagnóstico da 4.0 é:

```bash
scripts/archdev doctor
```

O `doctor` é executado automaticamente no fim de:

```bash
scripts/archdev apply <perfil>
```

## O que valida

O `doctor` já usa o contexto de:

- perfil aplicado por último (`minimal`, `dev`, `full`)
- tipo de hardware detetado em `host_vars`

Isto permite validar a máquina com critérios diferentes sem gerar falsos positivos em VMs ou no perfil `minimal`.

### Base
- `ansible`, `git`, `curl`, `sudo`

### Sistema
- `NetworkManager`, `bluetooth`, `sshd`, `ufw`
- root em Btrfs
- `snapper` configurado
- presença do `limine.conf`

### Desktop
- `Hyprland`, `waybar`, `rofi`, `kitty`, `firefox`
- ficheiro global de prioridade da GPU apenas quando o host o exigir

### Desenvolvimento
- `php`, `composer`, `laravel`
- `python`, `poetry`
- `node`, `npm`, `opencode`
- `docker`
- `psql`, `pg_isready`
- extensões PHP críticas como `pdo_pgsql` e `mbstring`

### Helpers
- `archdev-postgresql-setup`
- `archdev-bitwarden-setup`
- `archdev-backup-keys`
- `archdev-gpu-status`

> No perfil `minimal`, os blocos de desenvolvimento e helpers de dev passam a ser tratados como opcionais.
> Nos perfis `dev` e `full`, continuam a ser obrigatórios.

## Interpretação

- `[ok]` tudo certo
- `[aviso]` algo não crítico ou ainda pendente de logout/reboot
- `[falha]` algo que deve ser corrigido

Se o `doctor` termina com falhas, devolve código de saída `1`.

Quando isso acontece após um `apply`, o ArchDev mostra também o snapshot pré-apply, para facilitar rollback controlado.
