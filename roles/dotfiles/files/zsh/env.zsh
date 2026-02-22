# ================= ENV =================

# ASDF
[ -f /opt/asdf-vm/asdf.sh ] && source /opt/asdf-vm/asdf.sh

# DIRENV
eval "$(direnv hook zsh)"

# STARSHIP (last!)
eval "$(starship init zsh)"