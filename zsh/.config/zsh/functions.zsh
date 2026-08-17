# # ---------------------------------------------------------------------------
# # Quick directory navigation
# # ---------------------------------------------------------------------------
# mkcd() {
#   mkdir -p -- "$1" && cd -- "$1"
# }

# # ---------------------------------------------------------------------------
# # Tmux session helpers
# # ---------------------------------------------------------------------------
# ta() {  # attach-or-create session
#   local session="${1:-$(basename "$PWD")}"
#   if [[ -n "${TMUX:-}" ]]; then
#     tmux switch-client -t "$session" 2>/dev/null || tmux new-session -d -s "$session" -c "$PWD" && tmux switch-client -t "$session"
#   else
#     tmux attach -t "$session" 2>/dev/null || tmux new-session -A -s "$session" -c "$PWD"
#   fi
# }

# tm() { tmux list-sessions 2>/dev/null | sed 's/:.*//' | fzf --prompt="session> " | xargs -r tmux attach -t; } 2>/dev/null || true

# # ---------------------------------------------------------------------------
# # PATH inspection helper (works with the path.zsh system)
# # ---------------------------------------------------------------------------
# showpath() {
#   # print numbered PATH entries — complements add_to_path/append_to_path
#   local -a entries=("${(@s/:/)PATH}")
#   local i
#   for (( i = 1; i <= ${#entries}; i++ )); do
#     printf '%2d: %s\n' "$i" "${entries[$i]}"
#   done
# }

# # ---------------------------------------------------------------------------
# # Grab an IP/port from a Docker/Podman container quickly
# # ---------------------------------------------------------------------------
# port() {
#   sudo ss -tlnp 2>/dev/null | grep -E "(${1:-LISTEN})" | column -t
# }

# # ---------------------------------------------------------------------------
# # Dotfiles management shortcuts
# # ---------------------------------------------------------------------------
# dotfiles() { cd "${HOME}/dotfiles" || return 1; }

# up() {
#   # update everything: pacman + mise-installed toolchains + atuin sync
#   sudo pacman -Syu --noconfirm
#   if command -v mise >/dev/null 2>&1; then
#     mise upgrade --all
#   fi
#   if command -v atuin >/dev/null 2>&1; then
#     atuin sync
#   fi
# }

# # ---------------------------------------------------------------------------
# # Extract any archive
# # ---------------------------------------------------------------------------
# extract() {
#   [[ -f "$1" ]] || { echo "error: '$1' is not a valid file" >&2; return 1; }
#   case "$1" in
#     *.tar.bz2)  tar xjf "$1" ;;
#     *.tar.gz)   tar xzf "$1" ;;
#     *.tar.xz)   tar xJf "$1" ;;
#     *.tar)      tar xf "$1" ;;
#     *.tbz2)     tar xjf "$1" ;;
#     *.tgz)      tar xzf "$1" ;;
#     *.zip)      unzip "$1" ;;
#     *.7z)       7z x "$1" ;;
#     *.rar)      unrar x "$1" ;;
#     *.gz)       gunzip "$1" ;;
#     *.bz2)      bunzip2 "$1" ;;
#     *.xz)       unxz "$1" ;;
#     *.zst)      unzstd "$1" ;;
#     *)          echo "error: unknown archive type: '$1'" >&2; return 1 ;;
#   esac
# }

# # ---------------------------------------------------------------------------
# # Notes / scratch
# # ---------------------------------------------------------------------------
# notes() {
#   local notes_dir="${XDG_DATA_HOME:-$HOME/.local/share}/notes"
#   mkdir -p "$notes_dir"
#   "${EDITOR:-nvim}" "$notes_dir/$(date +%Y-%m-%d).md"
# }

# # ---------------------------------------------------------------------------
# # Search & replace helper (rg-based, safe)
# # ---------------------------------------------------------------------------
# replace() {
#   # replace <pattern> <replacement> [paths...]
#   local pattern="$1" replacement="$2"
#   shift 2 || true
#   if [[ -z "$replacement" ]]; then
#     echo "error: replacement cannot be empty" >&2
#     return 1
#   fi
#   rg -l --hidden --glob '!.git' "$pattern" "$@" | xargs -r sed -i "s/${pattern}/${replacement}/g"
# }

# # ---------------------------------------------------------------------------
# # zoxide interop — `cd` already is zoxide-aware (--cmd cd in integrations).
# # These helpers are optional conveniences for muscle-memory users.
# # ---------------------------------------------------------------------------
# zqi() {  # "z q uick i nspect": show zoxide ranking for an arg
#   if command -v zoxide >/dev/null 2>&1; then
#     zoxide query -l "$@"
#   else
#     echo "zoxide not installed" >&2
#     return 1
#   fi
# }
