senhaRoot(){
  echo "* * * ROOT * * *"
  passwd
}

grub(){
  pacman -S grub --noconfirm
  echo "GRUB_ENABLE_CRYPTODISK=y" >> /etc/default/grub
  sed -i '/GRUB_TIMEOUT=/s/5/0/g' /etc/default/grub
  #sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/s/quiet/quiet video=hyperv_fb:1920x1080/g' /etc/default/grub # resolucao 1366x768 hyper-v
  sed -i '/GRUB_CMDLINE_LINUX=/s/""/"cryptdevice=\/dev\/sda2:lvmcrypt root=\/dev\/mapper\/lvmcrypt-root"/g' /etc/default/grub
  sed -i ':a;$!{N;ba;};s/\(.*\)filesystems/\1encrypt lvm2 filesystems/' /etc/mkinitcpio.conf
  mkinitcpio -p linux
  grub-install --recheck /dev/sda
  grub-mkconfig --output /boot/grub/grub.cfg
}

multilib(){ # apenas para sistemas 64bits
  echo "" >> /etc/pacman.conf 
  echo "[multilib]" >> /etc/pacman.conf 
  echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
  pacman -Sy
}

yaourt(){
  echo "" >> /etc/pacman.conf
  echo "[archlinuxfr]" >> /etc/pacman.conf
  echo "SigLevel = Never" >> /etc/pacman.conf
  echo "Server = http://repo.archlinux.fr/`uname -m`/" >> /etc/pacman.conf
  pacman -Sy
}

essenciais(){
  pacman -S yaourt vim unzip unrar p7zip ntfs-3g dosfstools wget curl bash-completion mlocate gnupg openssh cronie rsync git --noconfirm
  echo ""
}

ferramentasAnalise(){
  pacman -S mtr nmap nethogs tcpdump kismet aircrack-ng nikto gnu-netcat dsniff --noconfirm
}

grub
multilib
yaourt
essenciais
ferramentasAnalise
pacman -Syyu --noconfirm
senhaRoot
