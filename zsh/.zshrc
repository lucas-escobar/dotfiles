set -o pipefail

# Prompt
eval "$(starship init zsh)"

# Utility Functions
vol() {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "$1%"
}

# Fetch a gitignore from GitHub gitignore repo
get_gig() {
    local type="$1"
    if [[ -z "$type" ]]; then
        echo "Usage: get_gig <type>"
        return 1
    fi
    local url="https://raw.githubusercontent.com/github/gitignore/main/${type}.gitignore"
    curl -sSf -o .gitignore $url \
        && echo ".gitignore for $type created." \
        || echo "Failed to fetch gitignore for $type at $url"
}

get_lic() {
  set -o pipefail

  local type="$1"
  local fullname="${2:-$GIT_AUTHOR_NAME}"
  local year
  year=$(date +%Y)

  if [[ -z "$fullname" ]]; then
    echo "error: no author name provided and GIT_AUTHOR_NAME not set" >&2
    return 1
  fi

  local url="https://raw.githubusercontent.com/github/choosealicense.com/gh-pages/_licenses/${type}.txt"

  curl -sSf "$url" \
    | sed '1,/^---$/d' \
    | sed '1{/^$/d}' \
    | sed "s/\[year\]/$year/g" \
    | sed "s/\[fullname\]/$fullname/g" \
    > LICENSE
}

# Initialize a new project
init_project() {
    local name="$1"
    local type="$2"      # for gitignore: Python, Node, etc.
    local license="$3"   # MIT, Apache-2.0, etc.
    
    if [[ -z "$name" ]]; then
        echo "Usage: init_project <name> [gitignore-type] [license]"
        return 1
    fi
    
    mkdir -p "$name"
    cd "$name" || return
    
    # Initialize git
    git init
    
    # Fetch gitignore
    if [[ -n "$type" ]]; then
        get_gitignore "$type"
    fi
    
    # Fetch license
    if [[ -n "$license" ]]; then
        get_license "$license"
    fi
    
    # Create README
    touch README.md
    echo "# $name" > README.md
    
    echo "Project $name initialized."
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
