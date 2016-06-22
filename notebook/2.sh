senhaRoot(){
  echo " * * * * * ALTERAR SENHA ROOT * * * * * "
  echo ""
  passwd # define a senha do root
  echo ""
}
senhaRoot

grub(){
  echo " * * * * * INSTALANDO E CONFIGURANDO O GRUB * * * * * "
  echo ""
  pacman -S grub --noconfirm ### instala o pacote do grub (confirmar se o grub não vem no grupo base)
  echo "GRUB_ENABLE_CRYPTODISK=y" >> /etc/default/grub
  sed -i '/GRUB_TIMEOUT=/s/5/1/g' /etc/default/grub ### reduz o tempo da seleção de 5 para 2 segundos
  sed -i '/GRUB_CMDLINE_LINUX=/s/""/"cryptdevice=\/dev\/sda2:sda2"/g' /etc/default/grub ###
  #sed -i '/GRUB_GFXMODE=/s/auto/1024x768/g' /etc/default/grub ### mudar resolucao do terminal(utilizado em VM sem GUI)
  sed -i ':a;$!{N;ba;};s/\(.*\)filesystems/\1encrypt filesystems/' /etc/mkinitcpio.conf
  grub-install /dev/sda ### instala o grub no disco
  mkinitcpio -p linux ### compila a imagem do sistema
  grub-install --recheck /dev/sda
  grub-mkconfig --output /boot/grub/grub.cfg ### configura o grub
  echo ""
}
grub

linguagemRegiao(){
  echo " * * * * * CONFIGURANDO LINGUAGEM E REGIAO * * * * * "
  echo ""
  echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf ### configura definitivamente o teclado
  sed -i '/en_US.UTF-8 UTF-8/s/#//g' /etc/locale.gen ### descomenta a linha do arquivo de localização com que tem os valores pt_BR
  locale-gen ## configura a localização
  echo LANG=en_US.UTF-8 > /etc/locale.conf ### define a codificação de localização do sistema
  export LANG=en_US.UTF-8
  mv /etc/localtime /etc/localtime_orig
  ln -s /usr/share/zoneinfo/America/Bahia /etc/localtime ### define a região
  hwclock --systohc --utc ### sincroniza o horário
}
linguagemRegiao

SincronizarAtualizar(){
  echo ""
  echo " * * * * * SINCRONIZANDO E ATUALIZANDO PACOTES * * * * * "
  pacman -Syyu ### sincronizacao e atualizacao total
  echo ""
}
SincronizarAtualizar

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
  echo "cryptsetup close sda3"
  echo ""
  echo "systemctl reboot"
  echo ""
}
final

##*******************************************************************************
