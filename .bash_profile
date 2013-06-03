#!/bin/bash
if [ -f $HOME/.bashrc ]; then
	source $HOME/.bashrc
fi

# Settings for Mapnik.framework Installer to enable Mapnik programs and python bindings
export PATH=/Library/Frameworks/Mapnik.framework/Programs:$PATH
export PYTHONPATH=/Library/Frameworks/Mapnik.framework/Python:$PYTHONPATH
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
