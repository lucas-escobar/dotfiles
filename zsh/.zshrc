# omz config
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode reminder 
zstyle ':omz:update' frequency 13
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy/mm/dd"
ZSH_THEME="candy"
plugins=(git vi-mode web-search)
source $ZSH/oh-my-zsh.sh

# user config 
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
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

# Add to path for MacOS
export PATH="/usr/local/lib/node_modules/:$PATH"

# flatpak path 
export PATH="~/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:$PATH"

# TODO: change perl paths
PATH="/home/zarath/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/zarath/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/zarath/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/zarath/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/zarath/perl5"; export PERL_MM_OPT;
