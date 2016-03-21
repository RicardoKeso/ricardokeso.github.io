clear
echo " * * * * * CRIANDO PARTICOES * * * * * "
parted -s /dev/sda mklabel msdos
parted -s /dev/sda mkpart primary linux-swap 1MiB 257MiB ### cria uma particao de SWAP de 256MB
parted -s /dev/sda mkpart primary ext4 257MiB 321MiB ### cria particao de BOOT 64MB
parted -s /dev/sda mkpart primary ext4 321MiB 2369MB ### cria particao raiz com 2GB
parted -s /dev/sda set 2 boot on ### 
mkswap /dev/sda1  ### formata a partição de swap
swapon /dev/sda1  ### ativa a partição de swap
echo ""
echo " * * * * * CRIPTOGRAFANDO PARTICAO RAIZ * * * * * "
modprobe dm-crypt ### carrega o módulo de criptografia
cryptsetup -c aes-xts-plain64 -y -s 512 luksFormat /dev/sda3 ### criptografa a partição selecionada
cryptsetup luksOpen /dev/sda3 sda3 ### abre a partição criptografada e atribui um mapeamento
echo ""
echo " * * * * * FORMATANDO PARTICOES * * * * * "
mkfs.ext4 /dev/sda2 ### cria o sistema de arquivos na partição de boot que não pode ser criptografada
mkfs.ext4 /dev/mapper/sda3 ### cria o sistema de arquivos através do mapeamento para a partição criptografada
echo ""
echo " * * * * * MONTANDO PARTICOES * * * * * "
mkdir /mnt/boot ### para criar a raiz (/mnt) e o boot (/mnt/boot)
mount /dev/sda2 /mnt/boot ### monta a partição de boot
mount /dev/mapper/sda3 /mnt ### monta a partição raiz
echo ""
#echo " * * * * * INSTALANDO SISTEMA * * * * * "
#pacstrap /mnt base base-devel grub-bios -i ### instala o sistema na partição raiz
#echo ""
#echo " * * * * * GERANDO A TABELA DE ARQUIVOS DE SISTEMAS * * * * * "
#genfstab -U -p /mnt >> /mnt/etc/fstab ### cria a tabela de discos
#echo ""
#arch-chroot /mnt /bin/bash ### retorna para o sistema instalado
