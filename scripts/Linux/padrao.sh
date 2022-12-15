parted -s /dev/sda mklabel msdos
parted -s /dev/sda mkpart primary linux-swap 1MiB 512MiB ### cria uma particao de SWAP de 256MB
parted -s /dev/sda mkpart primary ext4 512MiB 640MiB ### cria particao de BOOT 64MB
parted -s /dev/sda mkpart primary ext4 640MiB 100% ### cria particao raiz com 4GB (4417 = 3.8) ()
parted -s /dev/sda set 2 boot on ### 
mkswap /dev/sda1  ### formata a partição de swap
swapon /dev/sda1  ### ativa a partição de swap
mkfs.ext4 /dev/sda2 ### cria o sistema de arquivos na partição de boot que não pode ser criptografada
mkfs.ext4 /dev/sda3 ### cria o sistema de arquivos
mkdir /mnt/boot ### para criar a raiz (/mnt) e o boot (/mnt/boot)
mount /dev/sda2 /mnt/boot ### monta a partição de boot
mount /dev/sda3 /mnt ### monta a partição raiz
pacstrap /mnt base grub-bios
genfstab -U -p /mnt >> /mnt/etc/fstab ### cria a tabela de discos
arch-chroot /mnt /bin/bash ### retorna para o sistema instalado