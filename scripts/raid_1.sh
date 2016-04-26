particionarSDA(){
	echo "SDA"
	parted -s /dev/sda -- mklabel msdos
	parted -s /dev/sda mkpart primary ext4 1MiB 65MiB	#	64M     /boot		/dev/sda1
	parted -s /dev/sda mkpart primary ext4 65MiB 3137MiB	#	3G      /		/dev/sda2
	parted -s /dev/sda mkpart extended 3137MiB 4676MiB	#	1.539G	extended	/dev/sda3
	parted -s /dev/sda mkpart logical ext4 3138MiB 3394MiB	#	256M    /home		/dev/sda5
	parted -s /dev/sda mkpart logical ext4 3395MiB 3651MiB	#	256M	linux-swap	/dev/sda6
	parted -s /dev/sda mkpart logical ext4 3652MiB 4676MiB	#	1G      Dados3		/dev/sda7
	parted -s /dev/sda mkpart primary ext4 4676MiB 7748MiB	#	3G      Dados1		/dev/sda4
}

particionarSDB(){
	echo "SDB"
	parted -s /dev/sdb -- mklabel msdos
	parted -s /dev/sdb -- mkpart primary ext4 1MiB -1	#	3G	/Dados1		/dev/sdb1
}

particionarSDC(){
	echo "SDC"
	parted -s /dev/sdc -- mklabel msdos
	parted -s /dev/sdc -- mkpart primary ext4 1MiB -1	#	2G	/Dados2		/dev/sdc1
}

particionarSDD(){
	echo "SDD"
	parted -s /dev/sdd -- mklabel msdos
	parted -s /dev/sdd -- mkpart primary ext4 1MiB -1	#	2G	/Dados2		/dev/sdd1
}

criarParticoes(){
	clear
	echo " * * * * * CRIANDO PARTICOES * * * * * "
	echo ""
	particionarSDA
	particionarSDB
	particionarSDC
	particionarSDD
	echo ""
}

formatarParticoes(){
	echo ""
	echo " * * * * * FORMATANDO PARTICOES * * * * * "
	echo ""
	mkfs.ext4 /dev/sda1	# boot
	mkfs.ext4 /dev/sda2	# raiz
	mkfs.ext4 /dev/sda5	# home
	mkfs.ext4 /dev/sda7	# dados3
	mkfs.ext4 /dev/sda4	# dados1
	mkfs.ext4 /dev/sdb1	# dados1
	mkfs.ext4 /dev/sdc1	# dados2
	mkfs.ext4 /dev/sdd1	# dados2
	echo ""
}

configurarSDA(){
	parted -s /dev/sda set 1 boot on	# 
	mkswap /dev/sda6			# formata a partição de swap
	swapon /dev/sda6			# ativa a partição de swap
}

montarParticoes(){	
	echo ""
	echo " * * * * * MONTANDO PARTICOES * * * * * "
	echo ""
	mkdir /mnt/boot           # para criar a raiz (/mnt) e o boot (/mnt/boot)
	mkdir /mnt/home           # para criar a raiz (/mnt) e o boot (/mnt/boot)
	mount /dev/sda2 /mnt/boot # monta a partição de boot
	mount /dev/sda3 /mnt      # monta a partição raiz
	mount /dev/sda5 /home     # monta a partição home
	echo ""
}

configurarRAID1(){
	mdadm --create --verbose --level=1 --metadata=1.2 --raid-devices=2 /dev/md0 /dev/sda4 /dev/sdb1
	mdadm --create --verbose --level=1 --metadata=1.2 --raid-devices=2 /dev/md1 /dev/sdc1 /dev/sdd1
	echo 'DEVICE partitions' > /etc/mdadm.conf
	mdadm --detail --scan >> /etc/mdadm.conf
	### mdadm --assemble --scan # montagem do raid depois da atualizacao (ATENCAO)
	#mkfs.ext4 /dev/md0
	#mkfs.ext4 /dev/md1
}

instalarSistema(){	
	echo ""
	echo " * * * * * INSTALANDO SISTEMA * * * * * "
	echo ""
	pacstrap /mnt base base-devel grub-bios # instala o sistema na partição raiz (cronie = agendador de tarefas)
	echo ""
	echo " * * * * * GERANDO A TABELA DE ARQUIVOS DE SISTEMAS * * * * * "
	echo ""
	genfstab -U -p /mnt >> /mnt/etc/fstab 	# cria a tabela de discos
}

scriptsPosInstalacao(){	
	echo ""
	echo " * * * * * BAIXANDO SCRIPTS DE POS INSTALACAO * * * * * "
	echo ""
	curl www.ricardokeso.com/scripts/raid_2.sh > /mnt/root/raid_2.sh
	chmod +x /mnt/root/raid_2.sh
	echo ""
	echo " * * * * * DIGITE: /root/default_2.sh* * * * * "
	arch-chroot /mnt /bin/bash 	# retorna para o sistema instalado
}

criarParticoes
formatarParticoes
#configurarSDA
#montarParticoes
#configurarRAID1
#instalarSistema
#scriptsPosInstalacao