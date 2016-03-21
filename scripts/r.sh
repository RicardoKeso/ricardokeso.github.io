#systemctl enable netctl-ifplugd@`ip addr | grep "<" | grep -vi loopback | awk '{print $2}' | sed 's/://g'`

#modprobe dm-crypt
#cryptsetup luksOpen /dev/sda3 sda3
#mkdir /mnt/boot
#mount /dev/sda2 /mnt/boot
#mount /dev/mapper/sda3 /mnt
#arch-chroot /mnt /bin/bash

#curl ricardokeso.github.io/scripts/rk_bashrc > .bashrc
#curl ricardokeso.github.io/scripts/rk_bash_profile > .bash_profile

#mv /home/ricardokeso/.bashrc /home/ricardokeso/.bashrc_original
#cp /root/.bashrc /home/ricardokeso/.bashrc
#chown ricardokeso:ricardokeso /home/ricardokeso/.bashrc
#chmod 644 /home/ricardokeso/.bashrc


echo " * * * * * BAIXANDO SCRIPTS DE POS INSTALACAO * * * * * "
echo ""
curl ricardokeso.github.io/scripts/2_grub.sh > /mnt/tmp/2_grub.sh
chmod +x /mnt/tmp/2_grub.sh
curl ricardokeso.github.io/scripts/3_config.sh >/mnt/tmp/3_config.sh
chmod +x /mnt/tmp/3_config.sh
echo ""
echo " * * * * * DIGITE: /mnt/tmp/2_grub.sh* * * * * "
arch-chroot /mnt /bin/bash ### retorna para o sistema instalado
