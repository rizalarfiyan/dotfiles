# .zshrc — thin entry point for interactive shells.
#
# All real configuration lives in ~/.config/zsh/*.zsh, sourced in a strict,
# deterministic order. This file stays small so startup is easy to reason about.
#
# Startup order:
#   .zshenv  → (every shell) XDG base dirs
#   .zshrc   → (interactive) zsh init, this file
#     └─ zinit.zsh         first: plugin manager bootstrap + turbo plugin decls
#     └─ path.zsh          PATH management (single method)
#     └─ options.zsh       zsh options (history offloaded to atuin)
#     └─ env.zsh           environment variables
#     └─ aliases.zsh       aliases
#     └─ functions.zsh     helper functions
#     └─ keybindings.zsh   key mappings
#     └─ completions.zsh   completion tuning + fzf-tab styling
#     └─ integrations.zsh  tool evals (mise/atuin/zoxide/fzf) — last
#
# PERFORMANCE:
#   - Local modules are tiny (microseconds) → sourced synchronously.
#     No async race: PATH/aliases must exist before the first command.
#   - Plugins (completions, autosuggestions, syntax-highlighting, fzf-tab)
#     are TURBO-loaded by zinit.zsh and never block the first prompt.
#   - Every eval in integrations.zsh is guarded by `command -v` → ~0ms
#     cost for missing tools.


# ---------------------------------------------------------------------------
# Only for interactive shells
# ---------------------------------------------------------------------------
[[ -o interactive ]] || return 0

# ---------------------------------------------------------------------------
# Locale — before anything that could output non-ASCII
# ---------------------------------------------------------------------------
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-${LANG}}"

# ---------------------------------------------------------------------------
# Plugin manager — MUST be first (defines zinit, self-heals bootstrap).
# ---------------------------------------------------------------------------
ZSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

if [[ -f "${ZSH_CONFIG_DIR}/zinit.zsh" ]]; then
  source "${ZSH_CONFIG_DIR}/zinit.zsh"
else
  print -P "%F{red}[zsh]%f zinit.zsh missing%f"
  PS1='%F{red}%n@%m%f:%F{blue}%~%f%# '
fi

source "${ZSH_CONFIG_DIR}/path.zsh"
source "${ZSH_CONFIG_DIR}/options.zsh"
source "${ZSH_CONFIG_DIR}/env.zsh"
source "${ZSH_CONFIG_DIR}/aliases.zsh"
source "${ZSH_CONFIG_DIR}/functions.zsh"
source "${ZSH_CONFIG_DIR}/keybindings.zsh"
source "${ZSH_CONFIG_DIR}/completions.zsh"
source "${ZSH_CONFIG_DIR}/integrations.zsh"
