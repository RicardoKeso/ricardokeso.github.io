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
  sed -i '/GRUB_TIMEOUT=/s/5/0/g' /etc/default/grub ### reduz o tempo da seleção de 5 para 2 segundos
  sed -i '/GRUB_GFXMODE=/s/auto/800x600/g' /etc/default/grub ### mudar resolucao do terminal(utilizado em VM sem GUI)
  grub-install /dev/sda ### instala o grub no disco
  mkinitcpio -p linux ### compila a imagem do sistema
  grub-mkconfig --output /boot/grub/grub.cfg ### configura o grub
}

essenciais(){
  # (os pacotes tar bzip2 gzip pertencem ao grupo "base", sudo pertence ao grupo base-devel)
  echo " * * * * * INSTALANDO PACOTES * * * * * "
  echo ""
  pacman -S wget curl bash-completion openssh --noconfirm
  #pacman -S wpa_supplicant # instalado apenas para testes de configuracoes de wifi
  echo ""
}

linguagemRegiao(){
  echo " * * * * * CONFIGURANDO LINGUAGEM E REGIAO * * * * * "
  echo ""
  echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf ### configura definitivamente o teclado
  sed -i '/pt_BR/s/#//g' /etc/locale.gen ### descomenta a linha do arquivo de localização com que tem os valores pt_BR
  locale-gen ## configura a localização
  echo LANG=pt_BR.UTF-8 > /etc/locale.conf ### define a codificação de localização do sistema
  export LANG=pt_BR.UTF-8
  hwclock --systohc --utc ### sincroniza o horário
}

rede(){
  #systemctl enable netctl-auto@`ip addr | grep "<" | grep -vi loopback | awk '{print $2}' | sed 's/://g' | grep w` ### habilita permanentemente o cliente de DHCP para a interface wireless
  systemctl enable netctl-ifplugd@`ip addr | grep "<" | grep -vi loopback | awk '{print $2}' | sed 's/://g' | grep e` ### habilita permanetemente o cliente de DHCP para o interface ethernet
  #systemctl enable dhcpcd@.service
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
  essenciais
  rede
  #linguagemRegiao
  sincronizarAtualizar
  final
}

padrao
