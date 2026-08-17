# cat family -> bat
alias catt='bat --paging=always'
alias batp='bat --plain'

# grep family -> rg
alias grep='rg'
alias rgf='rg --files | rg'

# System & Package Management
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

# Tools
alias tl='tldr'
alias jq.='jq .'
alias y='yazi'
alias tmux='tmux -2'
alias tls='tmux list-sessions'
alias chx='chmod +x'
alias mkdir='mkdir -p'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias b='btop'

# Git Maintenance
alias .clean-dotfiles='git -C "$HOME/dotfiles" clean -fdX'
