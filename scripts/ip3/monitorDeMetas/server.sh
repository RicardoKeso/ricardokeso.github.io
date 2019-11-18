# hostnamectl set-hostname XXXXXXX
mv /etc/localtime /etc/localtime_orig
ln -s /usr/share/zoneinfo/America/Bahia /etc/localtime
hwclock --systohc --utc

echo "" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p

echo "" > /etc/apt/sources.list
echo "deb http://deb.debian.org/debian stretch main" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian stretch main" >> /etc/apt/sources.list
echo "deb http://deb.debian.org/debian stretch-updates main" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian stretch-updates main" >> /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security/ stretch/updates main" >> /etc/apt/sources.list
echo "deb-src http://security.debian.org/debian-security/ stretch/updates main" >> /etc/apt/sources.list

sed -i '/GRUB_TIMEOUT=/s/5/0/g' /etc/default/grub
update-grub

apt-get update && apt-get upgrade

# criar usuario "boss" na instalacao do sistema
# useradd boss -m

apt-get install apache2 php mysql-server
apt-get install phpmyadmin
apt-get install vsftpd

cp /etc/vsftpd.conf /etc/vsftpd.conf_original
echo "" > /etc/vsftpd.conf
echo "listen=YES" >> /etc/vsftpd.conf
echo "listen_ipv6=NO" >> /etc/vsftpd.conf
echo "anonymous_enable=NO" >> /etc/vsftpd.conf
echo "local_enable=YES" >> /etc/vsftpd.conf
echo "dirmessage_enable=YES" >> /etc/vsftpd.conf
echo "use_localtime=YES" >> /etc/vsftpd.conf
echo "xferlog_enable=YES" >> /etc/vsftpd.conf
echo "connect_from_port_20=YES" >> /etc/vsftpd.conf
echo "secure_chroot_dir=/var/run/vsftpd/empty" >> /etc/vsftpd.conf
echo "pam_service_name=vsftpd" >> /etc/vsftpd.conf
echo "ssl_enable=NO" >> /etc/vsftpd.conf
echo "idle_session_timeout=600" >> /etc/vsftpd.conf
echo "tcp_wrappers=YES" >> /etc/vsftpd.conf
echo "pasv_enable=YES" >> /etc/vsftpd.conf
echo "pasv_min_port=9040" >> /etc/vsftpd.conf
echo "pasv_max_port=9050" >> /etc/vsftpd.conf
echo "local_enable=YES" >> /etc/vsftpd.conf
echo "write_enable=YES" >> /etc/vsftpd.conf
echo "chroot_local_user=YES" >> /etc/vsftpd.conf
echo "user_sub_token=$USER" >> /etc/vsftpd.conf
echo "local_root=/home/$USER/" >> /etc/vsftpd.conf
echo "local_umask=022" >> /etc/vsftpd.conf
echo "xferlog_std_format=YES" >> /etc/vsftpd.conf

groupadd ftpusers
useradd tvonline -m -g ftpusers
chmod a-w /home/tvonline
passwd tvonline
mkdir /home/tvonline/public
chmod 755 /home/tvonline/public
chown tvonline:tvonline /home/tvonline/public
mkdir /var/www/html/tvonline
chown tvonline:tvonline /var/www/html/tvonline
chmod 755 /var/www/html/tvonline

echo "#!/bin/bash -e" >> /etc/rc.local
echo "mount --bind /var/www/html/tvonline /home/tvonline/public" >> /etc/rc.local
echo "mount --bind /var/www/html/boss /home/boss/public" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
chmod +x /etc/rc.local

echo "" >> /etc/ssh/sshd_config
echo "DenyGroups ftpusers" >> /etc/ssh/sshd_config

echo "alterar senha root"
passwd // A!
echo "alterar senha boss"
passwd boss // A!
echo "alterar senha tvonline"
passwd tvonline // 

echo "para configurar o banco, use os comandos no final do script"
# mysql -u root -p
##	UPDATE user SET Password=PASSWORD('Acr1318!') WHERE User='root';
##	CREATE DATABASE tvonline;
##	CREATE USER 'tvonline'@'%' IDENTIFIED BY 'u3+SLfa4';
##	GRANT ALL PRIVILEGES ON tvonline.* TO 'tvonline'@'localhost';
##	FLUSH PRIVILEGES;
