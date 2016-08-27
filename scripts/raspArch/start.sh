#!/bin/bash

passwd

useradd ricardokeso -m
passwd ricardokeso

rm /etc/localtime
ln -s /usr/share/zoneinfo/America/Bahia /etc/localtime
mv /etc/systemd/timesyncd.conf /etc/systemd/timesyncd.conf_orig
echo "[Time]" > /etc/systemd/timesyncd.conf
echo "NTP=pool.ntp.br" > /etc/systemd/timesyncd.conf
echo "FallbackNTP=pool.ntp.br" > /etc/systemd/timesyncd.conf

pacman -Syyu --noconfirm
pacman -S python3 --noconfirm
pacman -S apache php-apache --noconfirm
pacman -S transmission-cli --noconfirm
pacman -S nmap --noconfirm
pacman -S vim --noconfirm
pacman -S mlocate --noconfirm
pacman -S rsync --noconfirm
pacman -S ssmtp mutt --noconfirm
pacman -S dsniff --noconfirm

mkdir /mnt/storage
mount /dev/sda1 /mnt/storage/

cp /mnt/storage/config/wifi/wlan0* /etc/netctl/
cp /mnt/storage/bkp/usrBin/* /usr/bin/
cp /mnt/storage/bkp/usrLibSystemdSystem/* /usr/lib/systemd/system/
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

cp /mnt/storage/bkp/httpd.conf /etc/httpd/conf/
mv /srv/http /srv/http_orig
ln -s /mnt/storage/bkp/srvHttp /srv/http


# hostnamectl set-hostname NOME
# pacman -Sc --noconfirm
# shutdown -r now
