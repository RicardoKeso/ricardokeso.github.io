senhaRoot(){
  echo " * * * * * ALTERAR SENHA ROOT * * * * * "
  echo ""
  passwd # define a senha do root
  echo ""
}

grub(){
  echo " * * * * * INSTALANDO E CONFIGURANDO O GRUB * * * * * "
  echo ""
  pacman -S grub --noconfirm
  sed -i '/GRUB_TIMEOUT=/s/5/1/g' /etc/default/grub
  sed -i '/GRUB_GFXMODE=/s/auto/800x600/g' /etc/default/grub
  sed -i ':a;$!{N;ba;};s/\(.*\)filesystems/\1mdadm_udev filesystems/' /etc/mkinitcpio.conf
  grub-install /dev/sda
  mkinitcpio -p linux
  grub-install --recheck /dev/sda
  grub-mkconfig --output /boot/grub/grub.cfg
  echo ""
}

rede(){
  #systemctl enable netctl-auto@`ip addr | grep "<" | grep -vi loopback | awk '{print $2}' | sed 's/://g' | grep w` ### habilita permanentemente o cliente de DHCP para a interface wireless
  #systemctl enable netctl-ifplugd@`ip addr | grep "<" | grep -vi loopback | awk '{print $2}' | sed 's/://g' | grep e` ### habilita permanetemente o cliente de DHCP para o interface ethernet
  systemctl enable dhcpcd@.service
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
  echo "umount -R /mnt/{boot,home,}"
  echo ""
  echo "systemctl reboot"
  echo ""
}

##*******************************************************************************

padrao(){
  hostnamectl set-hostname raid_Arch
  senhaRoot
  grub
  rede
  sincronizarAtualizar
  final
}

padrao
