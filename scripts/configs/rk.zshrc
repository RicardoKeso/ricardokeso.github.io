# Para trocar o interpretador
# encontre o caminho do novo e aplique: por exemplo
# which zsh
# chsh -s caminhoDoInterpretador

autoload -Uz compinit promptinit
compinit
promptinit

prompt off

alias ls='ls --color=always'
alias ping='echo "< < < Utilize MTR > > > "'

#--------------------------------------------------
super='%(!.%#.$)'
acesso=`print -P '%y' | cut -c -3`

if [ "$acesso" = "tty" ]; then # CONSOLE
        PROMPT='%F{red} '$super' %f'
elif [ "$acesso" = "pts" ]; then # REMOTO
        PROMPT='%F{red}%m%f%B '$super' %b'
fi
#--------------------------------------------------

# key bindings
bindkey "^[[1~" beginning-of-line
bindkey "^[[2~" quoted-insert
bindkey "^[[3~" delete-char
bindkey "^[[4~" end-of-line
bindkey "^[[5~" beginning-of-history
bindkey "^[[6~" end-of-history
