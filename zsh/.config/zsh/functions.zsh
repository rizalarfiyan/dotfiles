# ---------------------------------------------------------------------------
# Quick directory creation and navigation helpers
# ---------------------------------------------------------------------------
function mkcd takedir() {
  mkdir -p $@ && cd ${@:$#}
}

function takeurl() {
  local data thedir
  data="$(mktemp)"
  curl -L "$1" > "$data"
  tar xf "$data"
  thedir="$(tar tf "$data" | head -n 1)"
  rm "$data"
  cd "$thedir"
}

function takezip() {
  local data thedir
  data="$(mktemp)"
  curl -L "$1" > "$data"
  unzip "$data" -d "./"
  thedir="$(unzip -l "$data" | awk 'NR==4 {print $4}' | sed 's/\/.*//')"
  rm "$data"
  cd "$thedir"
}

function takegit() {
  git clone "$1"
  cd "$(basename ${1%%.git})"
}

function take() {
  if [[ $1 =~ ^(https?|ftp).*\.(tar\.(gz|bz2|xz)|tgz)$ ]]; then
    takeurl "$1"
  elif [[ $1 =~ ^(https?|ftp).*\.(zip)$ ]]; then
    takezip "$1"
  elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
    takegit "$1"
  else
    takedir "$@"
  fi
}

# ---------------------------------------------------------------------------
# Tmux session helpers
# ---------------------------------------------------------------------------
ta() {  # attach-or-create session
  local session="${1:-$(basename "$PWD")}"
  if [[ -n "${TMUX:-}" ]]; then
    tmux switch-client -t "$session" 2>/dev/null || tmux new-session -d -s "$session" -c "$PWD" && tmux switch-client -t "$session"
  else
    tmux attach -t "$session" 2>/dev/null || tmux new-session -A -s "$session" -c "$PWD"
  fi
}

tm() { tmux list-sessions 2>/dev/null | sed 's/:.*//' | fzf --prompt="session> " | xargs -r tmux attach -t; } 2>/dev/null || true

# ---------------------------------------------------------------------------
# PATH inspection helper (works with the path.zsh system)
# ---------------------------------------------------------------------------
showpath() {
  # print numbered PATH entries — complements add_to_path/append_to_path
  local -a entries=("${(@s/:/)PATH}")
  local i
  for (( i = 1; i <= ${#entries}; i++ )); do
    printf '%2d: %s\n' "$i" "${entries[$i]}"
  done
}

# ---------------------------------------------------------------------------
# Grab an IP/port from a Docker/Podman container quickly
# ---------------------------------------------------------------------------
port() {
  sudo ss -tlnp 2>/dev/null | grep "${1:-LISTEN}" | column -t
}

# ---------------------------------------------------------------------------
# Dotfiles management shortcuts
# ---------------------------------------------------------------------------
up() {
  sudo pacman -Syu --noconfirm

  if command -v mise >/dev/null 2>&1; then
    mise upgrade
  fi
}

# ---------------------------------------------------------------------------
# Extract any archive
# ---------------------------------------------------------------------------
extract() {
  [[ -f "$1" ]] || { echo "error: '$1' is not a valid file" >&2; return 1; }
  case "$1" in
    *.tar.bz2)  tar xjf "$1" ;;
    *.tar.gz)   tar xzf "$1" ;;
    *.tar.xz)   tar xJf "$1" ;;
    *.tar)      tar xf "$1" ;;
    *.tbz2)     tar xjf "$1" ;;
    *.tgz)      tar xzf "$1" ;;
    *.zip)      unzip "$1" ;;
    *.7z)       7z x "$1" ;;
    *.rar)      unrar x "$1" ;;
    *.gz)       gunzip "$1" ;;
    *.bz2)      bunzip2 "$1" ;;
    *.xz)       unxz "$1" ;;
    *.zst)      unzstd "$1" ;;
    *)          echo "error: unknown archive type: '$1'" >&2; return 1 ;;
  esac
}
