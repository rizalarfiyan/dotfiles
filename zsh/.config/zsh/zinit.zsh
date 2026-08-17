# zinit.zsh — Zinit bootstrap

ZINIT_HOME="${ZINIT_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/zinit}"
ZINIT_BIN="${ZINIT_HOME}/zinit.git/zinit.zsh"

if [[ ! -f "$ZINIT_BIN" ]]; then
  print -P "%F{cyan}[zinit]%f bootstrapping…%f"
  command -v git >/dev/null 2>&1 || {
    print -P "%F{red}[zinit]%f git is missing%f"
    return 1
  }

  mkdir -p "$ZINIT_HOME"
  if ! git clone --depth=1 https://github.com/zdharma-continuum/zinit.git \
      "$ZINIT_HOME/zinit.git" 2>/dev/null; then
    print -P "%F{red}[zinit]%f clone failed — check network%f"
    return 1
  fi
  print -P "%F{green}[zinit]%f installed%f"
fi

source "$ZINIT_BIN"

# Load OMZ libs we need (not the whole thing)
zinit snippet OMZL::git.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::theme-and-appearance.zsh
zinit snippet OMZL::async_prompt.zsh

# eza config - must be set BEFORE loading the plugin
zstyle ':omz:plugins:eza' 'dirs-first' yes
zstyle ':omz:plugins:eza' 'git-status' yes
zstyle ':omz:plugins:eza' 'header' yes
zstyle ':omz:plugins:eza' 'icons' yes

# zinit snippets (OMZP) — must be before any plugin that uses them
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::docker
zinit snippet OMZP::eza
zinit snippet OMZP::command-not-found

# zsh plugins (turbo-loaded, no blocking of first prompt)
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

autoload -Uz compinit
compinit
