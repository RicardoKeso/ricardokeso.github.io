# Para trocar o interpretador
# encontre o caminho do novo e aplique: por exemplo
# which zsh
# chsh -s caminhoDoInterpretador

autoload -Uz compinit promptinit
compinit
promptinit

prompt off

export HISTFILE=~/.zsh_history
export HISTFILESIZE=2500
export HISTSIZE=250
export HISTCONTROL=ignoredups
export HISTCONTROL=erasedups

chdir ~

echo "
#!/bin/bash

branch=\`git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3\`
super='%(!.%#.$)'

if [ ! \"\$branch\" = \"\" ]; then
    comp=\"on\"
    user=\`print -P %n\`
    sttus=\`git status 2> /dev/null | tail -n 1 | grep clean\`

    [[ \"\$user\" = \"ricardokeso\" ]] && user=\"RicardoKeso\"
    [[ \"\$sttus\" = \"\" ]] && sttus=\"%f%F{red}✗%f\" || sttus=\"%f%F{magenta}✓%f\"    

    PROMPT='%B%F{green}'\$user'%f at %F{yellow}%m%f in %F{blue}%~%f '\$comp' %F{cyan}'\$branch' '\$sttus'%f
'\$super'%b '
else
    #acesso=\`print -P '%y' | cut -c -3\`
    #if [ \"\$acesso\" = \"tty\" ]; then
        PROMPT='%F{yellow}>%f%B '\$super'%b '
    #elif [ \"\$acesso\" = \"pts\" ]; then
        #PROMPT='%F{yellow}%m%f%B '\$super' %b'
    #fi
fi
" > ~/.zshAux

#-----------------------------------------------------------------------------------------------------

. ~/.zshAux

# key bindings
bindkey "^[[1~" beginning-of-line
bindkey "^[[2~" quoted-insert
bindkey "^[[3~" delete-char
bindkey "^[[4~" end-of-line
bindkey "^[[5~" beginning-of-history
bindkey "^[[6~" end-of-history

function cd () { 
	chdir $@
	. ~/.zshAux;
}

alias ls='ls --color=always'
alias ping='print -P "%F{red}< < < Utilize MTR > > > "%f'
alias less='/usr/share/vim/vim74/macros/less.sh'
