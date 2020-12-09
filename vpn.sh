#!/bin/bash
# Amaç: Menü kullanarak çeşitli seçeneklerle Sistemi yönetmek
# Proje: Terminal Asistan Script (tas)
# Yazar: Mustafa ÜLKER > GPL v3.0+ Lisanslı
# ---------------------------------------------------------------------------
#  CTRL+C, CTRL+Z and quit trap kullanırlar
trap '' SIGINT
trap ''  SIGQUIT
trap '' SIGTSTP

BASEDIR=$(dirname "$0")
echo "$BASEDIR"
source $BASEDIR/settings.conf

pause(){
	local m="$@"
	echo "$m"
	read -p "Devam Etmek için [Enter] tuşuna basınız..." key
}
 
openvpnconfigfile(){
echo "
#(PfSense VPN menüsünde OpenVPN/Client Export Utility) sekmesindeki#
#.ovpn dosyasını home klasörünüze indiriniz. örnek:/home/user/vpnconfig.ovpn#
dev tun
persist-tun
persist-key
cipher AES-128-CBC
ncp-ciphers AES-128-GCM
auth SHA256
tls-client
client
resolv-retry infinite
remote <firma_ip> 1194 udp
lport 0
auth-user-pass auth.txt
remote-cert-tls server
compress 
#ayarları, #ca sertifika otoritesi, #cert sertifikası burada yer alır
#ve key bilgisi burda yer alır # 2048 bit OpenVPN static key
"
}


authconfigfile(){
echo "
#içinde kullanıcı adı ve parolam yazmaktadır#
#vpnconfig.ovpn içinden otomatik çağırılmaktadır#
#auth.txt(Home klasörünüzde olmalı örnek:/home/user/)#
username
password
"
}





while :
do



	clear
	echo "$(date)"
	echo "	     V P N  M E N Ü S Ü "
	echo "---------------------------------"
	echo "1. SÜPER KULLANICI yetkileri al"

	echo "2. OPENVPN ile bağlan"
	echo "3. OPENVPN bağlantısını öldür"
	echo "4. openvpnconfig.ovpn Bilgisi"
	echo "5. auth.txt Bilgisi"

	echo "97. Edit vpn.sh(Bu program)"
	echo "98. Anamenüye dön"



	read -r -p "Seçiminizi yapınız [1-99] : " c
	# take action
	case $c in
		1) sudo echo "süper kullanıcı oldunuz"; pause;;
		2) echo; sudo su; nohup sudo xfce4-terminal -e "sudo openvpn vpnconfig.ovpn" &;;
		3) echo; sudo killall openvpn; pause;;
		4) openvpnconfigfile; pause;;
		5) authconfigfile; pause;;







		97) gedit $BASEDIR/vpn.sh;;


		98) break;;
		*) Pause "Sadece 1-98 arasında seçim yapınız"
	esac
done




