modprobe dm-crypt ### carrega o módulo de criptografia
cryptsetup luksOpen /dev/sda3 sda3 ### abre a partição criptografada e atribui um mapeamento
mkdir /mnt/boot ### para criar a raiz (/mnt) e o boot (/mnt/boot)
mount /dev/sda2 /mnt/boot ### monta a partição de boot
mount /dev/mapper/sda3 /mnt ### monta a partição raiz
arch-chroot /mnt /bin/bash ### retorna para o sistema instalado
sed -i '/GRUB_TIMEOUT=/s/5/2/g' /etc/default/grub ### reduz o tempo da seleção de 5 para 2 segundos
echo "GRUB_ENABLE_CRYPTODISK=y" >> /etc/default/grub
