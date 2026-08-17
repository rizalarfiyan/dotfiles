# options.zsh — zsh options and history configuration.

# ---------------------------------------------------------------------------
# History (fallback only — atuin is primary)
# ---------------------------------------------------------------------------
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=2000
SAVEHIST=2000

setopt EXTENDED_HISTORY          # record timestamp + duration
setopt HIST_EXPIRE_DUPS_FIRST    # expire duplicate entries first
setopt HIST_IGNORE_DUPS          # don't record duplicates in a row
setopt HIST_IGNORE_ALL_DUPS      # delete old duplicate from history
setopt HIST_FIND_NO_DUPS         # don't show duplicates when searching
setopt HIST_REDUCE_BLANKS        # trim superfluous blanks
setopt HIST_VERIFY               # don't execute immediately on recall
setopt INC_APPEND_HISTORY        # write after each command (fallback)
setopt HIST_NO_STORE             # don't store history commands themselves
# NOTE: SHARE_HISTORY is intentionally OFF — atuin syncs sessions instead.
# NOTE: sharehistory would also break INC_APPEND_HISTORY semantics.

# ---------------------------------------------------------------------------
# Changing directories
# ---------------------------------------------------------------------------
setopt AUTO_CD                  # cd to a dir by typing its name
setopt AUTO_PUSHD               # push old dir automatically
setopt PUSHD_IGNORE_DUPS        # don't push duplicates
setopt PUSHD_SILENT             # don't print dir stack after pushd
setopt CDABLE_VARS              # cd to a directory stored in a variable

# ---------------------------------------------------------------------------
# Input / Completion
# ---------------------------------------------------------------------------
setopt COMPLETE_IN_WORD         # complete from both ends of the word
setopt ALWAYS_TO_END            # move cursor to end after completion
setopt AUTO_MENU                # show completion menu on successive tab
setopt AUTO_PARAM_KEYS          # intelligently handle =, :, etc.
setopt AUTO_REMOVE_SLASH        # remove trailing slash in completions
setopt GLOB_COMPLETE            # tab expands globs
setopt NO_BEEP                  # silence beeps
setopt NO_FLOW_CONTROL          # disable ^S/^Q (allows ^S for search)

# ---------------------------------------------------------------------------
# Jobs
# ---------------------------------------------------------------------------
setopt AUTO_CONTINUE            # send SIGCONT to suspended jobs on disown
setopt LONG_LIST_JOBS           # show PID in job listings
setopt NOTIFY                   # report job status immediately

# ---------------------------------------------------------------------------
# Prompt & misc
# ---------------------------------------------------------------------------
setopt PROMPT_SUBST             # allow command substitution in prompt
setopt TRANSIENT_RPROMPT        # remove right prompt after command
setopt INTERACTIVE_COMMENTS     # allow comments in interactive shell
setopt NO_HUP                   # don't kill jobs when shell exits