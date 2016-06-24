senhaRoot(){
  echo " * * * * * ALTERAR SENHA ROOT * * * * * "
  echo ""
  passwd # define a senha do root
  echo ""
}

grub(){
  echo " * * * * * INSTALANDO E CONFIGURANDO O GRUB * * * * * "
  echo ""
  pacman -S grub --noconfirm ### instala o pacote do grub (confirmar se o grub não vem no grupo base)
  echo "GRUB_ENABLE_CRYPTODISK=y" >> /etc/default/grub
  sed -i '/GRUB_TIMEOUT=/s/5/0/g' /etc/default/grub ### reduz o tempo da seleção de 5 para 0 segundos
  sed -i '/GRUB_CMDLINE_LINUX=/s/""/"cryptdevice=\/dev\/sda2:lvmcrypt root=/dev/mapper/lvmcrypt-root"/g' /etc/default/grub ###
  #sed -i '/GRUB_GFXMODE=/s/auto/1024x768/g' /etc/default/grub ### mudar resolucao do terminal(utilizado em VM sem GUI)
  sed -i ':a;$!{N;ba;};s/\(.*\)filesystems/\1encrypt lvm2 filesystems/' /etc/mkinitcpio.conf
  #grub-install /dev/sda ### instala o grub no disco
  mkinitcpio -p linux ### compila a imagem do sistema
  grub-install --recheck /dev/sda
  grub-mkconfig --output /boot/grub/grub.cfg ### configura o grub
  echo ""
}

yaourt(){
  echo "" >> /etc/pacman.conf
  echo "[archlinuxfr]" >> /etc/pacman.conf
  echo "SigLevel = Never" >> /etc/pacman.conf
  echo "Server = http://repo.archlinux.fr/`uname -m`/" >> /etc/pacman.conf
}

essenciais(){
  # (os pacotes tar bzip2 gzip pertencem ao grupo "base", sudo pertence ao grupo base-devel)
  echo " * * * * * INSTALANDO PACOTES * * * * * "
  echo ""
  pacman -S vim --noconfirm ### instala o sudo
  pacman -S unzip unrar p7zip --noconfirm ### instala ferramentas de compactação
  pacman -S ntfs-3g dosfstools --noconfirm ### instala as ferramentas necessárias para acesso e formatação de sistemas de arquivos microsoft
  pacman -S wget curl --noconfirm ### instala gerenciadores de download
  pacman -S bash-completion --noconfirm ### instala ferramenta para autocomplemento (tab) no terminal
  pacman -S mlocate --noconfirm ### instala as funções de pesquisa (updatedb, locate)
  pacman -S openssh --noconfirm ### instala openSSH
  pacman -S rsync --noconfirm
  echo ""
}

linguagemRegiao(){
  echo " * * * * * CONFIGURANDO LINGUAGEM E REGIAO * * * * * "
  echo ""
  echo "KEYMAP=br-abnt2" > /etc/vconsole.conf ### configura definitivamente o teclado
  sed -i '/#en_US.UTF-8 UTF-8/s/#//g' /etc/locale.gen ### descomenta a linha do arquivo de localização com que tem os valores pt_BR
  locale-gen ## configura a localização
  echo LANG=en_US.UTF-8 > /etc/locale.conf ### define a codificação de localização do sistema
  export LANGUAGE=en_US.UTF-8
  export LANG=en_US.UTF-8
  if [ -e "/etc/localtime" ]; then
  	mv /etc/localtime /etc/localtime_orig
  fi
  ln -s /usr/share/zoneinfo/America/Bahia /etc/localtime ### define a região
  hwclock --systohc --utc ### sincroniza o horário
}

usuario(){
  echo ""
  echo " * * * * * CONFIGURANDO USUARIO * * * * * "
  echo ""
  useradd -m ricardokeso ### adiciona o usuário
  echo " * * * * * ALTERAR SENHA RICARDOKESO * * * * * "
  passwd ricardokeso ### altera a senha do usuário
  # (ATENCAO, os 3 comandos a seguir eu não aconselho. É mais seguro utilizar SuperUsuario apenas para demandas especificas)
  #groupadd sudo ### cria o grupo sudo
  #gpasswd -a ricardokeso sudo ### adiciona o usuário ao grupo sudo
  #sed -i '/# %sudo/s/#//g' /etc/sudoers ### descomenta a linha que permite superAcesso aos usuários do grupo sudo
}

personalizarTerminal(){
  echo " * * * * * CRIANDO ARQUIVOS DE PERSONALIZACAO DO TERMINAL * * * * * "
  echo ""
  curl www.ricardokeso.com/scripts/configs/rk.bashrc > /root/.bashrc
  curl www.ricardokeso.com/scripts/configs/rk.bash_profile > /root/.bash_profile
  mv /home/ricardokeso/.bashrc /home/ricardokeso/.bashrc_original
  cp /root/.bashrc /home/ricardokeso/.bashrc
  chown ricardokeso:ricardokeso /home/ricardokeso/.bashrc
  chmod 644 /home/ricardokeso/.bashrc
  mv /home/ricardokeso/.bash_profile /home/ricardokeso/.bash_profile_original
  cp /home/ricardokeso/.bashrc /home/ricardokeso/.bash_profile
  chown ricardokeso:ricardokeso /home/ricardokeso/.bash_profile
  chmod 644 /home/ricardokeso/.bash_profile
}

sincronizarAtualizar(){
  echo ""
  echo " * * * * * SINCRONIZANDO E ATUALIZANDO PACOTES * * * * * "
  pacman -Syyu ### sincronizacao e atualizacao total
  echo ""
}

final(){
	pacman -Syyu
	clear
	echo ""
	echo " * * * * * SYSTEMA CONFIGURADO * * * * * "
	echo ""
	echo " * * * DIGITE OS PROXIMOS COMANDOS * * * "
	echo ""
	echo "exit"
	echo ""
	echo "umount -R /mnt"
	echo ""
	echo "umount -R /mnt/boot"
	echo ""
	echo "cryptsetup close sda3"
	echo ""
	echo "systemctl reboot"
	echo ""
}

##*******************************************************************************

senhaRoot
sincronizarAtualizar
grub
yaourt
essenciais
linguagemRegiao
usuario
personalizarTerminal
final
