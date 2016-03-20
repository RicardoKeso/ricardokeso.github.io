passwd # define a senha do root

pacman -Syyu

pacman -S grub --noconfirm ### instala o pacote do grub
grub-install /dev/sda ### instala o grub no disco
sed -i '/GRUB_TIMEOUT=/s/5/1/g' /etc/default/grub ### reduz o tempo da seleção de 5 para 2 segundos
sed -i '/GRUB_CMDLINE_LINUX=/s/""/"cryptdevice=\/dev\/sda3:sda3"/g' /etc/default/grub ###
# sed -i '/GRUB_GFXMODE=/s/"auto"/"1024x768"/g' /etc/default/grub ### mudar resolucao do terminal(utilizado em vc sem GUI)
echo "GRUB_ENABLE_CRYPTODISK=y" >> /etc/default/grub

sed -i ':a;$!{N;ba;};s/\(.*\)filesystems/\1encrypt filesystems/' /etc/mkinitcpio.conf
mkinitcpio -p linux ### compila a imagem do sistema

grub-install --recheck /dev/sda
grub-mkconfig --output /boot/grub/grub.cfg ### configura o grub

clear
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
