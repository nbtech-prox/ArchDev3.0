# ================= ALIASES =================

alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first'
alias cat='bat'

alias install='yay -S'
alias update='yay -Syu'
alias search='yay -Ss'
alias remove='yay -Rns'

alias nv='nvim'
alias edit='nvim'
alias lg='lazygit'
alias ld='lazydocker'
alias sys='btop'
alias gpu='archdev-gpu-status'

# Laravel
alias lar='laravel'
alias artisan='php artisan'
alias serve='php artisan serve'
alias migrate='php artisan migrate'
alias fresh='php artisan migrate:fresh --seed'
alias tinker='php artisan tinker'

# Python
alias py='python'
alias p='poetry'
alias pr='poetry run'
alias ps='poetry shell'
alias pa='poetry add'
alias flet-run='poetry run flet run'
alias flask-dev='export FLASK_DEBUG=1 && poetry run flask run'
