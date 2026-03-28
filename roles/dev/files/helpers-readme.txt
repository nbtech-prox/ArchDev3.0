================================================================================
                    ARCHDEV 3.0 - HELPERS
================================================================================

Local: ~/.config/helpers/

Esta pasta contém todos os scripts auxiliares do ArchDev 3.0.
Os comandos estão disponíveis globalmente via symlinks em /usr/local/bin/

--------------------------------------------------------------------------------
HELPERS DISPONÍVEIS
--------------------------------------------------------------------------------

1. archdev-bitwarden-setup
   Configura o Bitwarden (rbw) para gestão de passwords
   Uso: archdev-bitwarden-setup

2. archdev-backup-keys
   Faz backup das chaves SSH e GPG
   Uso: archdev-backup-keys

3. archdev-postgresql-setup
   Configura o PostgreSQL com utilizador, base de dados e password segura
   Uso: sudo archdev-postgresql-setup

4. git-autosync
   Sincroniza repositórios git automaticamente
   Uso: git-autosync [diretório]

--------------------------------------------------------------------------------
COMANDOS RÁPIDOS
--------------------------------------------------------------------------------

# Listar todos os helpers
ls -la ~/.config/helpers/

# Ver conteúdo de um helper
cat ~/.config/helpers/nome-do-helper.sh

# Editar um helper (cuidado!)
nvim ~/.config/helpers/nome-do-helper.sh

--------------------------------------------------------------------------------
NOTAS
--------------------------------------------------------------------------------

• Não apague esta pasta ou os helpers deixarão de funcionar
• Os symlinks em /usr/local/bin/ apontam para aqui
• Para restaurar um symlink: sudo ln -s ~/.config/helpers/nome.sh /usr/local/bin/nome

================================================================================
