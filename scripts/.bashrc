#
# ~/.bashrc
#

alias ls='ls --color=auto'
alias grep='grep --color=auto'

#If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ $UID -eq "0" ]; then
	PS1='\[\033[1;37m\]rk\[\033[0;31m\] \$ \[\033[0m\]'
else
	PS1='\[\033[1;37m\]rk \$ \[\033[0m\]'
fi
