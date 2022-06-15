#  _________  _   _ _____ _     _     
# |__  / ___|| | | | ____| |   | |    
#   / /\___ \| |_| |  _| | |   | |    
#  / /_ ___) |  _  | |___| |___| |___ 
# /____|____/|_| |_|_____|_____|_____|
#                                     
#   ____ ___  _   _ _____ ___ ____ _   _ ____      _  _____ ___ ___  _   _ 
#  / ___/ _ \| \ | |  ___|_ _/ ___| | | |  _ \    / \|_   _|_ _/ _ \| \ | |
# | |  | | | |  \| | |_   | | |  _| | | | |_) |  / _ \ | |  | | | | |  \| |
# | |__| |_| | |\  |  _|  | | |_| | |_| |  _ <  / ___ \| |  | | |_| | |\  |
#  \____\___/|_| \_|_|   |___\____|\___/|_| \_\/_/   \_\_| |___\___/|_| \_|
 
PROMPT_COMMAND='printf "\033]0;%s\007" "${PWD/#$HOME/" ~"}"'
prmptcmd() { eval "$PROMPT_COMMAND" }
precmd_functions=(prmptcmd)


autoload -U colors && colors

# Shell Prompt Customization
PS1="%{$fg[magenta]%}%~%{$reset_color%}%{$fg[yellow]%} $%b "

# Load aliases and shortcuts if existent.
setopt extendedglob
source "$HOME/.config/zsh/aliasrc"
source "$HOME/.config/zsh/dirs"

# Load PyWal Colors
source $HOME/.cache/wal/colors-tty.sh

autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:tw=42;30:ow=43;30' 
zstyle ':completion:*:*:*:*:default' list-dirs-first
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zmodload zsh/complist
compinit

# Include hidden files in autocomplete:
_comp_options+=(globdots)

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

export KEYTIMEOUT=1
export VI_SET_CURSOR true
setopt AUTO_CD

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'underline' ]]; then
    echo -ne '\e[4 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[4 q"
}
zle -N zle-line-init

# Use beam shape cursor on startup.
echo -ne '\e[4 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[4 q' ;}

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lfub -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

bindkey -s '^e' 'lfcd\n'  # zsh
alias lf='lfcd'

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

