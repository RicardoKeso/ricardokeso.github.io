
Particionamento(){
	parted -s /dev/sda mklabel msdos
	parted -s /dev/sda mkpart primary ext4 0% 257MiB
	parted -s /dev/sda mkpart primary ext4 257MiB 100%
	parted -s /dev/sda set 1 boot on 
	parted -s /dev/sda set 2 lvm on 
}

Criptografia(){
	modprobe dm-crypt
	cryptsetup -c aes-xts-plain64 -y -s 512 luksFormat /dev/sda2
	cryptsetup luksOpen /dev/sda2 lvm
}

LVM(){
	pvcreate /dev/mapper/lvm
	vgcreate main /dev/mapper/lvm

	lvcreate -L 1GB -n swap lvmcrypt
	lvcreate -L 2GB -n root lvmcrypt
	lvcreate -l 100%FREE -n home lvmcrypt
	
	mkswap /dev/mapper/lvmcrypt-swap
	mkfs.ext4 /dev/mapper/lvmcrypt-root
	mkfs.ext4 /dev/mapper/lvmcrypt-home
}

Montagem(){
	mount /dev/mapper/lvmcrypt-root /mnt
	mkdir /mnt/boot
	mkdir /mnt/home
	mount /dev/sda1 /mnt/boot
	mount /dev/mapper/lvmcrypt-home /mnt/home
}

LinguagemRegiao(){
	echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
	sed -i '/en_US.UTF-8 UTF-8/s/#//g' /etc/locale.gen
	locale-gen
}

InstalacaoBase(){
	pacstrap /mnt base
}

InstalacaoBase_Devel(){
	pacstrap /mnt base-devel
}

InstalacaoGrub_Bios(){
	pacstrap /mnt grub-bios
}

InstalacaoSistema(){
	InstalacaoBase
	InstalacaoBase_Devel
	InstalacaoGrub_Bios
}

GeracaoFSTAB(){
	genfstab -U -p /mnt >> /mnt/etc/fstab
}

ScriptPosInstalacao(){
	curl www.ricardokeso.com/notebook/2.sh > /mnt/root/2.sh
	chmod +x /mnt/root/2.sh
	echo ""
	echo " * * * * * DIGITE: /root/2.sh* * * * * "
	arch-chroot /mnt /bin/bash
}

Particionamento
Criptografia
LVM
Montagem
LinguagemRegiao
InstalacaoSistema
GeracaoFSTAB
ScriptPosInstalacao
