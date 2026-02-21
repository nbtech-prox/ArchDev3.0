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
- **Laravel / PHP (ASDF Versionado)**:
    - **PHP 8.x via ASDF**: Versionamento de PHP por projeto usando `bubble l`.
    - Todas as extensões ativas (bcmath, intl, gd, pdo, etc.).
    - **MariaDB Otimizado**: Configuração "Muscle Car" para 64GB RAM + NVMe.
    - **Apache**: Configurado com `mpm_prefork` e suporte a vhosts.
    - **phpMyAdmin**: Pré-configurado via Apache e Socket Unix.
- **Python Ecosystem**: Poetry + Pyenv (via ASDF) para gestão hermética (`bubble p`).
- **Docker**: Configurado (rootless opcional) e `docker-compose`.
- **Password Manager**: `rbw` (Bitwarden CLI) + `rofi-rbw` (Super+P) para gestão segura de passwords.
- **Segurança**: Fail2ban (proteção SSH), UFW firewall, auditoria Lynis

---

## 🚀 Instalação

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
./setup.sh
```

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

### 1. MariaDB (Segurança)
Após o reboot, configura o MariaDB automaticamente:
```bash
sudo archdev-mariadb-setup
```
Este script configura tudo automaticamente e gera uma password segura para root.

> 💡 Alternativa manual: `sudo mariadb-secure-installation`

### 2. Docker
O teu utilizador já está no grupo `docker`. Após o **reboot**, testa:
```bash
docker run hello-world
```

### 3. Spotify
O Spotify e o tema Catppuccin já estão instalados. Basta abrir o Spotify uma vez para ativar.

### 4. Password Manager (Bitwarden via rbw)
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

### 5. Backup de Chaves de Segurança (Importante!)
Faça backup das tuas chaves SSH e GPG:
```bash
archdev-backup-keys
```
Guarda o backup num local seguro (USB, cloud cifrada).

### 6. Apagar a Pasta de Instalação (Opcional)
Após a instalação completa, a pasta `ArchDev3.0/` pode ser removida:
```bash
cd ..
rm -rf ArchDev3.0/
```
O sistema fica totalmente independente.

### 7. Limpeza do Sistema
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
| `Super + R` | Lançador de Apps (Rofi) |
| `Super + P` | Password Manager (rofi-rbw) |
| `Super + V` | Clipboard Manager (GUI com histórico) |
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
| `Super + Shift + Setas` | Mover Janela para Workspace Adjacente |
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

---

## 🛠️ Comandos ArchDev (Helpers)

Scripts instalados automaticamente:

| Comando | Descrição |
| :--- | :--- |
| `archdev-bitwarden-setup` | Configura Bitwarden (rbw) |
| `archdev-mariadb-setup` | Configura MariaDB com password segura |
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

O Hyprland detecta automaticamente a tua GPU e aplica otimizações:

| GPU | Otimizações Aplicadas |
|-----|----------------------|
| AMD | `LIBVA_DRIVER_NAME=radeonsi`, `VDPAU_DRIVER=radeonsi` |
| Intel | `LIBVA_DRIVER_NAME=i965` |
| NVIDIA | `LIBVA_DRIVER_NAME=nvidia`, `GBM_BACKEND=nvidia-drm` |
| Genérica | Defaults seguros |

### Pacotes AUR

Os pacotes AUR estão divididos em:

- **Essenciais**: wlogout, swww, hyprpicker, asdf-vm, antigravity
- **Opcionais**: spotify, lazydocker, temas Catppuccin, etc.

Se um pacote AUR falhar, o playbook continua (não interrompe a instalação).

### Diretório de Projetos

Por padrão, o git-autosync usa `/mnt/projetos`. Para alterar:

```yaml
# inventory/group_vars/all.yml
projects_dir: "/caminho/do/teu/disco"
```

> **Nota**: Usa um caminho absoluto. Idealmente um disco separado para os teus projetos.

---

<div align="center">
  <sub>Orgulhosamente construído para produtividade. 🚀🏁</sub>
</div>
