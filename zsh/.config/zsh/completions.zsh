# completions.zsh — completion tuning.

# ---------------------------------------------------------------------------
# Zstyle basics
# ---------------------------------------------------------------------------
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

zstyle ':completion:*' completer _expand _complete _correct _approximate
# case-insensitive, hyphen/underscore tolerant matching
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=** r:|=**' \
  'l:|=* r:|=*'

zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{cyan}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for: %d%f'
zstyle ':completion:*' verbose yes

# ---------------------------------------------------------------------------
# Kill/process completion
# ---------------------------------------------------------------------------
zstyle ':completion:*:*:kill:*' command 'ps -e -o pid,comm'
zstyle ':completion:*:*:killall:*' command 'ps -e -o comm'

# ---------------------------------------------------------------------------
# Hosts/SSH (avoid slow DNS lookups)
# ---------------------------------------------------------------------------
zstyle ':completion:*:hosts' hosts

# ---------------------------------------------------------------------------
# Correction
# ---------------------------------------------------------------------------
zstyle ':completion:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:options' description 'yes'

# ---------------------------------------------------------------------------
# Man pages
# ---------------------------------------------------------------------------
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
