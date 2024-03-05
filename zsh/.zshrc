export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="candy"

zstyle ':omz:update' mode reminder 
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy/mm/dd"

plugins=(git zsh-autosuggestions vi-mode web-search)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Aliases (run "alias" to see all active aliases)
alias l="ls -lahv --color --group-directories-first"
alias ll="ls -lhv --color --group-directories-first"

alias .='alacritty --working-directory=$(pwd) & disown'

alias vi="nvim -d"
alias vim="nvim -d"
alias nvim="nvim -d"

alias py="python"
alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'

# Add to path for MacOS
export PATH="/usr/local/lib/node_modules/:$PATH"

# TODO: change perl paths
PATH="/home/zarath/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/zarath/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/zarath/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/zarath/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/zarath/perl5"; export PERL_MM_OPT;
