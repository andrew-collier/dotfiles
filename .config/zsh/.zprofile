#  _____  ____  _   _ _____ _     _     
# |__  / / ___|| | | | ____| |   | |    
#   / /  \___ \| |_| |  _| | |   | |    
#  / /_   ___) |  _  | |___| |___| |___ 
# /____| |____/|_| |_|_____|_____|_____|
#                                       
#  ____  ____   ___  _____ ___ _     _____ 
# |  _ \|  _ \ / _ \|  ___|_ _| |   | ____|
# | |_) | |_) | | | | |_   | || |   |  _|  
# |  __/|  _ <| |_| |  _|  | || |___| |___ 
# |_|   |_| \_\\___/|_|   |___|_____|_____|
 

# Terminal config
setfont ter-p20n
unsetopt PROMPT_SP

# Path
export PATH="$PATH:${$(find $HOME/.local/scripts -type d -printf %p:)%%:}:${$(find $HOME/.local/bin -type d -printf %p:)%%:}"

# Virtual server ssh
eval $(ssh-agent -s)
export KUMO="144.202.82.53"
export BW_SESSION="6SinB1EUInXdTZfHeWPmT+eUj/F4cSIQdcRTG0FdWJ4fu3tMy60w9N16tJ3Q17x6C942XzsjICoL5wrGwdIq4w=="


# Default Programs
export TERMINAL="st"
export EDITOR="vim"
export BROWSER="qutebrowser"
export FILE="lfub"
export MUSICPLAYER="ncmpcpp"

# ~ clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="$HOME/.local/run"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
export VIMINIT='source $MYVIMRC'
export MYVIMRC="${XDG_CONFIG_HOME:-$HOME/.config}/vim/vimrc"
export LESSHISTFILE="-"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export HISTFILE="$XDG_STATE_HOME/bash/history" # .bash_history
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
#gpg2 --homedir "$XDG_DATA_HOME/gnupg"

# lf icons
[ -f "$HOME/.local/share/lf-icons" ] && source "$HOME/.local/share/lf-icons"

# Keyboard setup
sudo -n loadkeys ${XDG_DATA_HOME:-$HOME/.local/share}/ttymaps.kmap 2>/dev/null

# startx automatically on login to TTY1
if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep dwm || startx $XINITRC -- -keeptty >$HOME/.config/x11/xorg.log 2>/dev/null
fi

