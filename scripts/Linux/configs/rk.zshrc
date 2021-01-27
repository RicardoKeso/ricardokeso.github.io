# Para trocar o interpretador
# encontre o caminho do novo e aplique: por exemplo
# which zsh
# chsh -s caminhoDoInterpretador

autoload -Uz compinit promptinit
compinit
promptinit

prompt off

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

export HISTFILE=$HOME/.zsh_history
export HISTFILESIZE=5000
export HISTSIZE=5000
export HISTCONTROL=ignoredups
export HISTCONTROL=erasedups
export HISTTIMEFORMAT="%F %T "
export SAVEHIST=5000

chdir ~

echo "
#!/usr/bin/zsh

#branch=\`git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3\`
super='%(!.%#.$)'
#diretorio=\`print -P '%~' | grep -i \"github\\\|bitbucket\" | cut -d'/' -f4-15\`
line=\`print -P %l\`

:<<'SCML'
if [ ! \"\$diretorio\" = \"\" ]; then
    if [ ! \"\$branch\" = \"\" ]; then
        comp=\"on\"
    else
        comp=\"(!)\"
    fi
    user=\`print -P %n\`
    sttus=\`git status 2> /dev/null | tail -n 1 | grep clean\`

    [[ \"\$user\" = \"ricardokeso\" ]] && user=\"RicardoKeso\"
    [[ \"\$sttus\" = \"\" ]] && sttus=\"%f%F{red}✗%f\" || sttus=\"%f%F{magenta}✓%f\"    

    PROMPT='%B%F{green}'\$user'%f at %F{yellow}%m%f in %F{blue}~/.../'\$diretorio'%f '\$comp' %F{cyan}'\$branch' '\$sttus'%f
'\$super'%b '
else
SCML
    acesso=\`who -aH | grep \$line | grep \"(:0\"\`
    if [ \"\$acesso\" = \"\" ]; then
        PROMPT='%F{yellow}%m%f%B '\$super'%b '
    else
        PROMPT='%F{yellow}>%f%B '\$super' %b'
    fi
#fi
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
