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

# Tab-autocomplete enhancements
autoload -Uz compinit && compinit

# Setup fzf-tab preview
zstyle ':fzf-tab:complete:*' fzf-preview '
if [ -d "$realpath" ]; then
  eza -1 --group-directories-first --icons --color=always "$realpath"
else
  bat --color=always --style=plain --paging=never --line-range=:200 "$realpath"
fi
'
zstyle ':fzf-tab:*' fzf-flags --bind=tab:accept

# Plugins
source ~/.local/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# user config
#if [[ -n $SSH_CONNECTION ]]; then
#  export EDITOR='nvim'
#  export VISUAL='nvim'
#else
#  export EDITOR='nvim'
#  export VISUAL='nvim'
#fi
#
## Aliases (run "alias" to see all active aliases)
#if [ "$OSTYPE" != linux-gnu ]; then  # Is this the macOS system?
#    alias ls=gls
#fi
#
#alias .='alacritty --working-directory=$(pwd) & disown'
#
#alias l='ls -v --color --group-directories-first'
#alias ll='ls -lahv --group-directories-first --color=always'
##alias l="ls -lahv --color --group-directories-first"
##alias ll="ls -lhv --color --group-directories-first"
#alias vi="nvim -d"
#alias vim="nvim -d"
#alias nvim="nvim -d"
#alias py="python"
#alias ve='python3 -m venv ./.venv'
#alias va='source ./.venv/bin/activate'
#alias scaf='python3 -m scaffold'
#
## Add to path for MacOS
#export PATH="/usr/local/lib/node_modules/:$PATH"
#export PATH="$HOME/.deno/bin/:$PATH"
#
## flatpak path
#export PATH="~/.local/bin:~/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:$PATH"
#
## Add rust to path
#export PATH="$HOME/.cargo/bin:$PATH"
#
## Add go to path
#export GOPATH="$HOME/go"
#export PATH="$PATH:$GOPATH/bin"
#export PATH=$HOME/dev/flutter/bin:$PATH
#
#
## fuzzy search files and open in $EDITOR
#ff() {
#  local file
#  file=$(fd . | fzf) || return
#  $EDITOR "$file"
#}
#
## fuzzy search inside files by content
#fg() {
#  rg --no-heading --line-number "$1" |
#    fzf --delimiter : --with-nth=1,2,3 |
#    awk -F: '{print "+"$2" "$1}' |
#    xargs -r $EDITOR
#}
#
## fuzzy directory jump
#fdc() {
#  local dir
#  dir=$(fd -t d . | fzf) || return
#  cd "$dir"
#}
#
#
## Print file extension type counts (optionally for a given path)
#nlang() {
#  local PATH_ARG="${1:-.}"
#
#  local BOLD=$(tput bold)
#  local COLOR=$(tput setaf 5)
#  local RESET=$(tput sgr0)
#
#  fd -t f . "$PATH_ARG" \
#    | awk -F. '
#        NF>1 { ext=$NF; files[ext]++; total++ }
#        END {
#          for (e in files)
#            printf "%s %d %.2f%%\n", e, files[e], (files[e]/total*100)
#        }' \
#    | sort -k2 -nr \
#    | awk -v H="${BOLD}${COLOR}" -v R="$RESET" '
#        BEGIN {
#          printf "%s%-8s %-8s %-8s%s\n", H, "ext", "files", "percent", R
#        }
#        { printf "%-8s %-8s %-8s\n", $1, $2, $3 }
#      ' \
#    | column -t
#}
#
#fsize() {
#  local DIR="${1:-.}"
#
#  local BOLD=$(tput bold)
#  local COLOR=$(tput setaf 5)
#  local RESET=$(tput sgr0)
#
#  local total_bytes
#  total_bytes=$(fd -t f . "$DIR" -x stat --printf="%s\n" 2>/dev/null | awk '{sum+=$1} END{print sum}')
#
#  fd -t f . "$DIR" -x stat --printf="%s\t%n\n" 2>/dev/null \
#    | sort -nr \
#    | head -30 \
#    | awk -F'\t' -v total="$total_bytes" -v H="${BOLD}${COLOR}" -v R="${RESET}" '
#        function human(x) {
#          if(x>=1099511627776){return sprintf("%.1fT", x/1099511624)}
#          else if(x>=1073741824){return sprintf("%.1fG", x/1073741824)}
#          else if(x>=1048576){return sprintf("%.1fM", x/1048576)}
#          else if(x>=1024){return sprintf("%.1fK", x/1024)}
#          else {return x "B"}
#        }
#        BEGIN { printf "%s%-8s %-8s %s%s\n", H, "size", "percent", "path", R }
#        { pct = $1/total*100; print human($1), sprintf("%.2f%%", pct), $2 }
#      ' | column -t
#}
#
#dsize() {
#  local DIR="${1:-.}"
#  local BOLD=$(tput bold)
#  local COLOR=$(tput setaf 5)
#  local RESET=$(tput sgr0)
#
#  local total
#  total=$(du -sb "$DIR"/*/ 2>/dev/null | awk '{sum+=$1} END{print sum}')
#
#  du -sh "$DIR"/*/ 2>/dev/null \
#    | sort -hr \
#    | head -30 \
#    | awk -v total="$total" -v H="${BOLD}${COLOR}" -v R="$RESET" '
#        BEGIN { printf "%s%-8s %-8s %s%s\n", H, "size", "percent", "path", R }
#        {
#          cmd="du -sb \"" $2 "\""
#          cmd | getline bytes
#          close(cmd)
#          sub(/\t.*/, "", bytes)
#          pct = bytes / total * 100
#          print $1, sprintf("%.2f%%", pct), $2
#        }
#      ' | column -t
#}
#
#loc() {
#  local DIR="${1:-.}"
#
#  local BOLD=$(tput bold)
#  local COLOR=$(tput setaf 5)
#  local RESET=$(tput sgr0)
#
#  local total_lines
#  total_lines=$(rg --files "$DIR" | xargs wc -l 2>/dev/null | awk 'END{print $1}')
#
#  rg --files "$DIR" \
#    | xargs wc -l 2>/dev/null \
#    | sort -nr \
#    | head -30 \
#    | awk -v total="$total_lines" -v H="${BOLD}${COLOR}" -v R="${RESET}" '
#        BEGIN { printf "%s%s\t%s\t%s%s\n", H, "lines", "percent", "path", R }
#        {
#          if(NR==1 && $2=="total") next
#          pct = $1 / total * 100
#          printf "%d\t%.2f%%\t%s\n", $1, pct, $2
#        }
#      ' | column -t
#}
#
#todo() {
#  local DIR="${1:-.}"
#
#  # Get all TODO/FIXME lines, capture text after the keyword
#  local TODOS
#  TODOS=$(rg --no-heading --line-number --color=never \
#      --replace '$1' '.*(?:TODO|FIXME)\s*(.*)' "$DIR")
#
#  [[ -z "$TODOS" ]] && echo "No TODOs found." && return
#
#  # FZF selection with preview
#  local selection
#  selection=$(echo "$TODOS" | fzf --ansi \
#    --preview 'file=$(echo {} | awk -F: "{print \$1}"); line=$(echo {} | awk -F: "{print \$2}"); bat --style=numbers --color=always --line-range ${line}: "$file"' \
#    --preview-window=up:60%)
#
#  if [[ -n "$selection" ]]; then
#    local file=$(echo "$selection" | awk -F: '{print $1}')
#    local line=$(echo "$selection" | awk -F: '{print $2}')
#    $EDITOR +$line "$file"
#  fi
#}
#
#
#rust_structs() {
#  rg -n --no-heading -e '^[[:space:]]*(pub[[:space:]]+)?struct[[:space:]]+[A-Za-z_][A-Za-z0-9_]*' "$@"
#}
#
#
## find enums
#rust_enums() {
#  rg -n "enum\s+[A-Za-z0-9_]+" src
#}
#
## find traits
#rust_traits() {
#  rg -n "trait\s+[A-Za-z0-9_]+" src
#}
#
## find function definitions
#rust_fns() {
#  rg -n "fn\s+[A-Za-z0-9_]+" src
#}
#
## fuzzy open a Rust symbol definition
#rsym() {
#  rg --no-heading --line-number "$1" src |
#    fzf |
#    awk -F: '{print "+"$2" "$1}' |
#    xargs -r $EDITOR
#}
