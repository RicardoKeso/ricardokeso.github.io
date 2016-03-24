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
  sed -i '/GRUB_TIMEOUT=/s/5/1/g' /etc/default/grub ### reduz o tempo da seleção de 5 para 2 segundos
  sed -i '/GRUB_CMDLINE_LINUX=/s/""/"cryptdevice=\/dev\/sda3:sda3"/g' /etc/default/grub ###
  #sed -i '/GRUB_GFXMODE=/s/"auto"/"1024x768"/g' /etc/default/grub ### mudar resolucao do terminal(utilizado em vc sem GUI)
  sed -i ':a;$!{N;ba;};s/\(.*\)filesystems/\1encrypt filesystems/' /etc/mkinitcpio.conf
  grub-install /dev/sda ### instala o grub no disco
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
  pacman -S yaourt --noconfirm ### instala o yaourt (repositório não oficial de usuários do Arch)
  pacman -S vim --noconfirm ### instala o sudo
  pacman -S unzip unrar p7zip --noconfirm ### instala ferramentas de compactação
  pacman -S ntfs-3g dosfstools --noconfirm ### instala as ferramentas necessárias para acesso e formatação de sistemas de arquivos microsoft
  pacman -S wget curl --noconfirm ### instala gerenciadores de download
  pacman -S bash-completion --noconfirm ### instala ferramenta para autocomplemento (tab) no terminal
  pacman -S mlocate --noconfirm ### instala as funções de pesquisa (updatedb, locate)
  pacman -S gnupg --noconfirm ### instala gnupg (GPG)
  pacman -S openssh --noconfirm ### instala openSSH
  pacman -S cronie --noconfirm ### instala cron
  echo ""
}

essenciaisGUI(){
  pacman -S firefox --noconfirm ### instala o firefox
  pacman -S pcmanfm --noconfirm ### gerenciado de arquivos grafico
  pacman -S feh --noconfirm ### visualizador de imagens (serve para gerir o wallpaper do desktop)
}

notebook(){
  pacman -S wireless_tools wpa_supplicant wpa_actiond dialog ### instala os pacotes para a wireless
  pacman -S acpi acpid --noconfirm ### instala gerenciadores de bateria para notebook
}

ferramentasAnalise(){
  pacman -S mtr --noconfirm ### combina ping com traceroute (ex.: mtp -c 1 --report 8.8.8.8)
  pacman -S nmap --noconfirm ### Utility for network discovery and security auditing
  pacman -S nethogs --noconfirm ### A net top tool which displays traffic used per process instead of per IP or interface
  pacman -S tcpdump --noconfirm ###
  pacman -S kismet --noconfirm ###
  pacman -S aircrack-ng --noconfirm ###
  pacman -S nikto --noconfirm ###
  pacman -S gnu-netcat --noconfirm ###
}

ferramentasAnaliseGUI(){
  pacman -S wireshark --noconfirm ###
  pacman -S openvas --noconfirm ###
}

ferramentasExtras(){
  pacman -S lm_sensors --noconfirm ### sensores de temperatura
  sensors-detect
}

linguagemRegiao(){
  echo " * * * * * CONFIGURANDO LINGUAGEM E REGIAO * * * * * "
  echo ""
  echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf ### configura definitivamente o teclado
  sed -i '/pt_BR/s/#//g' /etc/locale.gen ### descomenta a linha do arquivo de localização com que tem os valores pt_BR
  locale-gen ## configura a localização
  echo LANG=pt_BR.UTF-8 > /etc/locale.conf ### define a codificação de localização do sistema
  export LANG=pt_BR.UTF-8
  mv /etc/localtime /etc/localtime_orig
  ln -s /usr/share/zoneinfo/America/Bahia /etc/localtime ### define a região
  hwclock --systohc --utc ### sincroniza o horário
}

