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

apt-get install -y sudo xorg chromium openbox lightdm unclutter

sed -i 's/^\[Seat:\*\]/# \[Seat:\*\]/' /etc/lightdm/lightdm.conf

echo "" >> /etc/lightdm/lightdm.conf
echo "[Seat:*]" >> /etc/lightdm/lightdm.conf
echo "autologin-user=boss" >> /etc/lightdm/lightdm.conf
echo "autologin-user-timeout=0" >> /etc/lightdm/lightdm.conf
echo "autologin-session=openbox" >> /etc/lightdm/lightdm.conf

mkdir -p /home/boss/.config/openbox/
echo "chromium --incognito --first-run --disable --disable-translate --disable-infobars --disable-suggestions-service --disable-save-password-bubble --start-maximized --kiosk \"http://monitordemetas.ip3.info/tvonline\" &" > /home/boss/.config/openbox/autostart
echo "unclutter -display 0:0 -noevents -grab &" >> /home/boss/.config/openbox/autostart
chown -R boss:boss /home/boss/

apt-get update && apt-get upgrade

reboot
