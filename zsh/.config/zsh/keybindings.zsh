bindkey -e

# ---------------------------------------------------------------------------
# Autosuggestions — accept with Ctrl+Space (Ctrl+E stays end-of-line)
# ---------------------------------------------------------------------------
bindkey '^ ' autosuggest-accept          # Ctrl+Space: accept suggestion

# ---------------------------------------------------------------------------
# Word navigation (emacs defaults, explicit)
# ---------------------------------------------------------------------------
bindkey '^W' backward-kill-word           # Ctrl+W: kill word back
bindkey '^U' backward-kill-line           # Ctrl+U: kill whole line
bindkey '^K' kill-line                    # Ctrl+K: kill to end
bindkey '^A' beginning-of-line            # Ctrl+A: home
bindkey '^E' end-of-line                  # Ctrl+E: end of line

# ---------------------------------------------------------------------------
# Misc ergonomics
# ---------------------------------------------------------------------------
bindkey '^[[1;5C' forward-word              # Ctrl+Right: next word
bindkey '^[[1;5D' backward-word             # Ctrl+Left:  previous word
bindkey '^[[3~' delete-char                 # Delete key
