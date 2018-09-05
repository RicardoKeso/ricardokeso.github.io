senhaRoot(){
  echo " * * * * * ALTERAR SENHA ROOT * * * * * "
  echo ""
  passwd # define a senha do root
  echo ""
}

grub(){
  echo " * * * * * INSTALANDO E CONFIGURANDO O GRUB * * * * * "
  echo ""
  pacman -S grub --noconfirm ### instala o pacote do grub (confirmar se o grub não vem no grupo base)
  sed -i '/GRUB_TIMEOUT=/s/5/1/g' /etc/default/grub ### reduz o tempo da seleção de 5 para 2 segundos
  sed -i '/GRUB_GFXMODE=/s/auto/800x600/g' /etc/default/grub ### mudar resolucao do terminal(utilizado em VM sem GUI)
  grub-install /dev/sda ### instala o grub no disco
  mkinitcpio -p linux ### compila a imagem do sistema
  grub-mkconfig --output /boot/grub/grub.cfg ### configura o grub
}

yaourt(){
  echo "" >> /etc/pacman.conf
  echo "[archlinuxfr]" >> /etc/pacman.conf
  echo "SigLevel = Never" >> /etc/pacman.conf
  echo "Server = http://repo.archlinux.fr/`uname -m`/" >> /etc/pacman.conf
}

essenciais(){
  # (os pacotes tar bzip2 gzip pertencem ao grupo "base", sudo pertence ao grupo base-devel)
  echo " * * * * * INSTALANDO PACOTES * * * * * "
  echo ""
  #pacman -S yaourt --noconfirm ### instala o yaourt (repositório não oficial de usuários do Arch)
  pacman -S vim --noconfirm ### instala o sudo
  pacman -S unzip unrar p7zip --noconfirm ### instala ferramentas de compactação
  pacman -S ntfs-3g dosfstools --noconfirm ### instala as ferramentas necessárias para acesso e formatação de sistemas de arquivos microsoft
  pacman -S wget curl --noconfirm ### instala gerenciadores de download
  pacman -S bash-completion --noconfirm ### instala ferramenta para autocomplemento (tab) no terminal
  pacman -S mlocate --noconfirm ### instala as funções de pesquisa (updatedb, locate)
  pacman -S gnupg --noconfirm ### instala gnupg (GPG)
  pacman -S openssh --noconfirm ### instala openSSH
  pacman -S cronie --noconfirm ### instala cron
  pacman -S rsync --noconfirm
  #pacman -S zsh --noconfirm ### outro shell
  #pacman -S git --noconfirm ### github
  echo ""
}

ferramentasAnalise(){
  pacman -S mtr --noconfirm ### combina ping com traceroute (ex.: mtp -c 1 --report 8.8.8.8)
  pacman -S nmap --noconfirm ### Utility for network discovery and security auditing
  pacman -S nethogs --noconfirm ### A net top tool which displays traffic used per process instead of per IP or interface
  pacman -S tcpdump --noconfirm ###
  pacman -S kismet --noconfirm ###
  pacman -S aircrack-ng --noconfirm ###
  pacman -S nikto --noconfirm ###
  pacman -S gnu-netcat --noconfirm ###
  pacman -S dnsutils --noconfirm ###
  pacman -S ettercap --noconfirm ###
  pacman -S dnsniff --noconfirm ###
}

linguagemRegiao(){
  echo " * * * * * CONFIGURANDO LINGUAGEM E REGIAO * * * * * "
  echo ""
  echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf ### configura definitivamente o teclado
  sed -i '/pt_BR/s/#//g' /etc/locale.gen ### descomenta a linha do arquivo de localização com que tem os valores pt_BR
  locale-gen ## configura a localização
  echo LANG=pt_BR.UTF-8 > /etc/locale.conf ### define a codificação de localização do sistema
  export LANG=pt_BR.UTF-8
  mv /etc/localtime /etc/localtime_orig
  ln -s /usr/share/zoneinfo/America/Bahia /etc/localtime ### define a região
  hwclock --systohc --utc ### sincroniza o horário
}

rede(){
  #para notebook
  #systemctl enable netctl-auto@`ip addr | grep "<" | grep -vi loopback | awk '{print $2}' | sed 's/://g' | grep w` ### habilita permanentemente o cliente de DHCP para a interface wireless
  #systemctl enable netctl-ifplugd@`ip addr | grep "<" | grep -vi loopback | awk '{print $2}' | sed 's/://g' | grep e` ### habilita permanetemente o cliente de DHCP para o interface ethernet
  
  #para desk
  systemctl enable dhcpcd
}

multilib(){ # apenas para sistemas 64bits
  echo "" >> /etc/pacman.conf 
  echo "[multilib]" >> /etc/pacman.conf 
  echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
}

sincronizarAtualizar(){
  echo ""
  echo " * * * * * SINCRONIZANDO E ATUALIZANDO PACOTES * * * * * "
  pacman -Syyu ### sincronizacao e atualizacao total
  echo ""
}

final(){
  clear
  echo ""
  echo " * * * * * SYSTEMA CONFIGURADO * * * * * "
  echo ""
  echo " * * * DIGITE OS PROXIMOS COMANDOS * * * "
  echo ""
  echo "exit"
  echo ""
  echo "umount -R /mnt"
  echo ""
  echo "umount -R /mnt/boot"
  echo ""
  echo "systemctl reboot"
  echo ""
}

##*******************************************************************************

padrao(){
  hostnamectl set-hostname Proxy_Arch
  senhaRoot
  grub
  #yaourt
  ## multilib # apenas para sistemas 64bits
  essenciais
  #ferramentasAnalise
  rede
  #linguagemRegiao
  sincronizarAtualizar
  final
}

padrao

# para personalizar o ZSH executar no usuario ricardokeso o seguinte comando (disponivel em: http://ohmyz.sh/)
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
