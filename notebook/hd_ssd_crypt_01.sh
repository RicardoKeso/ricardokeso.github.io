
parted -s /dev/sda mklabel msdos
parted -s /dev/sda mkpart primary ext4 1MiB 513MiB
parted -s /dev/sda mkpart primary ext4 513MiB 100%
parted -s /dev/sda set 1 boot on ### 
parted -s /dev/sda set 2 lvm on ### 

modprobe dm-crypt
cryptsetup -c aes-xts-plain64 -y -s 512 luksFormat /dev/sda2
cryptsetup luksOpen /dev/sda2 lvm

pvcreate /dev/mapper/lvm
vgcreate main /dev/mapper/lvm

lvcreate -L 2GB -n swap main
lvcreate -L 2GB -n root main
lvcreate -l 100%FREE -n home main

mkswap /dev/mapper/main-swap
mkfs.ext4 /dev/mapper/main-root
mkfs.ext4 /dev/mapper/main-home

mount /dev/mapper/main-root /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
mkdir /mnt/home
mount /dev/mapper/main-home /mnt/home

pacstrap /mnt base base-devel grub-bios

genfstab -U -p /mnt >> /mnt/etc/fstab

curl www.ricardokeso.com/scripts/2_config.sh > /mnt/root/2_config.sh
chmod +x /mnt/root/2_config.sh
echo ""
echo " * * * * * DIGITE: /root/2_config.sh* * * * * "
arch-chroot /mnt /bin/bash ### retorna para o sistema instalado
