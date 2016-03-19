#> NOME DA ESTACAO
hostnamectl set-hostname ArchLinux_VM

#> DEFINE O REPOSITORIO DO YAOURT
echo "" >> /etc/pacman.conf
echo "[archlinuxfr]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo "Server = http://repo.archlinux.fr/`uname -m`/" >> /etc/pacman.conf

#> ATUALIZACAO DE SISTEMA
pacman -Syu ### sincroniza o repositorio e procura por atualizações

#> PACOTES ESSENCIAIS
pacman -S yaourt --noconfirm ### instala o yaourt (repositório não oficial de usuários do Arch)
pacman -S sudo --noconfirm ### instala o sudo
pacman -S vim --noconfirm ### instala o sudo
pacman -S tar gzip bzip2 unzip unrar p7zip --noconfirm ### instala ferramentas de compactação
pacman -S ntfs-3g dosfstools --noconfirm ### instala as ferramentas necessárias para acesso e formatação de sistemas de arquivos microsoft
pacman -S wget curl --noconfirm ### instala gerenciadores de download
pacman -S bash-completion --noconfirm ### instala ferramenta para autocomplemento (tab) no terminal
pacman -S mlocate --noconfirm ### instala as funções de pesquisa (updatedb, locate)
pacman -S gnupg --noconfirm ### instala gnupg (GPG)

#> PACOTES ESSENCIAIS GUI
# pacman -S firefox --noconfirm ### instala o firefox
# pacman -S pcmanfm --noconfirm ### gerenciado de arquivos grafico
# pacman -S feh --noconfirm ### visualizador de imagens (serve para gerir o wallpaper do desktop)

#> FERRAMENTAS NOTEBOOK
# pacman -S wireless_tools wpa_supplicant wpa_actiond dialog ### instala os pacotes para a wireless
# pacman -S acpi acpid --noconfirm ### instala gerenciadores de bateria para notebook

#> FERRAMENTAS DE ANALISE TERMINAL
pacman -S mtr --noconfirm ### combina ping com traceroute (ex.: mtp -c 1 --report 8.8.8.8)
pacman -S nmap --noconfirm ### Utility for network discovery and security auditing
pacman -S nethogs --noconfirm ### A net top tool which displays traffic used per process instead of per IP or interface
pacman -S tcpdump --noconfirm ###
pacman -S kismet --noconfirm ###
pacman -S aircrack-ng --noconfirm ###
pacman -S nikto --noconfirm ###

#> FERRAMENTAS DE ANALISE GUI
# pacman -S wireshark --noconfirm ###
# pacman -S openvas --noconfirm ###

#> FERRAMENTAS EXTRAS
# pacman -S lm_sensors --noconfirm ### sensores de temperatura
# sensors-detect

#>CONFIGURA LINGUAGEM E REGIAO
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf ### configura definitivamente o teclado
sed -i '/pt_BR/s/#//g' /etc/locale.gen ### descomenta a linha do arquivo de localização com que tem os valores pt_BR
locale.gen ## configura a localização
echo LANG=pt_BR.UTF-8 > /etc/locale.conf ### define a codificação de localização do sistema
export LANG=pt_BR.UTF-8
mv /etc/localtime /etc/localtime_orig
ln -s /usr/share/zoneinfo/America/Bahia /etc/localtime ### define a região
hwclock --systohc --utc ### sincroniza o horário

#>CONFIGURACAO DE REDE
rm /etc/systemd/system/multi-user.target.wants/netctl*
# systemctl enable netctl-auto@wlp9s0 ### habilita permanentemente o cliente de DHCP para a interface wireless
systemctl enable netctl-ifplugd@`ip addr | grep "<" | grep -vi loopback | awk '{print $2}' | sed 's/://g'` ### habilita permanetemente o cliente de DHCP para o interface ethernet

#>SERVIDOR GRAFICO
# pacman -S xorg xorg-xinit --noconfirm ### instala o servidor X
# echo "" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
# echo "Section \"InputClass\"" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
# echo "    Identifier \"evdev keyboard catchall\"" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
# echo "    MatchIsKeyboard \"on\"" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
# echo "    MatchDevicePath \"/dev/input/event*\"" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
# echo "    Driver \"evdev\"" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
# echo "    Option \"XkbLayout\" \"br\"" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
# echo "    Option \"XkbVariant\" \"abnt2\"" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
# echo "EndSection" >> /usr/share/X11/xorg.conf.d/10-evdev.conf
# echo "" >> /usr/share/X11/xorg.conf.d/10-evdev.conf

#>GERANCIADOR DE JANELAS
# pacman -S i3 dmenu --noconfirm ### instala o gerenciador de janelas i3 e o lançador de aplicativos dmenu
# echo "exec i3" > ~/.xinitrc ### define a inicialização do i3 junto com o X

#>CONFIGURACAO DE AUDIO
# pacman -S alsa-lib alsa-utils alsa-firmware alsa-plugins pulseaudio-alsa pulseaudio --noconfirm ### instala os pacotes para o funcionamento do audio
# pacman -S cmus vlc --noconfirm ### instala o players multimídia (cmus media player termnal)

##-gerenciamento de energia
#-adicionar "resume" (sem aspas) na linha HOOKS descomentada
# sed -i 's/#HandlePowerKey=poweroff/HandlePowerKey=suspend/g' /etc/systemd/logind.conf # altera a função do botao de desligar para suspender

#>ATIVAR MULTILIB SE SISTEMA 64bits
# echo "" >> /etc/pacman.conf 
# echo "[multilib]" >> /etc/pacman.conf 
# echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

#>CONFIGURA USUARIO
useradd -m ricardokeso ### adiciona o usuário
passwd ricardokeso ### altera a senha do usuário
# (ATENCAO, os 3 comandos a seguir eu não aconselho. É mais seguro utilizar SuperUsuario apenas para demandas especificas)
groupadd sudo ### cria o grupo sudo
gpasswd -a ricarodkeso sudo ### adiciona o usuário ao grupo sudo
sed -i '/# %sudo/s/#//g' /etc/sudoers ### descomenta a linha que permite superAcesso aos usuários do grupo sudo

su ricardokeso
echo "pinentry-program /usr/bin/pinentry-curses" > ~/.gnupg/gpg-agent.conf
echo RELOADAGENT | gpg-connect-agent
exit

clear
echo ""
echo " * * * * * SYSTEMA CONFIGURADO * * * * * "
echo ""
echo ""
echo ""
