
#sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/s/quiet/quiet splash video=hyperv_fb:1366x768/g' /etc/default/grub # resolucao 1366x768 hyper-v
# sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/s/quiet/quiet splash video=hyperv_fb:1366x768/g' /etc/default/grub # resolucao 1366x768 hyper-v
#sed -i '/GRUB_GFXMODE=/s/auto/1920x1080/g' /etc/default/grub

sed -i '/GRUB_TIMEOUT=/s/5/0/g' /etc/default/grub
sed -i '/GRUB_GFXMODE=/s/auto/1920x1080/g' /etc/default/grub
#grub-install /dev/sda
grub-install --recheck /dev/sda
mkinitcpio -p linux
grub-mkconfig --output /boot/grub/grub.cfg



video=1920x1080


pacman -S xf86-video-fbdev xorg xorg-xinit --noconfirm ### instala o servidor X
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

pacman -S i3 dmenu terminator --noconfirm ### instala o gerenciador de janelas i3, o lançador de aplicativos dmenu, multiterminal
cp /etc/X11/xinit/xinitrc /home/ricardokeso/.xinitrc
echo "exec i3" > /home/ricardokeso/.xinitrc ### define a inicialização do i3 junto com o X

mkdir -p /home/ricardokeso/.config/terminator/
curl www.ricardokeso.com/scripts/Linux/configs/rk.config/terminator/config > /home/ricardokeso/.config/terminator/config

mkdir -p /home/ricardokeso/.config/i3/
curl www.ricardokeso.com/scripts/Linux/configs/rk.config/i3/config > /home/ricardokeso/.config/i3/config
curl www.ricardokeso.com/scripts/Linux/configs/rk.config/i3/i3status.conf > /home/ricardokeso/.config/i3/i3status.conf


pacman -S virtualbox-guest-utils
modprobe -a vboxguest vboxsf vboxvideo

$ VBoxClient --clipboard
$ VBoxClient --draganddrop
$ VBoxClient --seamless
$ VBoxClient --checkhostversion
$ VBoxClient --vmsvga