rede(){
  # systemctl enable netctl-auto@wlp9s0 ### habilita permanentemente o cliente de DHCP para a interface wireless
  systemctl enable netctl-ifplugd@`ip addr | grep "<" | grep -vi loopback | awk '{print $2}' | sed 's/://g'` ### habilita permanetemente o cliente de DHCP para o interface ethernet
}

servidorX(){
  echo " * * * * * CONFIGURANDO INTERFACE GRAFICA * * * * * "
  echo ""
  pacman -S xorg xorg-xinit --noconfirm ### instala o servidor X
  echo "" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
  echo "Section \"InputClass\"" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
  echo "    Identifier \"evdev keyboard catchall\"" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
  echo "    MatchIsKeyboard \"on\"" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
  echo "    MatchDevicePath \"/dev/input/event*\"" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
  echo "    Driver \"evdev\"" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
  echo "    Option \"XkbLayout\" \"br\"" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
  echo "    Option \"XkbVariant\" \"abnt2\"" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
  echo "EndSection" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
  echo "" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
}

i3(){
  pacman -S i3 dmenu --noconfirm ### instala o gerenciador de janelas i3 e o lançador de aplicativos dmenu
  echo "exec i3" > ~/.xinitrc ### define a inicialização do i3 junto com o X
}

audio(){
  pacman -S alsa-lib alsa-utils alsa-firmware alsa-plugins pulseaudio-alsa pulseaudio --noconfirm ### instala os pacotes para o funcionamento do audio
  pacman -S cmus vlc --noconfirm ### instala o players multimídia (cmus media player termnal)
}

multilib(){ # apenas para sistemas 64bits
  echo "" >> /etc/pacman.conf 
  echo "[multilib]" >> /etc/pacman.conf 
  echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
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
  curl ricardokeso.github.io/scripts/rk_bashrc > /root/.bashrc
  curl ricardokeso.github.io/scripts/rk_bash_profile > /root/.bash_profile
  mv /home/ricardokeso/.bashrc /home/ricardokeso/.bashrc_original
  cp /root/.bashrc /home/ricardokeso/.bashrc
  chown ricardokeso:ricardokeso /home/ricardokeso/.bashrc
  chmod 644 /home/ricardokeso/.bashrc
  mv /home/ricardokeso/.bash_profile /home/ricardokeso/.bash_profile_original
  cp /home/ricardokeso/.bashrc /home/ricardokeso/.bash_profile
  chown ricardokeso:ricardokeso /home/ricardokeso/.bash_profile
  chmod 644 /home/ricardokeso/.bash_profile
}

configsDiversas(){
  echo "AllowUsers ricardokeso" >> /etc/ssh/sshd_config
  echo "pinentry-program /usr/bin/pinentry-curses" > /home/ricardokeso/.gnupg/gpg-agent.conf
  #echo RELOADAGENT | gpg-connect-agent
}

gerenciamentoenergia(){
  #-adicionar "resume" (sem aspas) na linha HOOKS descomentada
  # sed -i 's/#HandlePowerKey=poweroff/HandlePowerKey=suspend/g' /etc/systemd/logind.conf # altera a função do botao de desligar para suspender
}

sincronizarAtualizar(){
  echo ""
  echo " * * * * * SINCRONIZANDO E ATUALIZANDO PACOTES * * * * * "
  pacman -Syyu ### sincronizacao e atualizacao total
  echo ""
}

final(){
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

padrao(){
  hostnamectl set-hostname ArchLinux_VM
  senhaRoot
  grub
  yaourt
  sincronizarAtualizar
}

install(){
  essenciais
  ferramentasAnalise
}

personalizacao(){
  linguagemRegiao
  usuario
  personalizarTerminal
  configsDiversas
  sincronizarAtualizar
  final
}

multimidia(){
  essenciaisGUI
  ferramentasAnaliseGUI
  servidorX
  i3
  audio
}

padrao
# install
# notebook
# ferramentasExtras
# rede
# multilib
# multimidia
# personalizacao
