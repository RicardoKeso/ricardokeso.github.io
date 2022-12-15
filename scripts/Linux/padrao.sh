parted -s /dev/sda mklabel msdos
parted -s /dev/sda mkpart primary linux-swap 1MiB 1024MiB
parted -s /dev/sda mkpart primary ext4 1024MiB 100%

mkswap /dev/sda1
swapon /dev/sda1

mkfs.ext4 /dev/sda2
parted -s /dev/sda set 2 boot on
mount /dev/sda2 /mnt

pacstrap /mnt base
genfstab -p /mnt >> /mnt/etc/fstab

# pacstrap -K /mnt base #linux
# genfstab -U /mnt >> /mnt/etc/fstab
# genfstab -U -p /mnt >> /mnt/etc/fstab