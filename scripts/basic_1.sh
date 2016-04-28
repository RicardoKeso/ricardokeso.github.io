parted -s /dev/sda -- mklabel msdos
parted -s /dev/sda mkpart primary linux-swap 1MiB 129MiB	# sda1 swap
parted -s /dev/sda mkpart primary ext4 129MiB 832MiB		# sda2 raiz

mkswap /dev/sda1
swapon /dev/sda1

mkfs.ext4 /dev/sda2

parted -s /dev/sda set 2 boot on

mount /dev/sda2 /mnt

pacstrap /mnt base
genfstab -p /mnt >> /mnt/etc/fstab

scriptsPosInstalacao(){	
	echo ""
	echo " * * * * * BAIXANDO SCRIPTS DE POS INSTALACAO * * * * * "
	echo ""
	curl www.ricardokeso.com/scripts/basic_2.sh > /mnt/root/basic_2.sh
	chmod +x /mnt/root/basic_2.sh
	echo ""
	echo " * * * * * DIGITE: /root/basic_2.sh* * * * * "
	arch-chroot /mnt ### retorna para o sistema instalado
}

#scriptsPosInstalacao
