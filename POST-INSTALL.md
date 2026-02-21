# 🚀 ArchDev 3.0 - Guia Pós-Instalação

Após executar `./setup.sh`, siga estes passos:

## 1. Reiniciar o sistema
```bash
sudo reboot
```

## 2. Configurar Bitwarden (Password Manager)
```bash
archdev-bitwarden-setup
# Ou: ~/.config/helpers/bitwarden-setup.sh
# Siga as instruções para configurar seu email e fazer login
```

## 3. Configurar MariaDB (se usar)
```bash
sudo archdev-mariadb-setup
# Ou: sudo ~/.config/helpers/mariadb-setup.sh
# Gera password segura automaticamente
```

### Helpers disponíveis em ~/.config/helpers/
- `archdev-bitwarden-setup` - Configurar Bitwarden
- `archdev-mariadb-setup` - Configurar MariaDB
- `archdev-backup-keys` - Backup de chaves SSH + GPG
- `git-autosync` - Sincronização automática de repos

## 4. Atalhos Principais

### Sistema
- `Super + Enter` → Terminal (Kitty)
- `Super + B` → Firefox
- `Super + E` → File Manager (Thunar)
- `Super + R` → Rofi (apps)
- `Super + P` → Bitwarden (passwords via rofi-rbw)
- `Super + Shift + E` → Emojis
- `Super + Shift + C` → Calculadora
- `Super + Escape` → Bloquear tela
- `Super + O` → Menu de energia (wlogout)
- `Super + X` → Sair do Hyprland

### Night Mode
- `Super + Shift + N` → Toggle night mode (filtro luz azul)
- Ou clique no ícone da lâmpada na waybar

### Workspaces
- `Super + 1-9` → Mudar workspace
- `Super + Shift + 1-9` → Mover janela para workspace

## 5. Comandos Úteis

### Terminal (ZSH)
```bash
update          # Atualizar sistema
install <pkg>   # Instalar pacote
search <pkg>    # Procurar pacote
remove <pkg>    # Remover pacote
nv              # Neovim
lg              # LazyGit
sys             # btop (monitor sistema)
```

### Docker
```bash
docker run hello-world    # Testar docker
```

## 6. Personalização

### Waybar
Edite `~/.config/waybar/style.css` para cores/tamanhos

### Hyprland  
Edite `~/.config/hypr/hyprland.conf` (gerado do template)

### Temas
Todos os temas Catppuccin Mocha já aplicados!

---

**Problemas?** Verifique logs em `~/.local/log/` ou abra uma issue.
