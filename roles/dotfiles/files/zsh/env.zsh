# ================= ENV =================

# NPM
export PATH="$HOME/.npm-global/bin:$PATH"

# ASDF
export ASDF_DIR=/opt/asdf-vm
export PATH="$ASDF_DIR/bin:$ASDF_DIR/shims:$PATH"

# DIRENV
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# STARSHIP (last!)
if command -v starship >/dev/null 2>&1; then
  export STARSHIP_CONFIG="$HOME/.config/starship.toml"
  eval "$(starship init zsh)"
fi
