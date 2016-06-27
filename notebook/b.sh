senhaRoot(){
  passwd # define a senha do root
}

grub(){
  echo "GRUB_ENABLE_CRYPTODISK=y" >> /etc/default/grub
  sed -i '/GRUB_TIMEOUT=/s/5/0/g' /etc/default/grub ### reduz o tempo da seleção de 5 para 0 segundos
  sed -i '/GRUB_CMDLINE_LINUX=/s/""/"cryptdevice=\/dev\/sda2:lvmcrypt root=\/dev\/mapper\/lvmcrypt-root"/g' /etc/default/grub ###
  #sed -i '/GRUB_GFXMODE=/s/auto/1024x768/g' /etc/default/grub ### mudar resolucao do terminal(utilizado em VM sem GUI)
  sed -i ':a;$!{N;ba;};s/\(.*\)filesystems/\1encrypt lvm2 filesystems/' /etc/mkinitcpio.conf
  #grub-install /dev/sda ### instala o grub no disco
  mkinitcpio -p linux ### compila a imagem do sistema
  grub-install --recheck /dev/sda
  grub-mkconfig --output /boot/grub/grub.cfg ### configura o grub
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
  pacman -S yaourt --noconfirm ### instala o yaourt (repositório não oficial de usuários do Arch)
  pacman -S vim --noconfirm ### instala o svim
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
  pacman -S git --noconfirm ### github
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
}

#senhaRoot
#grub
multilib
yaourt
essenciais
ferramentasAnalise
pacman -Syyu --noconfirm
