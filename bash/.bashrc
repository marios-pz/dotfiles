#/usr/bin/bash

set -o vi # I use Vim BTW
set completion-ignore-case on
export TERM=xterm-256color

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias vi='nvim'
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias suvi='sudo -E nvim'
alias grep='grep --color=auto'
alias virc='nvim ~/.config/nvim'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias weather="curl wttr.in"

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# ------ GPG ENCRYPTION -----
# verify signature for isos
alias gpg-check="gpg --keyserver-options auto-key-retrieve --verify"

# receive the key of a developer
alias gpg-retrieve="gpg --keyserver-options auto-key-retrieve --receive-keys"

export EDITOR="nvim"
export TERMINAL="foot"
export NNN_PLUG='f:finder;o:fzopen;p:mocq;d:diffs;t:nmount;v:imgview'
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$HOME/.local/bin":$PATH
export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

_BLACK=$(tput setaf 0)
_RED=$(tput setaf 1)
_GREEN=$(tput setaf 2)
_YELLOW=$(tput setaf 3)
_BLUE=$(tput setaf 4)
_MAGENTA=$(tput setaf 5)
_CYAN=$(tput setaf 6)
_WHITE=$(tput setaf 7)
_RESET=$(tput sgr0)
_BOLD=$(tput bold)

parse_git_branch() {
    amog="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')"
    echo "$amog"
}

export PS1="${_BOLD}${_YELLOW}[${_GREEN}\h${_BLUE}@${_RED}\u${_RESET}${_YELLOW}]\$(parse_git_branch) \$ ${_RESET}"
