# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

HISTCONTROL=ignoreboth
shopt -s histappend
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

export EDITOR=vim

if command -v direnv &> /dev/null; then
	eval "$(direnv hook bash)"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -d ~/.pyenv/bin ]; then
	export PATH="$HOME/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

[ -d $HOME/.deno ] && export DENO_INSTALL=$HOME/.deno
