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
	vgcreate lvmcrypt /dev/mapper/lvm

	lvcreate -L 1GB -n swap lvmcrypt
	lvcreate -L 8GB -n root lvmcrypt
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

InstalacaoSistema(){
	pacstrap /mnt base
	pacstrap /mnt base-devel
	pacstrap /mnt grub-bios
}


GeracaoFSTAB(){
	genfstab -U -p /mnt >> /mnt/etc/fstab
}

ScriptPosInstalacao(){
	curl www.ricardokeso.com/scripts/Lamborguini/b.sh > /mnt/root/b.sh
	chmod +x /mnt/root/b.sh
	echo "/root/b.sh" > /mnt/root/.bashrc
	arch-chroot /mnt /bin/bash
	rm -f /root/.bashrc
}

Particionamento
Criptografia
LVM
Montagem
InstalacaoSistema
GeracaoFSTAB
ScriptPosInstalacao
