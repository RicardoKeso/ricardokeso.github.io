passwd

pacman -S grub --noconfirm
sed -i '/GRUB_TIMEOUT=/s/5/1/g' /etc/default/grub
sed -i '/GRUB_GFXMODE=/s/auto/800x600/g' /etc/default/grub
grub-install /dev/sda
mkinitcpio -p linux
grub-mkconfig --output /boot/grub/grub.cfg

pacman -S vim --noconfirm
pacman -S unzip unrar p7zip --noconfirm
pacman -S wget curl --noconfirm
pacman -S bash-completion --noconfirm
pacman -S mlocate --noconfirm
pacman -S gnupg --noconfirm
pacman -S openssh --noconfirm
pacman -S cronie --noconfirm
pacman -S rsync --noconfirm

pacman -S mtr --noconfirm
pacman -S nmap --noconfirm
pacman -S nethogs --noconfirm
pacman -S tcpdump --noconfirm
pacman -S kismet --noconfirm
pacman -S aircrack-ng --noconfirm
pacman -S nikto --noconfirm
pacman -S gnu-netcat --noconfirm
pacman -S dnsutils --noconfirm
pacman -S ettercap --noconfirm
pacman -S dnsniff --noconfirm

mv /etc/localtime /etc/localtime_orig
ln -s /usr/share/zoneinfo/America/Bahia /etc/localtime
hwclock --systohc --utc

systemctl enable dhcpcd

echo "" >> /etc/pacman.conf 
echo "[multilib]" >> /etc/pacman.conf 
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

pacman -Syyu

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

final