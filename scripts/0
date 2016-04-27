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
	mkdir /mnt/boot           	# para criar /boot e raiz
	mount /dev/sda1 /mnt/boot 	# monta a partição de boot
	mount /dev/sda2 /mnt      	# monta a partição raiz
	mkdir /mnt/home			# para criar /home
	mount /dev/sda5 /mnt/home 	# monta a partição home
	cd /mnt
	mkdir mnt           	
	mkdir mnt/Dados1	     	# para criar /mnt/Dados1
	mkdir mnt/Dados2     		# para criar /mnt/Dados2
	mkdir mnt/Dados3     		# para criar /mnt/Dados3
	mount /dev/md0 /mnt/mnt/Dados1	# monta a partição home
	mount /dev/md1 /mnt/mnt/Dados2	# monta a partição home
	mount /dev/sda7 /mnt/mnt/Dados3	# monta a partição home
	cd
	echo ""
}

configurarRAID1(){
	mdadm --create --verbose --level=1 --metadata=1.2 --raid-devices=2 /dev/md0 /dev/sda4 /dev/sdb1 > raidLog
	echo "" >> raidLog
	
	mdadm --create --verbose --level=1 --metadata=1.2 --raid-devices=2 /dev/md1 /dev/sdc1 /dev/sdd1 >> raidLog
	echo "" >> raidLog
	
	echo 'DEVICE partitions' > /mnt/etc/mdadm.conf
	mdadm --detail --scan >> /mnt/etc/mdadm.conf
	cat "/mnt/etc/mdadm.conf" >> raidLog
	echo "" >> raidLog
	
	sincronizando=1
	while [ $sincronizando -eq 1 ]; do
		retorno=`cat /proc/mdstat | grep resync`
		if [ -z "$retorno" ]; then
			echo "Raids Sincronizados"
			sincronizando=$((sincronizando-1))
		else
			clear
			echo "Sincronizacao dos Raids"
			echo $retorno
		fi
		sleep 3
	done
	
	mdadm --assemble --scan # montagem do raid apenas depois da sincronizacao
	mkfs.ext4 /dev/md0
	mkfs.ext4 /dev/md1
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
configurarSDA
configurarRAID1
montarParticoes
instalarSistema
scriptsPosInstalacao
