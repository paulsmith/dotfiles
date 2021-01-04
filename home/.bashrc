#!/bin/bash
export PS1="\u\[\e[1;34m\]@\[\e[m\]\h\[\e[90m\]:\[\e[m\]\w\[\e[90m\]\$\[\e[m\] "
alias ll="ls -l"
export EDITOR=/usr/bin/nano
eval "$(direnv hook bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
