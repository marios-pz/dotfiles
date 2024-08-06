#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

if [ -f "./.config/bash/alias.sh" ]; then
    . "./.config/bash/alias.sh"
fi

if [ -f "./.config/bash/config.sh" ]; then
    . "./.config/bash/config.sh"
fi

if [ -f "./.config/bash/kubectl.sh" ]; then
    . "./.config/bash/kubectl.sh"
fi

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'


# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/.local/google-cloud-sdk/path.bash.inc" ]; then 
    . "$HOME/.local/google-cloud-sdk/path.bash.inc"; 
fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/.local/google-cloud-sdk/completion.bash.inc" ]; then 
    . "$HOME/.local/google-cloud-sdk/completion.bash.inc";
fi

eval "$(starship init bash)"
