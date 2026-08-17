# --- General Options ---
setopt AUTO_CD              # cd by typing folder name
setopt INTERACTIVE_COMMENTS # Allow inline comments
setopt NO_BEEP              # Mute terminal bell
setopt EXTENDED_GLOB        # Enable extended globbing patterns
setopt GLOB_DOTS            # Match hidden dotfiles

# --- History Options ---
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"
HISTSIZE=50000
SAVEHIST=50000

setopt HIST_EXPIRE_DUPS_FIRST # Purge oldest duplicates first
setopt HIST_IGNORE_DUPS       # Skip duplicate commands in sequence
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicates
setopt HIST_FIND_NO_DUPS      # Don't show duplicates when searching
setopt HIST_IGNORE_SPACE      # Ignore commands starting with a space
setopt HIST_SAVE_NO_DUPS      # Save unique commands only
setopt HIST_REDUCE_BLANKS     # Trim extra whitespace
setopt HIST_VERIFY            # Review expanded history before running
setopt INC_APPEND_HISTORY     # Save history immediately
setopt SHARE_HISTORY          # Share history across sessions
