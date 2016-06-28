usuario(){
  useradd -m ricardokeso 
  passwd ricardokeso
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
  pacman -S i3 dmenu terminator --noconfirm ### instala o gerenciador de janelas i3, o lançador de aplicativos dmenu, multiterminal
  echo "exec i3" > /home/ricardokeso/.xinitrc ### define a inicialização do i3 junto com o X
}

essenciaisGUI(){
  pacman -S firefox --noconfirm ### instala o firefox
  pacman -S pcmanfm --noconfirm ### gerenciado de arquivos grafico
  pacman -S feh --noconfirm ### visualizador de imagens (serve para gerir o wallpaper do desktop)
  pacman -S scrot --noconfirm ### ferramenta de printscreen
  pacman -S imagemagick --noconfirm ### manipulador de imagem
}

ferramentasAnaliseGUI(){
  pacman -S wireshark --noconfirm ###
  pacman -S openvas --noconfirm ###
}

personalizarTerminal(){
  echo "alias ls='ls --color=auto'" > /root/.bash_profile
  echo "alias grep='grep --color=auto'" >> /root/.bash_profile  
  echo "clear" >> /root/.bash_profile
  cp /root/.bash_profile /home/ricardokeso/.bash_profile
  echo "PS1='\[\033[1;37m\]rk > \[\033[0m\]'" >> /home/ricardokeso/.bash_profile
  cp /home/ricardokeso/.bash_profile /home/ricardokeso/.bashrc  
  echo "PS1='\[\033[0;31m\]\\$ \[\033[0m\]'" >> /root/.bash_profile
  
  chmod 600 /home/ricardokeso/.bashrc
  chmod 600 /home/ricardokeso/.bash_profile
}

personalizar_i3_terminator(){
  mkdir -p /home/ricardokeso/.config/terminator/
  curl www.ricardokeso.com/scripts/configs/rk.config/terminator/config > /home/ricardokeso/.config/terminator/config

  mkdir -p /home/ricardokeso/.config/i3/
  curl www.ricardokeso.com/scripts/configs/rk.config/i3/config > /home/ricardokeso/.config/i3/config
  curl www.ricardokeso.com/scripts/configs/rk.config/i3/i3status.conf > /home/ricardokeso/.config/i3/i3status.conf

  curl www.ricardokeso.com/scripts/configs/rk.bash_profile > /home/ricardokeso/.bash_profile
  curl www.ricardokeso.com/scripts/configs/rk.bashrc > /home/ricardokeso/.bashrc
}

configsDiversas(){
  echo "AllowUsers ricardokeso" >> /etc/ssh/sshd_config
  systemctl enable sshd.service
  
  mkdir -p /home/ricardokeso/.gnupg/
  echo "pinentry-program /usr/bin/pinentry-curses" > /home/ricardokeso/.gnupg/gpg-agent.conf
  #echo RELOADAGENT | gpg-connect-agent
}

gerenciamentoenergia(){
  echo ""
  # -adicionar "resume" (sem aspas) na linha HOOKS descomentada
  # sed -i 's/#HandlePowerKey=poweroff/HandlePowerKey=suspend/g' /etc/systemd/logind.conf # altera a função do botao de desligar para suspender
}

notebook(){
  pacman -S wireless_tools wpa_supplicant wpa_actiond dialog ### instala os pacotes para a wireless
  pacman -S acpi acpid --noconfirm ### instala gerenciadores de bateria para notebook
  curl www.ricardokeso.com/scripts/configs/etc-X11-xorg.conf.d/50-synaptics.conf > /etc/X11/xorg.conf.d/50-synaptics.conf
}

audio(){
  pacman -S alsa-lib alsa-utils alsa-firmware alsa-plugins pulseaudio-alsa pulseaudio --noconfirm ### instala os pacotes para o funcionamento do audio
  pacman -S cmus vlc --noconfirm ### instala o players multimídia (cmus media player termnal)
}

usuario
servidorX
i3
essenciaisGUI
ferramentasAnaliseGUI
personalizarTerminal
personalizar_i3_terminator
configsDiversas
gerenciamentoenergia
notebook
audio
chown -R ricardokeso:ricardokeso /home/ricardokeso
