#systemctl enable netctl-ifplugd@`ip addr | grep "<" | grep -vi loopback | awk '{print $2}' | sed 's/://g'`

#modprobe dm-crypt
#cryptsetup luksOpen /dev/sda3 sda3
#mkdir /mnt/boot
#mount /dev/sda2 /mnt/boot
#mount /dev/mapper/sda3 /mnt
#arch-chroot /mnt /bin/bash

echo ""
echo " * * * * * ALTERAR SENHA ROOT * * * * * "
echo ""
passwd # define a senha do root

echo ""
echo " * * * * * SINCRONIZANDO E ATUALIZANDO PACOTES * * * * * "
echo ""
pacman -Syyu ### sincronizacao e atualizacao total

echo ""
echo " * * * * * INSTALANDO E CONFIGURANDO O GRUB * * * * * "
echo ""
#pacman -S grub --noconfirm ### instala o pacote do grub (confirmar se o grub não vem no grupo base)
echo "GRUB_ENABLE_CRYPTODISK=y" >> /etc/default/grub
sed -i '/GRUB_TIMEOUT=/s/5/1/g' /etc/default/grub ### reduz o tempo da seleção de 5 para 2 segundos
sed -i '/GRUB_CMDLINE_LINUX=/s/""/"cryptdevice=\/dev\/sda3:sda3"/g' /etc/default/grub ###
#sed -i '/GRUB_GFXMODE=/s/"auto"/"1024x768"/g' /etc/default/grub ### mudar resolucao do terminal(utilizado em vc sem GUI)
sed -i ':a;$!{N;ba;};s/\(.*\)filesystems/\1encrypt filesystems/' /etc/mkinitcpio.conf
grub-install /dev/sda ### instala o grub no disco
mkinitcpio -p linux ### compila a imagem do sistema
grub-install --recheck /dev/sda
grub-mkconfig --output /boot/grub/grub.cfg ### configura o grub
