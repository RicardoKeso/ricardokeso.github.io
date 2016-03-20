#systemctl enable netctl-ifplugd@`ip addr | grep "<" | grep -vi loopback | awk '{print $2}' | sed 's/://g'`

#modprobe dm-crypt
#cryptsetup luksOpen /dev/sda3 sda3
#mkdir /mnt/boot
#mount /dev/sda2 /mnt/boot
#mount /dev/mapper/sda3 /mnt
#arch-chroot /mnt /bin/bash


echo "#" > /root/.bashrc
echo "# ~/.bashrc" >> /root/.bashrc
echo "#" >> /root/.bashrc
echo "" >> /root/.bashrc
echo "alias ls='ls --color=auto'" >> /root/.bashrc
echo "alias grep='grep --color=auto'" >> /root/.bashrc
echo "" >> /root/.bashrc
echo "# If not running interactively, don't do anything" >> /root/.bashrc
echo "[[ $- != *i* ]] && return" >> /root/.bashrc
echo "" >> /root/.bashrc
cp /root/.bashrc /root/.bash_profile
echo "if [ $UID -eq "0" ]; then" >> /root/.bashrc
echo "  PS1='\[\033[1;37m\]rk\[\033[0;31m\] \$ \[\033[0m\]'" >> /root/.bashrc
echo "else" >> /root/.bashrc
echo "	PS1='\[\033[1;37m\]rk \$ \[\033[0m\]'" >> /root/.bashrc
echo "fi" >> /root/.bashrc
echo "PS1='\[\033[0;31m\] \$ \[\033[0m\]'" >> /root/.bash_profile
sed -i 's/"# ~\/.bashrc"/"# ~\/.bash_profile"/g' /root/.bash_profile

mv /home/ricardokeso/.bashrc /home/ricardokeso/.bashrc_original
cp /root/.bashrc /home/ricardokeso/.bashrc
chown ricardokeso:ricardokeso /home/ricardokeso/.bashrc
chmod 644 /home/ricardokeso/.bashrc
