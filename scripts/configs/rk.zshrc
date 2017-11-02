# Para trocar o interpretador
# encontre o caminho do novo e aplique: por exemplo
# which zsh
# chsh -s caminhoDoInterpretador

autoload -Uz compinit promptinit
compinit
promptinit

prompt off

echo "#!/bin/bash" > ~/.zshAux
echo "" >> ~/.zshAux
#echo "path=\`pwd\`" >> ~/.zshAux
#echo "cd \$path/\$1" >> ~/.zshAux
#echo "" >> ~/.zshAux
echo "branch=\`git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3\`" >> ~/.zshAux
echo "super='%(!.%#.$)'" >> ~/.zshAux
echo "" >> ~/.zshAux
echo "if [ ! \"\$branch\" = \"\" ]; then" >> ~/.zshAux
echo "    comp=\"on\"" >> ~/.zshAux
echo "    [[ \`print -P %n\` = \"ricardokeso\" ]] && user=\"RicardoKeso\"" >> ~/.zshAux
echo "    PROMPT='%B%F{green}'\$user'%f at %F{yellow}%m%f in %F{blue}%~%f '\$comp' %F{cyan}'\$branch'%f" >> ~/.zshAux
echo "'\$super'%b '" >> ~/.zshAux
echo "else" >> ~/.zshAux
echo "    #acesso=\`print -P '%y' | cut -c -3\`" >> ~/.zshAux
echo "    #if [ \"\$acesso\" = \"tty\" ]; then" >> ~/.zshAux
echo "        PROMPT='%F{yellow}>%f%B '\$super'%b '" >> ~/.zshAux
echo "    #elif [ \"\$acesso\" = \"pts\" ]; then" >> ~/.zshAux
echo "        #PROMPT='%F{yellow}%m%f%B '\$super' %b'" >> ~/.zshAux
echo "    #fi" >> ~/.zshAux
echo "fi" >> ~/.zshAux
echo "" >> ~/.zshAux
#echo "echo \$path/\$1" >> ~/.zshAux

#-----------------------------------------------------------------------------------------------------

. ~/.zshAux

# key bindings
bindkey "^[[1~" beginning-of-line
bindkey "^[[2~" quoted-insert
bindkey "^[[3~" delete-char
bindkey "^[[4~" end-of-line
bindkey "^[[5~" beginning-of-history
bindkey "^[[6~" end-of-history

alias ls='ls --color=always'
alias ping='print -P "%F{red}< < < Utilize MTR > > > "%f'
alias less='/usr/share/vim/vim74/macros/less.sh'

function cd () { 
	chdir `pwd`/$@
	. ~/.zshAux;
}
