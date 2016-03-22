#systemctl enable netctl-ifplugd@`ip addr | grep "<" | grep -vi loopback | awk '{print $2}' | sed 's/://g'`

#modprobe dm-crypt
#cryptsetup luksOpen /dev/sda3 sda3
#mkdir /mnt/boot
#mount /dev/sda2 /mnt/boot
#mount /dev/mapper/sda3 /mnt
#arch-chroot /mnt /bin/bash

teste(){
  echo "funciona"
}

#teste
