#
# ~/.bashrc
#

export PATH="$PATH:$HOME/.cargo/bin:$HOME/.cargo/env:$HOME/computer/gems/bin:$HOME/.local/share/gem/ruby/3.0.0/bin"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '
# PS1='\e[1m[\e[34m\u\e(B\e[m\e[1m@\e[36m\h\e(B\e[m\e[1m \W]\$\e(B\e[m '
# PS1='\[\e[1m\][\[\e[34m\]\u\[\e(B\e[m\e[1m\]@\[\e[36m\]\h\[\e(B\e[m\e[1m\] \W]\[\$\e(B\e[m\] '
PS1='\[\e[1m\][\A \[\e[1;32m\]\u\[\e[m\e[1m\]@\[\e[1;36m\]\h \[\e[m\]\W\[\e[1m\]]\[\]\$ \[\e[m\]'

# Install Ruby Gems to ~/computer/gems
export GEM_HOME="$HOME/computer/gems"

# Aliases
alias cl='clear'
alias rmi='rm -i'
alias browsepackages="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias ex='exit'
alias dcss='crawl-tiles'
