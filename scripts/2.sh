
pacman -Syyu
pacman -S udev --noconfirm ### reinstala o pacote udev - RESOLVE_ERRO(Unable to find root device)
sed -i '/GRUB_TIMEOUT=/s/5/2/g' /etc/default/grub ### reduz o tempo da seleção de 5 para 2 segundos
echo "GRUB_ENABLE_CRYPTODISK=y" >> /etc/default/grub
mkinitcpio -p linux ### compila a imagem do sistema
grub-install --recheck /dev/sda
grub-mkconfig --output /boot/grub/grub.cfg ### configura o grub
