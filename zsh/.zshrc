# Prompt
eval "$(starship init zsh)"

# Utility Functions
vol() {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "$1%"
}

# Aliases
unalias l ll la lt llt lat 2>/dev/null
local common_opts=(--group-directories-first --icons=always --color=always)
l()    { eza "${common_opts[@]}" "$@" | less -rFX }
ll()   { eza -l "${common_opts[@]}" "$@" | less -rFX }
la()   { eza -la "${common_opts[@]}" "$@" | less -rFX }
lt()   { eza --tree --level=2 "${common_opts[@]}" "$@" | less -rFX }
llt()  { eza -l --tree --level=2 "${common_opts[@]}" "$@" | less -rFX }
lat()  { eza -la --tree --level=2 "${common_opts[@]}" "$@" | less -rFX }

eval "$(zoxide init zsh)"
alias cd='z'
alias c='z'
alias ..='z ..'
alias ...='z ../..'
alias rgi='rg -i' 
alias rga='rg -uu' 
alias rgs='rg --stats'
alias cat='bat'
alias cati='bat --plain'
alias du='dust'
alias df='duf'
alias top='btm'
alias ps='procs'
alias cp='rsync -ah --info=progress2'
alias mv='mv -i'
alias rm='rm -i'
alias vi='nvim'
alias vim='nvim'
alias g="git"
alias py="python"

# Path Modification
path=(
    $HOME/bin
    $HOME/.local/bin
    /usr/local/bin
    /usr/local/sbin
    /usr/bin
    /bin
    $path
)
export PATH

# TODO this should change depending on light/dark mode
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
export EZA_COLORS="xx=37;2"

# Tab-autocomplete enhancements (required for fzf-tab)
autoload -Uz compinit && compinit

# fzf-tab config 
zstyle ':fzf-tab:*' fzf-flags --bind=tab:accept
zstyle ':fzf-tab:complete:*' fzf-preview '
if [ -d "$realpath" ]; then
  eza -1 --group-directories-first --icons --color=always "$realpath"
else
  bat --color=always --style=plain --paging=never --line-range=:200 "$realpath"
fi
'

# Plugins
source ~/.local/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
