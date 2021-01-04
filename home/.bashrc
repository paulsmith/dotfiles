# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

export PS1='\u\[\e[1;34m\]@\[\e[m\]\h\[\e[90m\]:\[\e[m\]\w\[\e[90m\]\$\[\e[m\] '

case "$OSTYPE" in
	linux*)
		if [ -x /usr/bin/dircolors ]; then
			if [ -r ~/.dircolors ]; then
				eval "$(dircolors -b ~/.dircolors)"
			else
				eval "$(dircolors -b)"
			fi
			alias ls="ls --color=auto"
		fi
		;;
	darwin*)
		alias ls="ls -G"
		;;
esac
alias ll="ls -l"

export EDITOR=/usr/bin/nano

eval "$(direnv hook bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
