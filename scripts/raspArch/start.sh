#!/bin/bash

passwd

useradd ricardokeso -m
passwd ricardokeso

sed -i 's/$/ ipv6.disable=1/' /boot/cmdline.txt # desabilita ipv6 para rkm_conexoesWifi funcionar

rm /etc/localtime
ln -s /usr/share/zoneinfo/America/Bahia /etc/localtime
mv /etc/systemd/timesyncd.conf /etc/systemd/timesyncd.conf_orig
echo "[Time]" > /etc/systemd/timesyncd.conf
echo "NTP=pool.ntp.br" > /etc/systemd/timesyncd.conf
echo "FallbackNTP=pool.ntp.br" > /etc/systemd/timesyncd.conf

pacman -Syyu --noconfirm

pacman -S wpa_actiond --noconfirm 
pacman -S python3 --noconfirm
pacman -S apache php-apache --noconfirm
pacman -S transmission-cli --noconfirm
pacman -S nmap --noconfirm
pacman -S vim --noconfirm
pacman -S mlocate --noconfirm
pacman -S rsync --noconfirm
pacman -S ssmtp mutt --noconfirm
pacman -S dsniff --noconfirm
pacman -S wpa_actiond --noconfirm
pacman -s mpg123 --noconfirm
pacman -S samba --noconfirm
pacman -S hostapd --noconfirm
pacman -S dhcp --noconfirm

# Habilitar python GPIO
pacman -S python2-pip --noconfirm
pacman -S base-devel --noconfirm
pip2.7 install RPi.GPIO

mkdir /mnt/storage
mount /dev/sda1 /mnt/storage/

cp /mnt/storage/bkp/etcNetctl/* /etc/netctl/
cp /mnt/storage/bkp/usrBin/* /usr/bin/
cp /mnt/storage/bkp/usrLibSystemdSystem/* /usr/lib/systemd/system/
cp /mnt/storage/bkp/etcHttpdConf/httpd.conf /etc/httpd/conf/
cp /mnt/storage/bkp/etcSsmtp/ssmtp.conf /etc/ssmtp/
cp /mnt/storage/bkp/etc/dhcpd.conf /etc/
cp /mnt/storage/bkp/etcHostapd/hostapd.conf /etc/hostapd/
cp /mnt/storage/bkp/etcUdevRules.d/* /etc/udev/rules.d/

cp -R /mnt/storage/bkp/srvHttp/* /srv/http/

systemctl enable rkm_autoStart

echo "color_prompt=yes" > /root/.bash_profile
echo "" >> /root/.bash_profile
echo "alias ls='ls --color=auto'" >> /root/.bash_profile
echo "alias grep='grep --color=auto'" >> /root/.bash_profile
echo "" >> /root/.bash_profile
echo "PS1='\[\033[0;33m\]\h\[\033[00m\] \\$ '" >> /root/.bash_profile
echo "" >> /root/.bash_profile
echo "clear" >> /root/.bash_profile
cp /root/.bash_profile /home/ricardokeso/
chown ricardokeso:ricardokeso /home/ricardokeso/.bash_profile

# Habilitar audio
echo "dtparam=audio=on" >> /boot/config.txt
echo "snd-bcm2835" > /etc/modules-load.d/raspberrypi.conf

hostnamectl set-hostname pekka
pacman -Sc --noconfirm
# shutdown -r now
