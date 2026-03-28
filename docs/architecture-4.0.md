# ArchDev 4.0 - Arquitectura Proposta

## Objectivo

Transformar o ArchDev numa workstation declarativa, atomic-like e com rollback previsível.

## Princípios

- sistema base pequeno e estável
- perfis declarativos (`minimal`, `dev`, `full`)
- tuning específico por máquina fora do perfil global
- snapshots antes e depois de alterações importantes
- ambientes de desenvolvimento isolados do host sempre que fizer sentido
- mínimo de AUR no caminho crítico

## Modelo de camadas

### Base
- pacotes essenciais
- rede, sudo, ssh, firewall, bluetooth
- Btrfs e manutenção base

### Desktop
- Hyprland, SDDM, Waybar, Rofi, Kitty
- GPU dedicada preferencial
- tema coerente via ficheiros estáticos

### Workstation
- browser, terminal, utilitários, produtividade

### Development
- Laravel / PHP
- PostgreSQL
- Docker
- Python
- Node / OpenCode

### Doctor / Rollback
- verificações pós-instalação
- snapshots e rollback controlado
- `apply` com snapshot antes/depois e `doctor` automático no fim

## Comandos-alvo da 4.0

```bash
scripts/archdev init
scripts/archdev apply minimal
scripts/archdev apply dev
scripts/archdev apply full
scripts/archdev status
scripts/archdev doctor
```

## Estrutura proposta

```text
bootstrap/
docs/
inventories/
playbooks/
roles/
scripts/
```

## Host-specific tuning

Na 4.0, o tuning específico da máquina deve viver em:

```text
inventories/host_vars/<hostname>.yml
```

Exemplos típicos:

- caminhos DRM da dGPU/iGPU
- RAM total
- `zram`
- coordenadas do `wlsunset`
- tuning local específico
- modo de hardware (`baremetal`, `vmware`, `virtualbox`, `kvm`)
- modo gráfico (`generic`, `amd`, `intel`, `nvidia`, `vmware`)
- tema seguro do `SDDM`

## Estratégia de migração

1. manter `setup.sh` funcional
2. introduzir wrapper `scripts/archdev`
3. introduzir perfis e features declarativas
4. mover tuning específico da máquina para `host_vars`
5. adicionar `doctor` e fluxo de rollback mais controlado

## Estado actual da migração

- `setup.sh` continua funcional como fluxo estável da 3.x
- `scripts/archdev apply <perfil>` já usa `playbooks/site-4.yml`
- `scripts/archdev apply <perfil>` já deteta hardware, pede confirmação e grava `host_vars`
- `playbooks/site-4.yml` carrega perfis e features declarativas
- `playbooks/site-4.yml` já carrega `host_vars` quando existir ficheiro por hostname
- o fluxo já adapta `Hyprland` e `SDDM` a VMs (`vmware`, `virtualbox`, `kvm`) com defaults seguros
- os perfis `minimal` e `full` já foram validados em VM Arch Linux limpa
- os roles de dev já começaram a ser separados por domínio funcional
- os roles `common` e `system` já começaram a ser decompostos em:
  - `base`
  - `security`
  - `aur`
  - `workstation`
  - `btrfs`
