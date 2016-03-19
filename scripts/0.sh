parted -s /dev/sda mklabel msdos
parted -s /dev/sda mkpart primary linux-swap 1MiB 1025MiB ### cria uma particao de swap de 1GB
parted -s /dev/sda mkpart primary ext4 1025MiB 1125MiB
parted -s /dev/sda mkpart primary ext4 1125MiB 100%
parted -s /dev/sda set 2 boot on

mkswap /dev/sda1 && swapon /dev/sda1 ### formata a partição de swap e a ativa

modprobe dm-crypt ### carrega o módulo de criptografia
cryptsetup -c aes-xts-plain64 -y -s 512 luksFormat /dev/sda3 ### criptografa a partição selecionada
cryptsetup luksOpen /dev/sda3 sda3 ### abre a partição criptografada e atribui um mapeamento

mkfs.ext4 /dev/sda2 ### cria o sistema de arquivos na partição de boot que não pode ser criptografada
mkfs.ext4 /dev/mapper/sda3 ### cria o sistema de arquivos através do mapeamento para a partição criptografada

mkdir /mnt/boot ### para criar a raiz (/mnt) e o boot (/mnt/boot)
mount /dev/sda2 /mnt/boot ### monta a partição de boot
mount /dev/mapper/sda3 /mnt ### monta a partição raiz

pacstrap -i /mnt base base-devel grub-bios ### instala o sistema na partição raiz
genfstab -U -p /mnt >> /mnt/etc/fstab ### cria a tabela de discos

arch-chroot /mnt /bin/bash ### retorna para o sistema instalado
