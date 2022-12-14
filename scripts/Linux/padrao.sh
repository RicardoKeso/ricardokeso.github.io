parted -s /dev/sda mklabel msdos
parted -s /dev/sda mkpart primary linux-swap 1MiB 1024MiB
parted -s /dev/sda mkpart primary ext4 1024MiB 100%
mkfs.ext4 /dev/sda1
mkswap /dev/sda1
mount /dev/sda3 /mnt
swapon /dev/sda1
pacstrap -K /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
passwd