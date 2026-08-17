[[ -o interactive ]] || return 0

ZSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

source "${ZSH_CONFIG_DIR}/options.zsh"
source "${ZSH_CONFIG_DIR}/plugins.zsh"
source "${ZSH_CONFIG_DIR}/completion.zsh"
source "${ZSH_CONFIG_DIR}/keybindings.zsh"
source "${ZSH_CONFIG_DIR}/aliases.zsh"
source "${ZSH_CONFIG_DIR}/functions.zsh"
source "${ZSH_CONFIG_DIR}/integrations.zsh"
