CriarParticoes(){
	parted -s /dev/sda mklabel msdos
	parted -s /dev/sda mkpart primary ext4 1MiB 257MiB
	parted -s /dev/sda mkpart primary ext4 257MiB 100%
	parted -s /dev/sda set 1 boot on
}

Criptografar(){
	modprobe dm-crypt
	cryptsetup -c aes-xts-plain64 -y -s 512 luksFormat /dev/sda2
	cryptsetup luksOpen /dev/sda2 crypto
}

CriarVolumes(){
	pvcreate /dev/mapper/crypto
	vgcreate lvmcrypt /dev/mapper/crypto
	lvcreate -L 2G lvmcrypt -n swap
	lvcreate -L 16G lvmcrypt -n root
	lvcreate -L 100%FREE lvmcrypt -n home
}

FormatarVolumesParticoes(){
	dd if=/dev/zero of=/dev/sda1 bs=1M status=progress
	mkfs.ext2 /dev/sda1
	mkfs.ext4 /dev/mapper/lvmcrypt-root
	mkfs.ext4 /dev/mapper/lvmcrypt-home
	mkswap /dev/mapper/lvmcrypt-swap
}

MontarVolumesParticoes(){
	mount /dev/mapper/lvmcrypt-root /mnt
	mkdir /mnt/home
	mount /dev/mapper/lvmcrypt-home /mnt/home
	mkdir /mnt/boot
	mount /dev/sda1 /mnt/boot
	swapon /dev/mapper/lvmcrypt-swap
}

CriarParticoes
Criptografar
CriarVolumes
FormatarVolumesParticoes
MontarVolumesParticoes
