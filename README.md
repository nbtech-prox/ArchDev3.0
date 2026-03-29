# ❄️ ArchDev v3.0 - The Elite Developer Infrastructure (Ansible Edition)

<!-- TODO: Adicionar screenshot do ambiente (substituir preview_nord.png) -->

<div align="center">

![License](https://img.shields.io/badge/License-MIT-blue.svg)
![Arch Linux](https://img.shields.io/badge/Arch-Linux-blue?logo=arch-linux&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-Wayland-green)
![Ansible](https://img.shields.io/badge/Ansible-Automation-EE0000?logo=ansible&logoColor=white)
![Theme](https://img.shields.io/badge/Theme-Catppuccin%20Mocha-F5C2E7)

**O ambiente definitivo para produtividade extrema em Arch Linux.**
*Agora reescrito do zero com Ansible para automação profissional, idempotência e modularidade pura.*

[Instalação](#-instalação) • [Pós-Instalação](#-pós-instalação) • [Ambientes Herméticos](#-ambientes-herméticos-bubble-v30) • [Atalhos do Sistema](#-domínio-do-sistema-guia-de-atalhos-master)

</div>

---

## 💎 A Filosofia ArchDev v3.0

O **ArchDev v3.0** não é apenas uma atualização visual. É uma evolução na arquitetura. Abandonámos os scripts bash frágeis e abraçámos a **Infraestrutura como Código (IaC)** com **Ansible**.

*   **Idempotente**: O `setup.sh` pode ser corrido infinitas vezes. Ele apenas aplica o que mudou, sem duplicar configs ou partir o sistema.
*   **Modular**: Queres apenas a stack PHP? O ambiente gráfico? É tudo gerido por `roles` independentes.
*   **Seguro**: Rollbacks automáticos no boot (Btrfs + Snapper + Limine) e backups automáticos das tuas configs locais antes de qualquer alteração.
*   **Estético**: Transição completa para **Catppuccin Mocha** (GTK, Qt, Hyprland, SDDM, Terminal), substituindo o antigo Nord.

---

## 🛠️ Stack Tecnológica

### Core
- **Window Manager**: Hyprland (Wayland puro)
- **Barra**: Waybar (Estilo "Pill" Catppuccin) com deteção inteligente de projetos
- **Launcher**: Rofi (Substituto do Wofi da v2.0)
- **Terminal**: Kitty (GPU accelerated) + ZSH + Starship Prompt
- **Editor**: Neovim Pro (Lazy.nvim, LSP, Treesitter)
- **PDF**: Zathura (tema Catppuccin Mocha)
- **Screenshots**: Grim + Slurp + Swappy (editor visual)
- **Clipboard**: Cliphist + GUI (rofi)
- **Boot**: Limine + Btrfs Assistant
- **Saúde**: Wlsunset (filtro de luz azul) com toggle rápido

### Development Ready (Últimas Versões)
- **OpenCode**: instalado automaticamente com `npm i -g opencode-ai` para uso imediato no terminal (`opencode`)
- **Laravel / PHP (ASDF Versionado)**:
    - **PHP 8.x via ASDF**: Versionamento de PHP por projeto usando `bubble l`.
    - Todas as extensões ativas (bcmath, intl, gd, pdo, etc.).
    - **PostgreSQL**: configurado para desenvolvimento local, mais robusto para projectos modernos.
    - **Apache**: Configurado com `mpm_prefork` e suporte a vhosts.
- **Python Ecosystem**: Poetry + Python (via ASDF) para gestão hermética (`bubble p`).
- **Docker**: Configurado (rootless opcional) e `docker-compose`.
- **Password Manager**: `rbw` (Bitwarden CLI) + `rofi-rbw` (Super+P) para gestão segura de passwords.
- **Segurança**: Fail2ban (proteção SSH), UFW firewall, auditoria Lynis

---

## 🚀 Instalação

> Nota: o repositório está a preparar a transição para a arquitectura `ArchDev 4.0`.
> Já existem os primeiros blocos de documentação e o wrapper `scripts/archdev`,
> mas o fluxo principal estável continua a ser o `setup.sh`.

### 1. Pré-requisitos (Arch Linux Limpo)
Recomendamos instalar o Arch Linux usando o **`archinstall`** com estas opções críticas para garantir a resiliência do sistema:

*   **Bootloader**: Escolha **Limine** (Moderno/Rápido e nativo para snapshots).
*   **Filesystem**: Escolha **Btrfs**.
*   **Profile**: Escolha **Minimal** (sem ambiente gráfico). O nosso script instala o Hyprland.
*   **Audio**: Escolha **Pipewire**.

### 2. Passo-a-passo no Novo Sistema

```bash
# 1. Clone o repositório
git clone https://github.com/teu-usuario/ArchDev3.0.git
cd ArchDev3.0

# 2. Execute o Setup Mágico
chmod +x setup.sh
./setup.sh full
```

### Preview da arquitectura 4.0

Já podes explorar os novos ficheiros-base da futura 4.0:

```bash
scripts/archdev --help
cat docs/architecture-4.0.md
cat docs/profiles-4.0.md
cat docs/migration-4.0.md
cat docs/doctor-4.0.md
```

Também já existe um fluxo declarativo inicial:

```bash
scripts/archdev init
scripts/archdev apply full
scripts/archdev status
scripts/archdev doctor
scripts/archdev rollback list
archdev-rollback list
```

> O `setup.sh` continua a ser o caminho estável da 3.x. O `scripts/archdev apply` já usa a nova entrada declarativa `playbooks/site-4.yml`.
> No fluxo 4.0, o `apply` já cria snapshots pre/post quando o `snapper` está disponível e corre `doctor` automaticamente no fim.
> Antes do `apply`, o wrapper deteta o hardware da máquina, mostra um resumo assistido e grava `inventories/host_vars/<hostname>.yml` com defaults seguros.
> O fluxo 4.0 já foi validado em VM Arch Linux limpa com os perfis `minimal` e `full`, incluindo sessão `Hyprland`, `SDDM`, `doctor`, Docker, PostgreSQL e OpenCode.
> Para não depender de `~/ArchDev3.0`, o sistema também instala o helper global `archdev-rollback`, dedicado a snapshots e rollback.

Perfis disponíveis:

```bash
./setup.sh minimal
./setup.sh dev
./setup.sh full
```

- `minimal`: ambiente gráfico, terminal, browser e dotfiles essenciais
- `dev`: workstation de desenvolvimento com Docker, Laravel/PHP, Python, PostgreSQL e OpenCode
- `full`: tudo o que existe no perfil `dev` mais ferramentas adicionais de trabalho, full-stack e produtividade

### O que instala cada perfil

#### `minimal`
- Hyprland, Waybar, Rofi, Kitty, ZSH, Starship
- Firefox, Thunar, clipboard, screenshots, notificações, áudio, Bluetooth
- Neovim e dotfiles base
- Btrfs, Snapper, UFW, Fail2ban, Lynis
- `python-pywal` + theming dinâmico baseado no wallpaper

#### `dev`
- Tudo do `minimal`
- Docker e Docker Compose
- PHP + Composer + extensões para Laravel
- Laravel Installer global via Composer
- Python + Poetry
- PostgreSQL
- Node.js + npm + nvm
- OpenCode via `npm i -g opencode-ai`
- Helpers de Bitwarden, PostgreSQL e backup de chaves

#### `full`
- Tudo do `dev`
- Bun, pnpm e yarn
- GitHub CLI e git-delta
- HTTPie e yq
- Terraform
- lazydocker
- Redis
- Chromium
- tmux e just
- shellcheck, yamllint e ansible-lint
- pgcli e DBeaver

> 💡 `kubectl` e `helm` ficam de fora do `full` e podem entrar mais tarde num perfil específico de DevOps.

> ⚠️ **Aviso:** O script irá pedir a tua password de administrador (sudo) no início da execução (`-K`) para elevar privilégios e instalar todos os pacotes necessários.

**O que o script faz sozinho:**
1.  Verifica e instala o Ansible.
2.  Instala todos os pacotes (Pacman + AUR).
3.  Configura o sistema (Btrfs, Snapper).
4.  Configura a UI (Hyprland, Waybar, Catppuccin).
5.  Sincroniza os Dotfiles e Scripts.

> 💡 **Nota:** Após a instalação podes apagar a pasta `ArchDev3.0/`. O sistema fica independente.

---

## 🔧 Pós-Instalação & Manutenção

> ⚠️ **IMPORTANTE:** Após correr `./setup.sh`, executa:
> ```bash
> sudo reboot
> ```
> O reboot é necessário para o Docker ativar e o Hyprland iniciar corretamente.

### 1. PostgreSQL (Configuração inicial)
Após o reboot, configura o PostgreSQL automaticamente:
```bash
sudo archdev-postgresql-setup
```
Este script cria o utilizador, a base de dados e uma password segura para desenvolvimento local.

### 2. Docker
O teu utilizador já está no grupo `docker`. Após o **reboot**, testa:
```bash
docker run hello-world
```

### 2.1. OpenCode
O OpenCode fica instalado automaticamente via `npm i -g opencode-ai`. Depois da instalação podes testar com:
```bash
opencode
```

Num projeto novo, o fluxo recomendado é:
```bash
cd /caminho/do/projeto
opencode
# dentro do OpenCode
/init
```

### 2.2. Laravel
O instalador do Laravel fica disponível automaticamente no perfil `dev` e `full`:

```bash
laravel new meu-projecto
```

Também fica disponível o alias curto:

```bash
lar new meu-projecto
```

### 3. Password Manager (Bitwarden via rbw)
O `rbw` é um cliente CLI não-oficial do Bitwarden. Configura com:

```bash
# Configura automaticamente
archdev-bitwarden-setup

# Durante o setup, vai pedir:
# - Email da conta Bitwarden
# - Master password
```

Depois de configurado:
- `Super+P` → Abrir rofi-rbw (procurar passwords)
- `rbw get github.com` → Obter password (CLI)
- `rbw generate` → Gerar password aleatória

### Wallpaper + tema dinâmico

O ArchDev 4.0 passa a suportar sincronização automática do tema com o wallpaper atual.

- `Super+Shift+W` abre o seletor gráfico de wallpapers via `rofi`
- no `Thunar`, o menu de contexto ganha a ação `Set as ArchDev wallpaper`
- ao mudar wallpaper, o sistema atualiza automaticamente `waybar`, `rofi`, `kitty`, `Hyprland`, `gtk` e `qt/kvantum`
- o seletor `rofi` procura wallpapers em `~/.config/wallpapers`, `~/Pictures`, `~/Downloads`, `~/Wallpapers` e `~/Imagens`

### 4. Backup de Chaves de Segurança (Importante!)
Faça backup das tuas chaves SSH e GPG:
```bash
archdev-backup-keys
```
Guarda o backup num local seguro (USB, cloud cifrada).

### 5. Apagar a Pasta de Instalação (Opcional)
Após a instalação completa, a pasta `ArchDev3.0/` pode ser removida:
```bash
cd ..
rm -rf ArchDev3.0/
```
O sistema fica totalmente independente.

### 6. Limpeza do Sistema
Mantenha o sistema leve libertando espaço em disco:
*   `paccache -r`: Mantém apenas as 3 últimas versões de pacotes pacman/AUR.
*   `docker system prune -a`: Remove containers, volumes e imagens Docker não em uso.

---

## 🧬 Ambientes Herméticos (Bubble v3.0)

O setup v3.0 mantém o conceito de **bolhas de ambiente** da v2.5. Cada projeto é isolado.

### O Comando `bubble`
Dentro da pasta do seu projeto, execute:

```bash
bubble [opção]
```

| Comando | Descrição | O que faz por trás dos panos? |
| :--- | :--- | :--- |
| `bubble l` | Cria bolha **Laravel / PHP** | Cria `.tool-versions` (php) e ativa `direnv` com suporte asdf. |
| `bubble p` | Cria bolha **Python** | Cria `.tool-versions` (python/poetry) e configura virtualenv local. |

**Exemplo Laravel:**
```bash
mkdir meu-projeto && cd meu-projeto
git init
bubble l
# O terminal agora usa a versão PHP definida no projeto, isolada do sistema.
```

---

## 🔄 Automação Git (Sync Offline)

O teu ambiente inclui o serviço `git-autosync` que é instalado e corre em background por padrão:
*   Monitoriza a tua pasta de projetos (configurada no `inventory/group_vars/all.yml` via `projects_dir`).
*   A cada 5 minutos, verifica de forma silenciosa se há conexão à internet.
*   Se houver, faz `git push` automático de todos os teus repositórios com alterações não sincronizadas. Perfeito para trabalhar em movimento e sincronizar o código assim que apanhas Wi-Fi.

> 💡 **Dica:** Para desativar/parar temporariamente o sync automático, usa: `sudo systemctl stop git-autosync`

---

## ⌨️ Domínio do Sistema (Guia de Atalhos Master)

### 🖥️ Interface & Janelas (Hyprland)
| Atalho | Ação |
| :--- | :--- |
| `Super + Enter` | Abrir Terminal (Kitty) |
| `Super + B` | Abrir Browser (Firefox) |
| `Super + E` | Abrir Explorador (Thunar) |
| `Super + Space` | Lançador de Apps (Rofi) |
| `Super + A` | Abrir IDE (Antigravity) |
| `Super + P` | Password Manager (rofi-rbw) |
| `Super + V` | Clipboard Manager (GUI com histórico) |
| `Super + Shift + E` | Emojis (Rofi) |
| `Super + Shift + C` | Calculadora (Rofi) |
| `Super + Shift + V` | Toggle Floating Window |
| `Super + Shift + N` | Toggle Night Mode (luz azul) |
| `Super + Q` | Fechar Janela Ativa |
| `Super + O` | Menu de Energia (Wlogout) |
| `Super + Escape` | Bloquear Ecrã (Hyprlock) |
| `Super + X` | Sair do Hyprland |
| `Super + Setas` | Mover Foco |
| `Super + Shift + Setas` | Mover Janela |
| `Super + 1-9` | Mudar Workspace |

### 🪟 Gestão de Janelas
| Atalho | Ação |
| :--- | :--- |
| `Super + F` | Fullscreen |
| `Super + Shift + V` | Toggle Floating Window |
| `Super + Shift + P` | Pseudo Tiling (Dwindle) |
| `Super + J` | Toggle Split (Dwindle) |

### 🗂️ Workspaces Avançados
| Atalho | Ação |
| :--- | :--- |
| `Super + Tab` | Workspace Anterior |
| `Super + Ctrl + Setas` | Workspace Seguinte/Anterior |
| `Super + Ctrl + H/L` | Workspace Seguinte/Anterior (Vim-style) |
| `Super + Shift + Setas (←/→)` | Mover Janela para Workspace Adjacente |
| `Super + Shift + H/L` | Mover Janela para Workspace Adjacente (Vim-style) |
| `Super + Shift + 1-9` | Mover Janela para Workspace Específico |
| `Super + S` | Toggle Special Workspace (Scratchpad) |
| `Super + Shift + S` | Mover Janela para Special Workspace |
| `Super + Scroll` | Mudar Workspace com Rato |

### 🖱️ Rato (Mouse)
| Ação | Comando |
| :--- | :--- |
| `Super + Botão Esquerdo` | Mover Janela |
| `Super + Botão Direito` | Redimensionar Janela |

### 📸 Screenshots (Grim + Swappy)
| Atalho | Ação |
| :--- | :--- |
| `Print` | Capturar Região → Editor Swappy |
| `Shift + Print` | Capturar Ecrã Inteiro → Editor Swappy |
| `Ctrl + Print` | Capturar Região → Clipboard |

### 💻 Neovim Pro (A tua IDE)
A tecla **Leader** é o `Espaço`.

| Atalho | Ação |
| :--- | :--- |
| `Space + ff` | Pesquisar Ficheiro (Telescope) |
| `Space + fg` | Pesquisar Texto (Grep) |
| `Space + e` | Abrir Árvore de Ficheiros (NvimTree/NeoTree) |
| `Space + lg` | Abrir LazyGit |
| `Space + w` | Salvar Ficheiro |
| `Space + q` | Sair |

---

## ⌨️ Terminal Aliases (ZSH)

### Navegação & Sistema
| Alias | Comando | Descrição |
| :--- | :--- | :--- |
| `ls` | `eza --icons --group-directories-first` | Listar com ícones |
| `ll` | `eza -l --icons --group-directories-first` | Listar detalhado |
| `la` | `eza -la --icons --group-directories-first` | Listar tudo (inclui ocultos) |
| `cat` | `bat` | Cat com syntax highlighting |
| `sys` | `btop` | Monitor de sistema |

### Pacman/Yay (AUR)
| Alias | Comando | Descrição |
| :--- | :--- | :--- |
| `install` | `yay -S` | Instalar pacote |
| `update` | `yay -Syu` | Atualizar sistema |
| `search` | `yay -Ss` | Procurar pacote |
| `remove` | `yay -Rns` | Remover pacote |

### Desenvolvimento
| Alias | Comando | Descrição |
| :--- | :--- | :--- |
| `nv` | `nvim` | Abrir Neovim |
| `edit` | `nvim` | Editar ficheiro |
| `lg` | `lazygit` | Git TUI |
| `ld` | `lazydocker` | Docker TUI |

### Laravel (PHP)
| Alias | Comando | Descrição |
| :--- | :--- | :--- |
| `artisan` | `php artisan` | Comandos Laravel |
| `serve` | `php artisan serve` | Servidor de desenvolvimento |
| `migrate` | `php artisan migrate` | Executar migrations |
| `fresh` | `php artisan migrate:fresh --seed` | Reset BD com seeds |
| `tinker` | `php artisan tinker` | Console interativo |

### Python / Poetry
| Alias | Comando | Descrição |
| :--- | :--- | :--- |
| `py` | `python` | Python |
| `p` | `poetry` | Poetry |
| `pr` | `poetry run` | Executar no ambiente Poetry |
| `ps` | `poetry shell` | Entrar no shell Poetry |
| `pa` | `poetry add` | Adicionar dependência |
| `flet-run` | `poetry run flet run` | Executar app Flet |
| `flask-dev` | `export FLASK_DEBUG=1 && poetry run flask run` | Flask em modo dev |

### Ambientes Herméticos (`bubble`)
| Comando | Descrição |
| :--- | :--- |
| `bubble p` | Criar ambiente Python/Poetry (cria `.tool-versions` + direnv) |
| `bubble l` | Criar ambiente Laravel/PHP (cria `.tool-versions` + direnv) |

### 🚀 Dev Launcher (Atalhos ZSH)
Atalhos rápidos no terminal para navegação inteligente de projetos:

| Atalho | Função | Descrição |
| :--- | :--- | :--- |
| `Ctrl + T` | FZF file search | Pesquisar ficheiros com preview (`bat` / `eza tree`) |
| `Ctrl + R` | FZF history | Pesquisar histórico de comandos |
| `Alt + C` | FZF cd (Zoxide) | Navegar para diretório frequente via Zoxide |
| `Alt + P` | `laravelf` | Fuzzy-find projetos Laravel (procura `artisan` em `$HOME` e `/mnt/projetos`) |
| `Alt + G` | `gitf` | Fuzzy-find repositórios Git com preview de `git status` |
| `Alt + D` | `dev_launcher` | Menu interativo Dev com 5 opções: Projects (Zoxide), Laravel, Git, Docker, Antigravity |

---

## 🛠️ Comandos ArchDev (Helpers)

Scripts instalados automaticamente:

| Comando | Descrição |
| :--- | :--- |
| `archdev-bitwarden-setup` | Configura Bitwarden (rbw) |
| `archdev-postgresql-setup` | Configura PostgreSQL com utilizador, base de dados e password segura |
| `archdev-backup-keys` | Backup de chaves SSH + GPG |

---

## 🛡️ Segurança (5 Camadas de Proteção)

### 1. Btrfs + Snapper (Recuperação)
- Snapshots automáticos antes de cada alteração
- Retenção: 3 snapshots (não enche o disco)
- Rollback no boot menu (Limine)
- **Automático** - não precisas fazer nada

### 2. Firewall UFW (Proteção de Rede)
- Política padrão: negar entrada, permitir saída
- Portas abertas: SSH (22), dev ports (8000, 8080, 5000, 8550)
- Comando: `sudo ufw status`

### 3. Fail2ban (Proteção SSH)
- Bloqueia IPs após 3 tentativas falhadas de login
- Tempo de ban: 1 hora
- Ignora redes locais (192.168.x.x, 10.x.x.x)
- Comando: `sudo fail2ban-client status`

### 4. Password Manager (Proteção de Credenciais)
- `rbw` (Bitwarden CLI): passwords cifradas na cloud Bitwarden
- Integração rofi: `Super+P` (rofi-rbw)

### 5. Auditoria de Sistema (Lynis)
- Lynis: ferramenta de auditoria de segurança
- Comando: `sudo lynis audit system`
- Verifica configurações do sistema, permissões incorretas e pacotes vulneráveis.

✅ **Resumo das 5 Camadas de Segurança:**

| # | Camada | Proteção | Status |
|---|--------|----------|--------|
| 1 | Btrfs + Snapper | Rollback automático no boot | ✅ |
| 2 | Firewall UFW | Bloqueia intrusões e portas não requeridas | ✅ |
| 3 | Fail2ban | Anti brute-force SSH e web apps | ✅ |
| 4 | Password Manager | Credenciais cifradas (GPG) | ✅ |
| 5 | Auditoria Lynis | Analisador de vulnerabilidades avançado | ✅ |

**Funcionalidades Extra de Produtividade & Utilidades:**
- 🌙 **Night Mode Automático**: Adapta-se ao pôr-do-sol local. Usa `Super+Shift+N` para pausar temporariamente as cores (útil para edição de imagem).
- 📋 **Clipboard GUI**: `Super+V` - Histórico com rofi
- 📸 **Screenshot Editor**: `Print` ou `Shift+Print` - Abre Swappy
- 🔐 **Backup de Chaves**: Script `archdev-backup-keys` para assistente na recolha e backup manual para PEN USB ou Cloud das tuas chaves cruciais (`~/.ssh`), chaves `GPG`, e configs `Git`.

---

## ⚙️ Personalização

O ArchDev 3.0 é configurável para se adaptar às tuas necessidades:

### Keyboard Layout

Por padrão, o layout é Português (`pt`). Para alterar, edita:

```yaml
# inventory/group_vars/all.yml
keyboard_layout: "us"  # ou "br", "es", "fr", etc.
```

### Deteção Automática de GPU

O Hyprland fica afinado para usar a tua GPU dedicada primeiro e aplicar otimizações AMD:

| GPU | Otimizações Aplicadas |
|-----|----------------------|
| AMD dedicada | `WLR_DRM_DEVICES` com prioridade para a RX 6700 XT, `AQ_DRM_DEVICES`, `DRI_PRIME=1`, `LIBVA_DRIVER_NAME=radeonsi` |
| Intel | `LIBVA_DRIVER_NAME=i965` |
| NVIDIA | `LIBVA_DRIVER_NAME=nvidia`, `GBM_BACKEND=nvidia-drm` |
| Genérica | Defaults seguros |

### Otimizações aplicadas ao teu hardware

Configuração pensada para:

- CPU: AMD Ryzen 7 9700X
- GPU principal: AMD Radeon RX 6700 XT
- GPU secundária: AMD integrada
- RAM: 64 GiB
- Sistema em NVMe Btrfs

O perfil atual aplica:

- prioridade à GPU dedicada no ambiente gráfico
- variáveis de sessão globais em `/etc/environment.d/90-archdev-gpu.conf`
- `zram` com `zstd`
- `sysctl` afinado para workstation de desenvolvimento
- Docker com BuildKit, `overlay2`, logs locais e `live-restore`
- PostgreSQL afinado para NVMe + 64 GiB de RAM

Para confirmar rapidamente a GPU prioritária após entrares na sessão:

```bash
gpu
```

ou:

```bash
archdev-gpu-status
```

> Nota: por pedido teu, o setup não altera nada em `/mnt/projetos`.

### Pacotes AUR

Os pacotes AUR estão divididos em:

- **Essenciais**: wlogout, awww, hyprpicker, asdf-vm, antigravity
- **Opcionais**: temas Catppuccin, waypaper, imv, btrfs-assistant, etc.

Se um pacote AUR falhar, o playbook continua (não interrompe a instalação).

### Diretório de Projetos

Por padrão, o git-autosync usa `/mnt/projetos`. Para alterar:

```yaml
# inventory/group_vars/all.yml
projects_dir: "/caminho/do/teu/disco"
```

> **Nota**: Usa um caminho absoluto. Idealmente um disco separado para os teus projetos.

### Night Mode (Localização)

O filtro de luz azul (`wlsunset`) adapta-se automaticamente ao pôr/nascer do sol. Por padrão usa coordenadas de Lisboa. Para alterar:

```yaml
# inventory/group_vars/all.yml
wlsunset_latitude: "40.7"    # Latitude da tua cidade
wlsunset_longitude: "-74.0"  # Longitude da tua cidade
```

> 💡 **Dica**: Encontra as tuas coordenadas em [latlong.net](https://www.latlong.net/)

---

<div align="center">
  <sub>Orgulhosamente construído para produtividade. 🚀🏁</sub>
</div>
