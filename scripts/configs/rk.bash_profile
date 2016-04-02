
#
# ~/.bashrc
#

alias ls='ls --color=auto'
alias grep='grep --color=auto'

#If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\033[0;31m\]\$ \[\033[0m\]'
