# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

alias ll='ls -l'
alias ack=ack-grep
alias ec2="ssh -l root -i $HOME/.ssh/ec2.pem"
alias watch-sicp='mplayer -af equalizer=-12:-12:-12:0:0:0:12:12:-6:-12'
alias backup='sudo rsync -vaxE --delete --ignore-errors'
alias tun='ssh -f -N '
alias dotfiles="git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME"

# Make SSH port forwarding / tunneling a little friendlier
complete -F _ssh tun

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper_bashrc

# Clojoure
export PATH=$HOME/bin:$PATH:$HOME/src/clojure-contrib/launchers/bash
export CLOJURE_EXT=$HOME/.clojure
alias clj=clj-env-dir

EMACSCLIENT=emacsclient.emacs-snapshot
export EDITOR=$EMACSCLIENT

# Emacs + virtualenv
function export_emacs () {
    which $EMACSCLIENT > /dev/null || return 1

    for name in $@; do
	value=$(eval echo \"\$${name}\")
	$EMACSCLIENT -e "(setenv \"${name}\" \"${value}\")" > /dev/null
    done
}

function set_virtualenv_django_settings () {
    case "$1" in
	everyblock)
	    export DJANGO_SETTINGS_MODULE=everyblock.settings.dev.paul
	    ;;
    esac
}

function fix_emacs_ipython_virtualenv () {
    local VIRTUAL_ENV_IPYTHON=$1
    for emacs_var in ipython-command py-python-command; do
	$EMACSCLIENT -e "(setq ${emacs_var} \"${VIRTUAL_ENV_IPYTHON}\")" > /dev/null
    done
}

function activate_virtualenv () {
    local ENV_NAME=$1
    local VIRTUAL_ENV_VARS="WORKON_HOME PATH VIRTUAL_ENV DJANGO_SETTINGS_MODULE"
    local DEV_DIR=$HOME/dev/$ENV_NAME

    workon $ENV_NAME
    set_virtualenv_django_settings $ENV_NAME
    export_emacs "$VIRTUAL_ENV_VARS"
    fix_emacs_ipython_virtualenv `which ipython`
    test -d $DEV_DIR && cd $DEV_DIR
    # screen -S $ENV_NAME
}

# the _virtualenvs() function is defined in virtualenvwrapper
complete -o default -o nospace -F _virtualenvs activate_virtualenv

# Go
export GOROOT=$HOME/src/go
export GOOS=linux
export GOARCH=amd64

# pip
export PIP_REQUIRE_VIRTUALENV=true
export PIP_RESPECT_VIRTUALENV=true

# EveryBlock-specific Bash functions and aliases
if [ -f ~/.bash_evb ]; then
    . ~/.bash_evb
fi

# Fix Java toolkit issues with xmonad
export AWT_TOOLKIT=MToolkit
