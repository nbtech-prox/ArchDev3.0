# ================= FZF =================

# Load bindings
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# Zoxide
eval "$(zoxide init zsh)"
export FZF_ALT_C_COMMAND="zoxide query -l"

# Visual (Catppuccin)
export FZF_DEFAULT_OPTS="
--height=75%
--layout=reverse
--border=rounded
--padding=1
--info=inline
--prompt='❯ '
--pointer='➤'
--marker='✓'
--cycle
--ansi
--color=bg:#11111b,bg+:#1e1e2e,fg:#cdd6f4,fg+:#cdd6f4
--color=hl:#f38ba8,hl+:#f38ba8,info:#89b4fa,prompt:#cba6f7
--color=pointer:#f38ba8,marker:#a6e3a1,spinner:#f5c2e7
--color=border:#45475a
"

# Ctrl+T
export FZF_CTRL_T_COMMAND="fd --hidden --follow --exclude .git"
export FZF_CTRL_T_OPTS="--preview '
bat --color=always --style=numbers --line-range :200 {} 2>/dev/null \
|| eza --tree --level=2 --icons --color=always {} 2>/dev/null
' --preview-window=right:60%:wrap"

# Ctrl+R
export FZF_CTRL_R_OPTS="--preview-window=hidden"