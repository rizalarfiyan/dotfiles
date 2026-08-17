# env.zsh — environment variables (persisted, tool-agnostic)

# ---------------------------------------------------------------------------
# Editors — fall back gracefully if nvim isn't installed yet
# ---------------------------------------------------------------------------
if command -v nvim >/dev/null 2>&1; then
  export EDITOR="${EDITOR:-nvim}"
elif command -v vim >/dev/null 2>&1; then
  export EDITOR="${EDITOR:-vim}"
else
  export EDITOR="${EDITOR:-vi}"
fi
export VISUAL="${VISUAL:-$EDITOR}"
export SYSTEMD_EDITOR="${VISUAL}"

# ---------------------------------------------------------------------------
# Pager & man
# ---------------------------------------------------------------------------
export PAGER="${PAGER:-less}"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# ---------------------------------------------------------------------------
# Terminal / color
# ---------------------------------------------------------------------------
export COLORTERM="${COLORTERM:-truecolor}"
export TERM="${TERM:-xterm-256color}"

# ---------------------------------------------------------------------------
# Locale (already set in .zshrc, but ensure it's exported here for scripts)
# ---------------------------------------------------------------------------
export LANG="${LANG:-en_US.UTF-8}"

# ---------------------------------------------------------------------------
# fzf
# ---------------------------------------------------------------------------
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"

# Setup fzf previews
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"

# fzf preview for tmux
export FZF_TMUX_OPTS=" -p90%,70% "

# ---------------------------------------------------------------------------
# bat
# ---------------------------------------------------------------------------
export BAT_THEME="${BAT_THEME:-ansi}"
export BAT_STYLE="${BAT_STYLE:-numbers,changes,header}"

# ---------------------------------------------------------------------------
# eza
# ---------------------------------------------------------------------------
export EZA_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/eza"
export EZA_COLORS="di=38;5;75:ln=38;5;215:ex=38;5;120"

# ---------------------------------------------------------------------------
# ripgrep
# ---------------------------------------------------------------------------
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/ripgrep/ripgrep.conf"

# ---------------------------------------------------------------------------
# yazi
# ---------------------------------------------------------------------------
export YAZI_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/yazi"

# ---------------------------------------------------------------------------
# mise
# ---------------------------------------------------------------------------
export MISE_DATA_DIR="${MISE_DATA_DIR:-$XDG_DATA_HOME/mise}"
export MISE_CACHE_DIR="${MISE_CACHE_DIR:-$XDG_CACHE_HOME/mise}"

# ---------------------------------------------------------------------------
# node (via mise — avoid nvm-style shims pollution)
# ---------------------------------------------------------------------------
export NODE_REPL_HISTORY="${XDG_STATE_HOME:-$HOME/.local/state}/node/repl_history"

# ---------------------------------------------------------------------------
# golang
# ---------------------------------------------------------------------------
export GO111MODULE=on
export GOPATH="${GOPATH:-$HOME/go}"
export GOBIN="${GOPATH}/bin"
export GOMODCACHE="${XDG_CACHE_HOME:-$HOME/.cache}/go/mod"

# ---------------------------------------------------------------------------
# misc XDG-ified tools
# ---------------------------------------------------------------------------
export LESSHISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/less/history"
export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
export CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-$HOME/.rustup}"
