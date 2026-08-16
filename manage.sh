#!/usr/bin/env bash
#
# GNU Stow dotfiles manager supporting all, single, and multiple packages.
#

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${HOME}"

# Directories/files to strictly ignore when scanning for packages
IGNORED_DIRS=(".git" ".github" ".vscode" "docs" "scripts")

# Styling
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

log_info()    { printf "${BLUE}[INFO]${NC} %s\n" "$*"; }
log_success() { printf "${GREEN}[OK]${NC} %s\n" "$*"; }
log_warn()    { printf "${YELLOW}[WARN]${NC} %s\n" "$*"; }
log_error()   { printf "${RED}[ERR]${NC} %s\n" "$*" >&2; }

# Verify required dependencies
check_deps() {
  if ! command -v stow >/dev/null 2>&1; then
    log_error "GNU Stow is not installed. Run: sudo pacman -S stow"
    exit 1
  fi
}

# Auto-discover valid package directories in dotfiles root
get_all_packages() {
  local packages=()
  for dir in "${DOTFILES_DIR}"/*/; do
    [[ -d "$dir" ]] || continue
    local pkg_name
    pkg_name="$(basename "$dir")"
    
    # Check against ignore list
    local skip=0
    for ignored in "${IGNORED_DIRS[@]}"; do
      if [[ "$pkg_name" == "$ignored" ]]; then
        skip=1
        break
      fi
    done

    [[ $skip -eq 0 ]] && packages+=("$pkg_name")
  done
  echo "${packages[@]}"
}

# Pre-create target base directories to avoid linking top-level directories as monolithic symlinks
setup_directories() {
  mkdir -p "${TARGET_DIR}/.config" \
           "${TARGET_DIR}/.local/bin" \
           "${TARGET_DIR}/.local/share" \
           "${TARGET_DIR}/.local/state" \
           "${TARGET_DIR}/.ssh"
  chmod 700 "${TARGET_DIR}/.ssh"
}

show_usage() {
  cat <<EOF
${BOLD}Usage:${NC} $(basename "$0") <ACTION> [PACKAGES...]

${BOLD}Actions:${NC}
  stow, install       Link packages (default)
  restow, sync        Re-link packages (after adding/renaming files)
  delete, unlink      Remove package symlinks
  adopt               Adopt existing target files into repo and link
  list                List all available package directories
  help, -h, --help    Show this message

${BOLD}Package Targeting:${NC}
  all                 Process every available package directory
  <pkg>               Process a single package (e.g. zsh)
  <p1> <p2> ...       Process multiple packages (e.g. zsh nvim git)

${BOLD}Examples:${NC}
  $(basename "$0") stow all
  $(basename "$0") restow zsh
  $(basename "$0") delete git tmux
  $(basename "$0") adopt zsh nvim
EOF
}

main() {
  check_deps

  if [[ $# -eq 0 ]]; then
    show_usage
    exit 1
  fi

  local action="$1"
  shift || true

  # Handle help/list without requiring packages
  case "$action" in
    help|--help|-h)
      show_usage
      exit 0
      ;;
    list)
      log_info "Available packages in ${DOTFILES_DIR}:"
      for pkg in $(get_all_packages); do
        printf "  - %s\n" "$pkg"
      done
      exit 0
      ;;
  esac

  # Build stow flags based on action
  local flags=("-v" "-t" "${TARGET_DIR}")
  local need_dirs=1

  case "$action" in
    stow|install)
      ;;
    restow|sync)
      flags+=("-R")
      ;;
    delete|unlink)
      flags+=("-D")
      need_dirs=0
      ;;
    adopt)
      flags+=("--adopt")
      log_warn "Adopting target files from ${TARGET_DIR} into ${DOTFILES_DIR}..."
      ;;
    *)
      log_error "Unknown action: '$action'"
      show_usage
      exit 1
      ;;
  esac

  # Determine target packages
  local target_packages=()
  if [[ $# -eq 0 ]] || [[ "$1" == "all" ]]; then
    read -r -a target_packages <<< "$(get_all_packages)"
  else
    target_packages=("$@")
  fi

  [[ $need_dirs -eq 1 ]] && setup_directories

  cd "${DOTFILES_DIR}"

  log_info "Running '${action}' on [${target_packages[*]}]..."
  for pkg in "${target_packages[@]}"; do
    if [[ -d "${DOTFILES_DIR}/${pkg}" ]]; then
      log_info "Processing: ${pkg}"
      stow "${flags[@]}" "${pkg}"
    else
      log_error "Package directory '${pkg}' does not exist inside ${DOTFILES_DIR}!"
    fi
  done

  log_success "Finished '${action}' operation."
}

main "$@"