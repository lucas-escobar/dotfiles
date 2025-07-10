# omz config
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode reminder 
zstyle ':omz:update' frequency 13
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy/mm/dd"
ZSH_THEME="candy"
plugins=(git vi-mode web-search)

ZSH_CACHE="$HOME/.cache/zsh/"
if [[ ! -d $ZSH_CACHE ]]; then
  mkdir -p $ZSH_CACHE 
fi
ZSH_COMPDUMP="$ZSH_CACHE/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
HISTFILE="$ZSH_CACHE/zsh_history"
source $ZSH/oh-my-zsh.sh

# user config 
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
  export VISUAL='nvim'
else
  export EDITOR='nvim'
  export VISUAL='nvim'
fi

# Aliases (run "alias" to see all active aliases)
if [ "$OSTYPE" != linux-gnu ]; then  # Is this the macOS system?
    alias ls=gls
fi

alias .='alacritty --working-directory=$(pwd) & disown'
alias l="ls -lahv --color --group-directories-first"
alias ll="ls -lhv --color --group-directories-first"
alias vi="nvim -d"
alias vim="nvim -d"
alias nvim="nvim -d"
alias py="python"
alias ve='python3 -m venv ./.venv'
alias va='source ./.venv/bin/activate'
alias scaf='python3 -m scaffold'

# Add to path for MacOS
export PATH="/usr/local/lib/node_modules/:$PATH"
export PATH="$HOME/.deno/bin/:$PATH"

# flatpak path 
export PATH="~/.local/bin:~/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:$PATH"

# Add rust to path
export PATH="$HOME/.cargo/bin:$PATH"

# Add go to path 
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export PATH=$HOME/dev/flutter/bin:$PATH
