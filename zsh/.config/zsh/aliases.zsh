# aliases.zsh — curated aliases for INTERACTIVE shells.

# ---------------------------------------------------------------------------
# cat family → bat
# ---------------------------------------------------------------------------
alias catt='bat --paging=always'
alias batp='bat --plain'

# ---------------------------------------------------------------------------
# grep family → rg
# ---------------------------------------------------------------------------
alias grep='rg'
alias rgf='rg --files | rg'

# ---------------------------------------------------------------------------
# System
# ---------------------------------------------------------------------------
alias c='clear'
alias e='exit'
alias update='sudo pacman -Syu'
alias upgrade='sudo pacman -Syu --noconfirm'
alias clean='sudo pacman -Sc --noconfirm'
alias orphans='pacman -Qtdq || true'
alias clear-orphans='sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null || true'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias top='btop'
alias htop='btop'
alias sysinfo='fastfetch'

# ---------------------------------------------------------------------------
# Navigation & history
# ---------------------------------------------------------------------------
alias h='history | tail -50'
alias hg='history | grep --color=auto'

# ---------------------------------------------------------------------------
# Tools
# ---------------------------------------------------------------------------
alias tl='tldr'
alias jq.='jq .'
alias y='yazi'
alias tmux='tmux -2'          # force 256-color
alias tls='tmux list-sessions'
alias chx='chmod +x'
alias mkdir='mkdir -p'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias b='btop'

# ---------------------------------------------------------------------------
# Nuke (git-aware) — hidden, explicit, prefixed with dot for safety
# ---------------------------------------------------------------------------
alias .clean-dotfiles='git -C "$HOME/dotfiles" clean -fdX'

# ---------------------------------------------------------------------------
# Misc
# ---------------------------------------------------------------------------
alias weather='curl -s "wttr.in/?format=3" | xargs echo'
alias ip='curl -s ifconfig.me | xargs echo'
alias local-ip='ip -4 addr show | grep -oP "(?<=inet\\s)\\d+(\\.\\d+){3}" | grep -v "^127\\|^169\\|^0\\." | head -1'
