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
 
versionbilgisi(){
echo "
Versiyon Bilgileri github üzerinde takip edilmektedir.
"
	

}





while :
do



	#clear
	echo "$(date)"
	echo "	     A N A  M E N U "
	echo "---------------------------------"
	echo "1. SÜPER KULLANICI yetkileri al"
	echo "2. İp adresim nedir"
	echo "3. Ağı(Network) baştan başlat(netplan apply)"

	echo "10. OPENVPN ile bağlan"
	echo "11. Mount edilecekler - 111. umount et" 
	echo "12. Login takibi"
	echo "13. OPENVPN bağlantısını öldür"
	echo "14. Son fotoyu gimp ile aç"

	echo "21. gedit kurulumunu yap"
	echo "22. flameshot kurulumunu yap"
	echo "23. net-tools(ifconfig) kurulumunu yap"
	echo "24. gimp kurulumunu yap"
	echo "25. openvpn kurulumunu yap"
	echo "26. dnsutils(dig) kurulumunu yap"


	echo "31. systemd-resolved Servisini aç"
	echo "32. DNS Önbelleğini Temizle(systemd-resolved açık olmalı)"

	echo "81. (SUNUCU)openvpn servisini durdur"
	echo "82. (SUNUCU)mongodb servisini durdur"
	echo "83. (SUNUCU)Apache2-httpd baştan başlat"
	echo "84. (SUNUCU)Loglara bak"

	echo "97. Edit tas.sh(Bu program)"
	echo "98. Versiyon Bilgisi"
	echo "99. Çıkış"

	read -r -p "Seçiminizi yapınız [1-99] : " c
	# take action
	case $c in
		1) sudo echo "süper kullanıcı oldunuz"; pause;;
		2) echo; echo "Yerel ip adresiniz(LAN):$(tput setaf 1)" ; ip address | grep inet | grep -v 127.0.0.1 | grep -v inet6 | cut -d'/' -f1 |  sed 's/inet//' |  sed 's/ //g' ; echo "$(tput sgr0)Genel ip adresiniz(WAN):$(tput setaf 3)" ;  curl -s ipinfo.io/ip  ; echo "$(tput sgr0)İnternet Servis Sağlayıcınız(ISP):$(tput setaf 2)" ; curl -s ipinfo.io/org ; echo "$(tput sgr0)" ; pause;;
		3) sudo /etc/init.d/networking restart; sudo systemctl restart network; sudo netplan apply; pause;;

		10) echo; nohup sudo xfce4-terminal -e "sudo openvpn vpnconfig.ovpn" &;;

#######vpnconfig.ovpn######
#dev tun
#persist-tun
#persist-key
#cipher AES-128-CBC
#ncp-ciphers AES-128-GCM
#auth SHA256
#tls-client
#client
#resolv-retry infinite
#remote <firma_ip> 1194 udp
#lport 0
#auth-user-pass auth.txt
#remote-cert-tls server
#compress 
# ayarları ve aşağıdaki sertifikalar
#ca
#cert
#key
# 2048 bit OpenVPN static key
#############################

########auth.txt############
# içinde kullanıcı adı ve parolam yazıyor onu da ordan otomatik çekiyor
############################

		11) echo;echo $username olarak $domain ağına bağlanıyor; sudo mount -t cifs -o domain=$domain,username=$username,password=$pass $remotepath $localpath ; pause;;
		111) echo;echo $username olarak $domain ağından çıkılıyor; sudo umount $localpath ; pause;;
		12) echo; nohup sudo xfce4-terminal -e "tail -f -n 1000 $logfile" &;;
		13) echo; sudo killall openvpn; pause;;
		14) gimp "`find ~/Resimler/ -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" "`" ;;

		21) echo; sudo apt install gedit;;
		22) echo; sudo apt install flameshot;;
		23) echo; sudo apt install net-tools;;
		24) echo; sudo apt install gimp;;
		25) echo; sudo apt install openvpn;;
		26) echo; sudo apt-get install dnsutils;;
		
		31) echo; sudo systemctl enable systemd-resolved.service; pause;;
		32) echo; sudo systemd-resolve --flush-caches; pause;;

		81) echo; sudo service openvpn stop; pause;;
		82) echo; sudo service mongodb stop; pause;;
		83) sudo /etc/init.d/apache2 restart;sudo systemctl restart apache2;sudo /etc/init.d/httpd restart;sudo systemctl restart httpd;systemctl restart apache2.service;service httpd restart;systemctl restart httpd.service;apachectl -k restart; pause;;
		84) echo '*** /var/log/httpd/error_log:'; tail -n 10 /var/log/httpd/error_log;
		   echo; echo '*** /var/log/apache2/error.log:';tail -n 10 /var/log/apache2/error.log; 
		   echo; echo '*** /var/log/mysqld/error.log:';tail -n 10 /var/log/mysqld/error.log; 
		   echo; echo '*** /var/log/httpd/access_log:'; tail -n 10 /var/log/httpd/access_log;
		   echo; echo '*** /var/log/apache2/access.log:';tail -n 10 /var/log/apache2/access.log; 
		   echo; echo '*** /var/log/syslog(tail -n 10 /var/log/syslog):';tail -n 10 /var/log/syslog; 
		   echo; echo '*** Sistem Günlüğü(journalctl -xe):';journalctl -xe | tail -n 10; 
		   echo;  pause;;

		97) gedit ~/tas/tas.sh;;
		98) versionbilgisi; pause;;
		99) break;;
		*) Pause "Sadece 1-99 arasında seçim yapınız"
	esac
done
