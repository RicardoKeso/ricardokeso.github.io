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
alias less='/usr/share/vim/vim74/macros/less.sh'

#--------------------------------------------------
super='%(!.%#.$)' # nao esta funcionando como devaria
#acesso=`print -P '%y' | cut -c -3`

#if [ "$acesso" = "tty" ]; then # CONSOLE
        PROMPT='%F{yellow}>%f%B'$super' %b'
#elif [ "$acesso" = "pts" ]; then # 
#        PROMPT='%F{yellow}%m%f%B '$super' %b'
#fi
#--------------------------------------------------

# key bindings
bindkey "^[[1~" beginning-of-line
bindkey "^[[2~" quoted-insert
bindkey "^[[3~" delete-char
bindkey "^[[4~" end-of-line
bindkey "^[[5~" beginning-of-history
bindkey "^[[6~" end-of-history
