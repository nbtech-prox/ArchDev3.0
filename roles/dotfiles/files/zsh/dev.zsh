# ================= DEV =================

laravelf() {
  local dir
  dir=$(fd -H -t f -g artisan $HOME /mnt/projetos 2>/dev/null \
        | xargs -r -n1 dirname | sort -u \
        | fzf --prompt="Laravel ❯ ") || return
  cd "$dir"
  zle reset-prompt
}
zle -N laravelf
bindkey '^[p' laravelf

gitf() {
  local dir
  dir=$(fd -H -t d -g .git $HOME /mnt/projetos 2>/dev/null \
        | xargs -r -n1 dirname | sort -u \
        | fzf --prompt="Git ❯ " \
              --preview 'git -C {} status -sb 2>/dev/null' \
              --preview-window=right:60%) || return
  cd "$dir"
  zle reset-prompt
}
zle -N gitf
bindkey '^[g' gitf

dev_launcher() {
  local choice dir

  choice=$(printf "
📁  Projects (Smart)
🚀  Laravel Projects
🌿  Git Repositories
🐳  Docker Containers
💻  Open in Antigravity
❌  Exit
" | fzf --prompt="Dev ❯ " --height=60% --border=rounded)

  case "$choice" in
    *Projects*)
      dir=$(zoxide query -l | fzf --prompt="Projects ❯ ") || return
      cd "$dir"
      ;;
    *Laravel*)
      laravelf
      return
      ;;
    *Git*)
      gitf
      return
      ;;
    *Docker*)
      docker ps
      ;;
    *Antigravity*)
      antigravity .
      ;;
  esac

  zle reset-prompt
}
zle -N dev_launcher
bindkey '^[d' dev_launcher


# ================= BUBBLE =================
bubble() {
  if [ "$1" = "p" ]; then
    # Python / Poetry
    if [ ! -f .tool-versions ]; then
      echo "python system" > .tool-versions
      echo "poetry system" >> .tool-versions
    fi
    echo "layout poetry" > .envrc
    direnv allow
    echo "🫧 Bubble: Poetry environment activated."

  elif [ "$1" = "l" ]; then
    # Laravel / PHP
    if [ ! -f .tool-versions ]; then
      echo "php system" > .tool-versions
    fi
    echo "use asdf" > .envrc
    direnv allow
    echo "🫧 Bubble: PHP/Laravel environment activated."

  else
    echo "Usage: bubble [p|l]"
    echo "  p = Python (Poetry)"
    echo "  l = Laravel (PHP)"
  fi
}