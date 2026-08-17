# --- XDG Base Directories ---
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# --- Locale & Terminal Environment ---
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="en_US.UTF-8"
export COLORTERM="${COLORTERM:-truecolor}"
export TERM="${TERM:-xterm-256color}"

# --- Editors ---
export EDITOR="nano"
export VISUAL="${VISUAL:-$EDITOR}"
export SYSTEMD_EDITOR="${VISUAL}"

# --- Pagers & History ---
export PAGER="${PAGER:-less}"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESSHISTFILE="${XDG_STATE_HOME}/less/history"
export HISTFILE="${XDG_STATE_HOME}/zsh/history"

# --- Language Runtimes & Dev Tooling ---
export MISE_DATA_DIR="${MISE_DATA_DIR:-$XDG_DATA_HOME/mise}"
export MISE_CACHE_DIR="${MISE_CACHE_DIR:-$XDG_CACHE_HOME/mise}"

export NODE_REPL_HISTORY="${XDG_STATE_HOME}/node/repl_history"

export GO111MODULE=on
export GOPATH="${GOPATH:-$HOME/go}"
export GOBIN="${GOPATH}/bin"
export GOMODCACHE="${XDG_CACHE_HOME}/go/mod"

export CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-$HOME/.rustup}"

# --- App Config Paths ---
export BAT_THEME="${BAT_THEME:-ansi}"
export BAT_STYLE="${BAT_STYLE:-numbers,changes,header}"
export EZA_CONFIG_DIR="${XDG_CONFIG_HOME}/eza"
export EZA_COLORS="di=38;5;75:ln=38;5;215:ex=38;5;120"
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/ripgrep.conf"
export YAZI_CONFIG_HOME="${XDG_CONFIG_HOME}/yazi"
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"

# --- Path Construction ---
typeset -U path PATH
path=(
  "$HOME/.local/bin"
  "$HOME/bin"
  "$GOBIN"
  "$CARGO_HOME/bin"
  $path
)

export PATH
