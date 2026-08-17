# integrations.zsh — shell integrations for installed tools.

# ---------------------------------------------------------------------------
# mise — runtime/version manager
# ---------------------------------------------------------------------------
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# ---------------------------------------------------------------------------
# atuin — shell history
# ---------------------------------------------------------------------------
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh --disable-up-to-date-check)"
fi

# ---------------------------------------------------------------------------
# zoxide — smart cd (`z`)
# ---------------------------------------------------------------------------
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --cmd z)"
fi

# ---------------------------------------------------------------------------
# starship — prompt
# ---------------------------------------------------------------------------
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# ---------------------------------------------------------------------------
# fzf — key bindings
# ---------------------------------------------------------------------------
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)" 2>/dev/null
fi
