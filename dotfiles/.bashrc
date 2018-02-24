# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

########
# PATH #
########

PATH=$PATH:$HOME/.local/bin

#########
# ALIAS #
#########

# conf

alias cernconf="source ~/.bashrc.cern"
alias py="source ~/.local/python_env/std/bin/activate"

# git                                  
                                             
alias ga="git add" 
alias gc="git commit"
alias gs="git status"
alias gd="git diff"
alias gdt="git difftool -y"

# ls

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# programs

alias m="make"
                                             
# Add an "alert" alias for long running commands.  Use like so: `sleep 10; alert`

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

###########
# HISTORY #
###########

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=1000000

##################
# USER INTERFACE #
##################

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

#Prompt
export PROMPT_COMMAND=__prompt_command
function __prompt_command() {
    local EXIT="$?"             # This needs to be first
    local returncode;
    local env_name;

    local RCol='\[\e[0m\]'
    local Red='\[\e[0;31m\]'
    local Gre='\[\e[0;32m\]'
    local BYel='\[\e[1;33m\]'
    local BBlu='\[\e[1;34m\]'
    local Pur='\[\e[0;35m\]'
    local Cyan='\[\e[36m\]'
    local BRed='\[\e[41m\]'

    # Python virtual env
    if [ ! -z "$VIRTUAL_ENV" ]; then
	    env_name=$(basename "$VIRTUAL_ENV")
	    env_name="($env_name) "
    fi

    if [ $EXIT != 0 ]; then
        returncode="${Red}=$EXIT${RCol} "      # Add red if exit code non 0
    fi

    PS1="\n$env_name[$returncode${Cyan}\u${RCol}@${BBlu}\h ${RCol}\w]\n$ "
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Stuff for tmux

#TERM=xterm-256color


##########################
# Per-host configuration #
##########################

if [[ $HOSTNAME == 'pcbe16512' ]]; then
    export MANPATH='/usr/share/man/'
fi

if [[ $HOSTNAME == "cs-ccr-"* ]]; then
    cernconf
fi