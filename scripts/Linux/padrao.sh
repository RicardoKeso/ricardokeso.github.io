parted -s /dev/sda mklabel msdos
parted -s /dev/sda mkpart primary linux-swap 1MiB 1024MiB
parted -s /dev/sda mkpart primary ext4 1024MiB 100%

mkswap /dev/sda1
swapon /dev/sda1

mkfs.ext4 /dev/sda2
mount /dev/sda2 /mnt

pacstrap -K /mnt base #linux
#genfstab -U /mnt >> /mnt/etc/fstab
genfstab -U -p /mnt >> /mnt/etc/fstab
#arch-chroot /mnt

#ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
#hwclock --systohc
#passwd