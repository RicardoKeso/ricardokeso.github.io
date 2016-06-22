
Particionamento(){
	parted -s /dev/sda mklabel msdos
	parted -s /dev/sda mkpart primary ext4 0% 513MiB
	parted -s /dev/sda mkpart primary ext4 513MiB 100%
	parted -s /dev/sda set 1 boot on 
	parted -s /dev/sda set 2 lvm on 
}
Particionamento

Criptografia(){
	modprobe dm-crypt
	cryptsetup -c aes-xts-plain64 -y -s 512 luksFormat /dev/sda2
	cryptsetup luksOpen /dev/sda2 lvm
}
Criptografia

LVM(){
	pvcreate /dev/mapper/lvm
	vgcreate main /dev/mapper/lvm

	lvcreate -L 2GB -n swap main
	lvcreate -L 2GB -n root main
	lvcreate -l 100%FREE -n home main

	mkswap /dev/mapper/main-swap
	mkfs.ext4 /dev/mapper/main-root
	mkfs.ext4 /dev/mapper/main-home
	mkfs.ext4 /dev/sda1
}
LVM

Montagem(){
	mount /dev/mapper/main-root /mnt
	mkdir /mnt/boot
	mkdir /mnt/home
	mount /dev/sda1 /mnt/boot
	mount /dev/mapper/main-home /mnt/home
}
Montagem

#LinguagemRegiao(){
#	sed -i '/en_US.UTF-8 UTF-8/s/#//g' /etc/locale.gen
#	locale-gen
#}

InstalacaoBase(){
	pacstrap /mnt base
}
InstalacaoBase

#InstalacaoBase_Devel(){
#	pacstrap /mnt base-devel
#}

InstalacaoGrub_Bios(){
	pacstrap /mnt grub-bios
}
InstalacaoGrub_Bios

#InstalacaoSistema(){
#	InstalacaoBase
#	InstalacaoBase_Devel
#	InstalacaoGrub_Bios
#}

GeracaoFSTAB(){
	genfstab -U -p /mnt >> /mnt/etc/fstab
}
GeracaoFSTAB

ScriptPosInstalacao(){
	curl www.ricardokeso.com/notebook/2.sh > /mnt/root/2.sh
	chmod +x /mnt/root/2.sh
	echo ""
	echo " * * * * * DIGITE: /root/2.sh* * * * * "
	arch-chroot /mnt /bin/bash ### retorna para o sistema instalado
}
ScriptPosInstalacao
