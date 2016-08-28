#!/bin/sh

clear
echo " * * * Preencha as configuracoes da rede * * *"
echo ""
read -p "ESSID: " essid
read -p "PASS: " pass
read -p "INTERFACE: " interface
read -p "HIDDEN: " hidden

configRede="/etc/netctl/wlan0-$essid"
#configRede=`pwd`"/wlan0-$essid"

echo "Description='Gerado atraves do script (criarRede.sh) - $pass'" > $configRede
echo "Interface=wlan0" >> $configRede
echo "Connection=wireless" >> $configRede
echo "Security=wpa" >> $configRede
echo "IP=dhcp" >> $configRede
echo "ESSID=$essid" >> $configRede
echo "`wpa_passphrase $essid $pass | sed 's/\tpsk/Key/g' | grep Key=`" >> $configRede
echo "Hidden=$hidden" >> $configRede
echo "Priority=3" >> $configRede

chmod 600 "${configRede}"

echo ""
echo ""
echo " * * * Arquivo gerado: ${configRede} * * *"
echo ""

cat "${configRede}"
echo ""
