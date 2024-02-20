##____  _                      _
#|  _ \| |__   ___   ___ _ __ (_)_  __
#| |_) | '_ \ / _ \ / _ \ '_ \| \ \/ /
#|  __/| | | | (_) |  __/ | | | |>  <
#|_|   |_| |_|\___/ \___|_| |_|_/_/\_\
#
# -*- coding: utf-8 -*-
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"

export HISTCONTROL=ignoreboth:erasedups

plugins=(git )

source $ZSH/oh-my-zsh.sh

command_exist() {
        type "$1" &> /dev/null;
}


# Set your prompt ttheme here I am using starship
command_exist starship && eval "$(starship init zsh)"
command_exist zoxide && eval "$(zoxide init --cmd cd zsh)"
#ZSH_THEME='nord'

# aliases
[ -f $HOME/.config/alias-zsh-bash ] && source $HOME/.config/alias-zsh-bash

# pfetch
# [ -f /usr/bin/pfetch ] && pfetch
[ -f /usr/bin/neofetch ] && neofetch

alias sou="source ~/.zshrc"

add_myscripts="/home/karl/.scripts/activated"
myscripts_exist=$(echo $PATH | sed 's/:/\n/g' | grep $add_myscripts)
[ -z "$myscripts_exist" ] &&  PATH="$PATH:$add_myscripts"

add_dmenu="/home/karl/.dmenu"
dmenu_exist=$(echo $PATH | sed 's/:/\n/g' | grep $add_dmenu)
[ -z "$dmenu_exist" ] &&  PATH="$PATH:$add_dmenu"

add_doom="/home/karl/.config/emacs/bin/"
doom_exist=$(echo $PATH | sed 's/:/\n/g' | grep $add_doom)
[ -z "$doom_exist" ] &&  PATH="$PATH:$add_doom"


[ "$TERM" = "xterm-color" ] && export TERM=xterm-256color


source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/zsh-vim-mode/zsh-vim-mode.plugin.zsh

bindkey '^ ' autosuggest-accept

ZSH_HIGHLIGHT_STYLES[default]='fg=3'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=5,underline'
ZSH_HIGHLIGHT_STYLES[command]='fg=4'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=6'
ZSH_HIGHLIGHT_STYLES[alias]='fg=4'
ZSH_HIGHLIGHT_STYLES[path]='fg=5'

ex ()

{
 if [ -f "$1" ]; then 
     case $1 in
         *.tar.bz2)   tar xjf  $1   ;;
         *.tar.gz)    tar xzf  $1   ;;
         *.bz2)       bunzip2  $1   ;;
         *.rar)       unrar x  $1   ;;
          *.gz)       gunzip   $1   ;;
         *.tar)       tar xf   $1   ;;
         *.tbz2)      tar xjf  $1   ;;
         *.tgz)       tar xzf  $1   ;;
         *.zip)       unzip    $1   ;;
         *.Z)         uncompress $1 ;;
         *.7z)        7z x     $1   ;;
         *.deb)       ar x     $1   ;;
         *.tar.zst)    unzstd  $1   ;;
         *.tar.xz)     tar xf  $1   ;;
         *)            echo "$1 Cannot be extracted vi ex()"
      esac
    else
       echo "$1 is not a valid file"
       fi  
}

export date=$(date +%d-%h-%Y-%H-%M)

source ~/.config/fzf/rose-pine-moon.sh

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
