alias ls="ls -aFG"
alias ll="ls -l"
alias backup="sudo rsync -vaxE --delete --ignore-errors"
export EDITOR=vim
export GOROOT=$HOME/src/go
export GOPATH=$HOME/go
export PATH=/usr/local/bin:/usr/local/sbin:$PATH:/usr/local/share/npm/bin:/usr/local/mysql/bin:/usr/local/Cellar/todo-txt/2.9/bin:$GOROOT/bin:$GOPATH/bin
alias screen='TERM=screen screen'
alias virtualenv='virtualenv --no-site-packages'
alias ffmpeg=/Applications/ffmpegX.app/Contents/Resources/ffmpeg
alias t="todo.sh -d $HOME/.todo.cfg"
