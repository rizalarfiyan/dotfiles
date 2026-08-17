ZINIT_HOME="${ZINIT_HOME:-${XDG_DATA_HOME}/zinit}"
ZINIT_BIN="${ZINIT_HOME}/zinit.git/zinit.zsh"

if [[ ! -f "$ZINIT_BIN" ]]; then
  print -P "%F{cyan}[zinit]%f bootstrapping…%f"
  command -v git >/dev/null 2>&1 || {
    print -P "%F{red}[zinit]%f git is missing%f"
    return 1
  }

  mkdir -p "$ZINIT_HOME"
  if ! git clone --depth=1 https://github.com/zdharma-continuum/zinit.git \
      "$ZINIT_HOME/zinit.git" 2>/dev/null; then
    print -P "%F{red}[zinit]%f clone failed — check network%f"
    return 1
  fi

  print -P "%F{green}[zinit]%f installed%f"
fi

source "$ZINIT_BIN"

# --- OMZ Core Libraries ---
zinit snippet OMZL::history.zsh
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::clipboard.zsh
zinit snippet OMZL::git.zsh
zinit snippet OMZL::key-bindings.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::async_prompt.zsh

zinit snippet https://github.com/mroth/evalcache/blob/master/evalcache.plugin.zsh

# --- eza OMZ Plugin Config ---
zstyle ':omz:plugins:eza' 'dirs-first' yes
zstyle ':omz:plugins:eza' 'git-status' yes
zstyle ':omz:plugins:eza' 'header' yes
zstyle ':omz:plugins:eza' 'icons' yes

# --- OMZ Plugins ---
zinit snippet OMZP::git
zinit snippet OMZP::eza
zinit snippet OMZP::direnv
zinit snippet OMZP::command-not-found

zinit wait lucid as"completion" for \
  OMZP::docker/completions/_docker \
  OMZP::golang \
  OMZP::bun \
  OMZP::npm \
  OMZP::yarn

# Autosuggestions Tuning
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# --- Turbo-Loaded Plugins ---
zinit wait lucid blockf for \
    zsh-users/zsh-completions

zinit wait lucid atload"_zsh_autosuggest_start" for \
    zsh-users/zsh-autosuggestions

zinit wait"1" lucid atinit"zicompinit; zicdreplay" for \
    zsh-users/zsh-syntax-highlighting \
    Aloxaf/fzf-tab
