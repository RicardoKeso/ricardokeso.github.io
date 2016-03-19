parted -s /dev/sda mklabel msdos
parted -s /dev/sda mkpart primary linux-swap 1MiB 1024MiB ### cria uma particao de swap de 1GB
parted -s /dev/sda mkpart primary ext4 1024MiB 1124MiB
parted -s /dev/sda mkpart primary ext4 1124MiB 8GiB # para setar o max substituir 8GiB por 100%
parted -s /dev/sda set 2 boot on

mkswap /dev/sda1 && swapon /dev/sda1 ### formata a partição de swap e a ativa

modprobe dm-crypt ### carrega o módulo de criptografia
cryptsetup -c aes-xts-plain64 -y -s 512 luksFormat /dev/sda3 ### criptografa a partição selecionada
cryptsetup luksOpen /dev/sda3 sda3 ### abre a partição criptografada e atribui um mapeamento

mkfs.ext4 /dev/sda2 ### cria o sistema de arquivos na partição de boot que não pode ser criptografada
mkfs.ext4 /dev/mapper/sda3 ### cria o sistema de arquivos através do mapeamento para a partição criptografada
