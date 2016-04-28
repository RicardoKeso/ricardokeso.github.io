criarParticoes(){
	clear
	echo " * * * * * CRIANDO PARTICOES * * * * * "
	echo ""
	parted -s /dev/sda mklabel msdos
	parted -s /dev/sda mkpart primary linux-swap 1MiB 129MiB ### cria uma particao de SWAP de 128MB
	parted -s /dev/sda mkpart primary ext4 129MiB 193MiB ### cria particao de BOOT 64MB
	parted -s /dev/sda mkpart primary ext4 193MiB 832MiB ### cria particao raiz
	parted -s /dev/sda set 2 boot on
	mkswap /dev/sda1
	swapon /dev/sda1
}

formatarParticoes(){
	echo ""
	echo " * * * * * FORMATANDO PARTICOES * * * * * "
	echo ""
	mkfs.ext4 /dev/sda2
	mkfs.ext4 /dev/sda3
}

montarParticoes(){	
	echo ""
	echo " * * * * * MONTANDO PARTICOES * * * * * "
	echo ""
	mkdir /mnt/boot ### para criar a raiz (/mnt) e o boot (/mnt/boot)
	mount /dev/sda2 /mnt/boot ### monta a partição de boot
	mount /dev/sda3 /mnt ### monta a partição raiz
}

instalarSistema(){	
	echo ""
	echo " * * * * * INSTALANDO SISTEMA * * * * * "
	echo ""
	pacstrap /mnt base
	echo ""
	echo " * * * * * GERANDO A TABELA DE ARQUIVOS DE SISTEMAS * * * * * "
	echo ""
	genfstab -U -p /mnt >> /mnt/etc/fstab

scriptsPosInstalacao(){	
	echo ""
	echo " * * * * * BAIXANDO SCRIPTS DE POS INSTALACAO * * * * * "
	echo ""
	curl www.ricardokeso.com/scripts/basic_2.sh > /mnt/root/basic_2.sh
	chmod +x /mnt/root/basic_2.sh
	echo ""
	echo " * * * * * DIGITE: /root/basic_2.sh* * * * * "
	arch-chroot /mnt /bin/bash ### retorna para o sistema instalado
}

criarParticoes
formatarParticoes
montarParticoes
instalarSistema
#scriptsPosInstalacao
