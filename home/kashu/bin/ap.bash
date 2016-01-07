#!/bin/bash
#Modified by: kashu
#Original: https://github.com/eexpress/eexp-bin/blob/master/ap.bash
#https://askubuntu.com/questions/180733/how-to-setup-an-access-point-mode-wi-fi-hotspot

#必须安装这两个软件包
#apt-fast install hostapd isc-dhcp-server
#if ! dpkg -l hostapd isc-dhcp-server &> /dev/null; then
#	sudo apt-get install -y hostapd isc-dhcp-server
#	dpkg -l hostapd isc-dhcp-server &> /dev/null || { echo "hostapd or isc-dhcp-server install failed"; exit 1; }
#fi

pgrep hostapd
s=$?
if [ $s -eq 0 ]; then
	t=启动; o=关闭; i='warning'
else
	t=关闭; o=开启; i='error'
fi

zenity --question --window-icon=$i --title="AP热点状态 - $t" --text=选择启动或关闭无线热点 --ok-label=$o --cancel-label="保持$t"
[ $? -eq 1 ] && exit

#切换模式
if [ $s -eq 0 ]; then
#    gksudo pkill hostapd
	zenity --password --title=输入sudo密码|sudo -S pkill hostapd
	msg AP热点 关闭
	exit
fi

#exit

#● ai hostapd dhcp3-server
iw list|grep '* AP'
[ $? -ne 0 ] && echo "No device support AP mode." && exit

zenity --password --title=输入sudo密码|sudo -S nmcli nm wifi off
sudo rfkill unblock wlan
sudo ifconfig wlan0 192.168.11.1 netmask 255.255.255.0
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -F
sudo iptables -t nat -A POSTROUTING -j MASQUERADE
sudo pkill -9 dhcpd

if [ ! -f /etc/apparmor.d/disable/usr.sbin.dhcpd ]; then
sudo ln -s /etc/apparmor.d/usr.sbin.dhcpd /etc/apparmor.d/disable/
sudo /etc/init.d/apparmor restart
fi

cat > /tmp/dhcpd.conf << EOF
default-lease-time 600;
max-lease-time 7200;
subnet 192.168.11.0 netmask 255.255.255.0
{
 range 192.168.11.100 192.168.11.110;
# OpenDNS
 option domain-name-servers 8.8.8.8;
 option domain-name-servers 8.8.4.4;
 option routers 192.168.11.1;
}
EOF
sudo dhcpd -4 wlan0 -cf /tmp/dhcpd.conf -pf /var/run/dhcp-server/dhcpd.pid

msg AP热点 开启

cat > /tmp/hostapd.conf << EOF
interface=wlan0
driver=nl80211
ssid=kashu
hw_mode=g
channel=10
# 如果需要开启密码，wpa=1
wpa=1
auth_algs=1
wpa_passphrase=password
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
EOF
sudo hostapd -d /tmp/hostapd.conf
