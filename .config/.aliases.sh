#!/usr/bin/env bash

alias vim='nvim'
alias c='clear'
# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias vi='nvim'

# Changing "ls" to "eza"
alias la='eza -a --icons --color=always --group-directories-first'  # all files and dirs
alias ll='eza -l --icons --color=always --group-directories-first'  # long format
alias lt='eza -aT --icons --color=always --group-directories-first' # tree listing
alias l.='eza -a --icons | egrep "^\."'
alias l.='eza -al --icons --color=always --group-directories-first ../' # ls on the PARENT directory
alias l..='eza -al --icons --color=always --group-directories-first ../../' # ls on directory 2 levels up
alias l...='eza -al --icons --color=always --group-directories-first ../../../' # ls on directory 3 levels up

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"
