criarParticoes(){
	clear
	echo " * * * * * CRIANDO PARTICOES * * * * * "
	echo ""
	parted -s /dev/sda mklabel msdos
	parted -s /dev/sda mkpart primary linux-swap 1MiB 512MiB ### cria uma particao de SWAP de 256MB
	parted -s /dev/sda mkpart primary ext4 512MiB 640MiB ### cria particao de BOOT 64MB
	parted -s /dev/sda mkpart primary ext4 640MiB 100% ### cria particao raiz com 4GB (4417 = 3.8) ()
	parted -s /dev/sda set 2 boot on ### 
	mkswap /dev/sda1  ### formata a partição de swap
	swapon /dev/sda1  ### ativa a partição de swap
}

formatarParticoes(){
	echo ""
	echo " * * * * * FORMATANDO PARTICOES * * * * * "
	echo ""
	mkfs.ext4 /dev/sda2 ### cria o sistema de arquivos na partição de boot que não pode ser criptografada
	mkfs.ext4 /dev/sda3 ### cria o sistema de arquivos
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
	pacstrap -K /mnt base linux linux-firmware # base-devel grub-bios ### instala o sistema na partição raiz (cronie = agendador de tarefas)
	echo ""
	echo " * * * * * GERANDO A TABELA DE ARQUIVOS DE SISTEMAS * * * * * "
	echo ""
	genfstab -U -p /mnt >> /mnt/etc/fstab ### cria a tabela de discos
}

scriptsPosInstalacao(){	
	echo ""
	echo " * * * * * BAIXANDO SCRIPTS DE POS INSTALACAO * * * * * "
	echo ""
	curl www.ricardokeso.com/scripts/Linux/default_2.sh > /mnt/root/default_2.sh
	chmod +x /mnt/root/default_2.sh
	echo ""
	echo " * * * * * DIGITE: /root/default_2.sh* * * * * "
	arch-chroot /mnt /bin/bash ### retorna para o sistema instalado
}

criarParticoes
formatarParticoes
montarParticoes
instalarSistema
scriptsPosInstalacao

# para baixar este script: www.ricardokeso.com/scripts/Linux/default_1.sh