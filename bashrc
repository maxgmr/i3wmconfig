#
# ~/.bashrc
#

export PATH=$PATH:$HOME/.cargo/bin:$HOME/.cargo/env

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '
# PS1='\e[1m[\e[34m\u\e(B\e[m\e[1m@\e[36m\h\e(B\e[m\e[1m \W]\$\e(B\e[m '
# PS1='\[\e[1m\][\[\e[34m\]\u\[\e(B\e[m\e[1m\]@\[\e[36m\]\h\[\e(B\e[m\e[1m\] \W]\[\$\e(B\e[m\] '
PS1='\[\e[1m\][\A \[\e[1;32m\]\u\[\e[m\e[1m\]@\[\e[1;36m\]\h \[\e[m\e[1m\]\W\[\]]\[\]\$ \[\e[m\]'

# Aliases
alias cl='clear'
alias rmi='rm -i'
