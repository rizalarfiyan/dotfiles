# path.zsh — THE single method for managing $PATH.

typeset -gU path
export PATH

add_to_path() {
  local -a to_add=()
  local dir
  for dir in "$@"; do
    [[ -z "$dir" ]] && continue
    dir="${dir:A}"
    [[ -d "$dir" ]] || continue
    to_add+=("$dir")
  done
  [[ ${#to_add[@]} -eq 0 ]] && return
  path=("${to_add[@]}" "${path[@]}")
}

append_to_path() {
  local dir
  for dir in "$@"; do
    [[ -z "$dir" ]] && continue
    dir="${dir:A}"
    [[ -d "$dir" ]] || continue
    path+=("$dir")
  done
}

# ---------------------------------------------------------------------------
# Base user directories — highest priority
# ---------------------------------------------------------------------------
add_to_path \
  "${XDG_BIN_HOME:-$HOME/.local/bin}" \
  "$HOME/.cargo/bin" \
  "$HOME/go/bin" \
  "$HOME/.local/share/mise/shims" \
  "$HOME/.local/share/mise/bin"

# ---------------------------------------------------------------------------
# Global PATH entries — appended so system defaults keep their order
# ---------------------------------------------------------------------------
append_to_path \
  "/usr/local/sbin" \
  "/usr/local/bin" \
  "/usr/bin"