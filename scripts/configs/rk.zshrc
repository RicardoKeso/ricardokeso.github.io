autoload -Uz compinit promptinit
compinit
promptinit

prompt off

#--------------------------------------------------
acesso=`print -P '%y' | cut -c -3`

if [ "$acesso" = "tty" ]; then
        PROMPT='%F{red}$saida%#%f '
elif [ "$acesso" = "pts" ]; then
        PROMPT='%F{red}%m%f %B%#%b '
fi
#--------------------------------------------------

# key bindings
bindkey "^[[1~" beginning-of-line
bindkey "^[[2~" quoted-insert
bindkey "^[[3~" delete-char
bindkey "^[[4~" end-of-line
bindkey "^[[5~" beginning-of-history
bindkey "^[[6~" end-of-history
