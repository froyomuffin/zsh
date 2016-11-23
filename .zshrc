# zsh-completion
fpath=(/usr/local/share/zsh-completions $fpath)

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tw/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall

# Mine
# =========

# Wrapper to which to verify if commands are available
function check-cmd {
    return `which $1 &> /dev/null`
}

export PS1='[%n@%m %~]$ '
export VISUAL='vim'

# Add time to history
export HISTTIMEFORMAT="%d/%m/%y %T "

# Add ~/bin to path
export PATH=$PATH:/home/tw/bin/:/git/toolbox/bin/
export ANDROID_HOME=/home/tw/Android/Sdk

# Urxvt
export TERM=xterm

# Pulseaudio
check-cmd pulseaudio && [[ -z $(pidof pulseaudio) ]] && echo "Starting pulseaudio" && pulseaudio -D

# X
check-cmd startx && [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

# Start byobu
#check-cmd byobu && [[ -z $(pidof tmux) ]] && echo "Starting byobu" && byobu

# General Aliases
ls --version &> /dev/null \
    && alias ls='ls --color=auto' \
    || alias ls='ls -G' # GNU vs BSD ls
alias vi='vim'
check-cmd xdg-open && alias open='xdg-open'

# Clipboard (xclip priority)
check-cmd xclip && alias c="xclip -selection clipboard" && alias v="xclip -o -selection clipboard"
check-cmd pbcopy && alias c="pbcopy"; check-cmd pbpaste && alias v="pbpaste"

# Clang
alias cl11="clang++ -std=c++11"
alias cl14="clang++ -std=c++14"

# GCC
alias g11="g++ -std=c++11"

# Word navigation
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word

# Bash habbits
alias .="source"
bindkey -v
bindkey '^R' history-incremental-search-backward

# Some extra environment variables
EXTRAVARSFILE='./.extravars'
[[ -e $EXTRAVARSFILE ]] && . $EXTRAVARSFILE 
