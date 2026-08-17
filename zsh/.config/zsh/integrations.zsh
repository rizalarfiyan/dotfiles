# mise — runtime/version manager
if command -v mise >/dev/null 2>&1; then
  _evalcache mise activate zsh
fi

# zoxide — directory jumping
if command -v zoxide >/dev/null 2>&1; then
  _evalcache zoxide init zsh
fi

# fzf — fuzzy finder & key bindings
if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
  export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
  export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
  export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"
  export FZF_TMUX_OPTS=" -p90%,70% "
  _evalcache fzf --zsh
fi

# atuin — shell history
. "$HOME/.atuin/bin/env"
_evalcache atuin init zsh

# starship — prompt
if command -v starship >/dev/null 2>&1; then
  _evalcache starship init zsh
fi
