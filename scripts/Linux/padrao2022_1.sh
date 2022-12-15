parted -s /dev/sda mklabel msdos
parted -s /dev/sda mkpart primary linux-swap 1MiB 512MiB
parted -s /dev/sda mkpart primary ext4 512MiB 640MiB
parted -s /dev/sda mkpart primary ext4 640MiB 100%
parted -s /dev/sda set 2 boot on
mkswap /dev/sda1
swapon /dev/sda1
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3
mkdir /mnt/boot
mount /dev/sda2 /mnt/boot
mount /dev/sda3 /mnt
pacstrap /mnt base linux
genfstab -U -p /mnt >> /mnt/etc/fstab
curl www.ricardokeso.com/scripts/padrao2022_2.sh > /mnt/root/padrao2022_2.sh
chmod +x /mnt/root/padrao2022_2.sh
arch-chroot /mnt /bin/bash