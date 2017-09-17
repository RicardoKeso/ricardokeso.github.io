criarParticoes(){
	clear
	echo " * * * * * CRIANDO PARTICOES * * * * * "
	echo ""
	parted -s /dev/sda mklabel msdos
	parted -s /dev/sda mkpart primary ext4 1MiB 257MiB
	parted -s /dev/sda mkpart primary ext4 257MiB 100%
	parted -s /dev/sda set 1 boot on
}

criptografar(){
	echo ""
	echo " * * * * * CRIPTOGRAFANDO * * * * * "
	echo ""
	modprobe dm-crypt ### carrega o módulo de criptografia
	cryptsetup -c aes-xts-plain64 -y -s 512 luksFormat /dev/sda2
	cryptsetup luksOpen /dev/sda2 lvmcrypt
}

criarVolumes(){
	pvcreate /dev/mapper/sda2 # volume fisico
	vgcreate lvmcrypt /dev/mapper/sda2 # grupo de volumes
	lvcreate -L 2G lvmcrypt -n swap
	lvcreate -L 16G lvmcrypt -n root
	lvcreate -L 100%FREE lvmcrypt -n home
}

formatarParticoes(){
	echo ""
	echo " * * * * * FORMATANDO PARTICOES * * * * * "
	echo ""
	dd if=/dev/zero of=/dev/sda1 bs=1M status=progress
	mkfs.ext4 /dev/sda1
	mkfs.ext4 /dev/mapper/lvmcrypt-root
	mkfs.ext4 /dev/mapper/lvmcrypt-home
	mkswap /dev/mapper/lvmcrypt-swap
}

montarParticoes(){
	echo ""
	echo " * * * * * MONTANDO PARTICOES * * * * * "
	echo ""
	mount /dev/mapper/lvmcrypt-root /mnt
	mkdir /mnt/home
	mount /dev/mapper/lvmcrypt-home /mnt/home
	mkdir /mnt/boot
	mount /dev/sda1 /mnt/boot
	swapon /dev/mapper/lvmcrypt-swap
}

instalarSistema(){
	echo ""
	echo " * * * * * INSTALANDO SISTEMA * * * * * "
	echo ""
	pacstrap /mnt base base-devel grub-bios ### instala o sistema na partição raiz (cronie = agendador de tarefas)
}

criarTabela(){
	echo ""
	echo " * * * * * GERANDO A TABELA DE ARQUIVOS DE SISTEMAS * * * * * "
	echo ""
	genfstab -U -p /mnt >> /mnt/etc/fstab ### cria a tabela de discos
}

posInstalacao(){
	echo ""
	echo " * * * * * BAIXANDO SCRIPTS DE POS INSTALACAO * * * * * "
	echo ""
	curl www.ricardokeso.com/scripts/cripo_2.sh > /mnt/root/cripo_2.sh
	chmod +x /mnt/root/cripo_2.sh
	echo ""
	echo " * * * * * DIGITE: /root/cripo_2.sh* * * * * "
	arch-chroot /mnt /bin/bash ### retorna para o sistema instalado
}

#criarParticoes
#criptografar
#criarVolumes
#formatarParticoes
#montarParticoes
#instalarSistema
#criarTabela
#posInstalacao
