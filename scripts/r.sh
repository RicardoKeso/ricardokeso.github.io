#systemctl enable netctl-ifplugd@`ip addr | grep "<" | grep -vi loopback | awk '{print $2}' | sed 's/://g'`

#modprobe dm-crypt
#cryptsetup luksOpen /dev/sda3 sda3
#mkdir /mnt/boot
#mount /dev/sda2 /mnt/boot
#mount /dev/mapper/sda3 /mnt
#arch-chroot /mnt /bin/bash


echo "#" >> /root/.bashrc; cat /root/.bashrc >> /root/.bash_profile
echo "# ~/.bashrc" >> /root/.bashrc
echo "# ~/.bash_profile" >> /root/.bash_profile
echo "#" >> /root/.bashrc; cat /root/.bashrc >> /root/.bash_profile
echo "" >> /root/.bashrc; cat /root/.bashrc >> /root/.bash_profile
echo "alias ls='ls --color=auto'" >> /root/.bashrc; cat /root/.bashrc >> /root/.bash_profile
echo "alias grep='grep --color=auto'" >> /root/.bashrc; cat /root/.bashrc >> /root/.bash_profile
echo "" >> /root/.bashrc; cat /root/.bashrc >> /root/.bash_profile
echo "# If not running interactively, don't do anything" >> /root/.bashrc; cat /root/.bashrc >> /root/.bash_profile
echo "[[ $- != *i* ]] && return" >> /root/.bashrc; cat /root/.bashrc >> /root/.bash_profile
echo "" >> /root/.bashrc; cat /root/.bashrc >> /root/.bash_profile
echo "if [ $UID -eq "0" ]; then" >> /root/.bashrc
echo "  PS1='\[\033[1;37m\]rk\[\033[0;31m\] \$ \[\033[0m\]'" >> /root/.bashrc
echo "  PS1='\[\033[0;31m\] \$ \[\033[0m\]'" >> /root/.bash_profile
echo "else" >> /root/.bashrc
echo "	PS1='\[\033[1;37m\]rk \$ \[\033[0m\]'" >> /root/.bashrc
echo "fi" >> /root/.bashrc

mv /home/ricardokeso/.bashrc /home/ricardokeso/.bashrc_original
cp /root/.bashrc /home/ricardokeso/.bashrc
chown ricardokeso:ricardokeso /home/ricardokeso/.bashrc
chmod 644 /home/ricardokeso/.bashrc
