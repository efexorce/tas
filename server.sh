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

while :
do
	clear
	echo "$(date)"
	echo " S U N U C U  M E N Ü S Ü "
	echo "---------------------------------"
	echo "1. SÜPER KULLANICI yetkileri al"

	echo "2. (SUNUCU)openvpn servisini durdur"
	echo "3. (SUNUCU)mongodb servisini durdur"
	echo "4. (SUNUCU)Apache2-httpd baştan başlat"
	echo "5. (SUNUCU)Loglara bak"

	echo "97. Edit server.sh(Bu program)"
	echo "98. Anamenüye dön"



	read -r -p "Seçiminizi yapınız [1-99] : " c
	# take action
	case $c in
		1) sudo echo "süper kullanıcı oldunuz"; pause;;

		2) echo; sudo service openvpn stop; pause;;
		3) echo; sudo service mongodb stop; pause;;
		4) sudo /etc/init.d/apache2 restart;sudo systemctl restart apache2;sudo /etc/init.d/httpd restart;sudo systemctl restart httpd;systemctl restart apache2.service;service httpd restart;systemctl restart httpd.service;apachectl -k restart; pause;;
		5) echo '*** /var/log/httpd/error_log:'; tail -n 10 /var/log/httpd/error_log;
		   echo; echo '*** /var/log/apache2/error.log:';tail -n 10 /var/log/apache2/error.log; 
		   echo; echo '*** /var/log/mysqld/error.log:';tail -n 10 /var/log/mysqld/error.log; 
		   echo; echo '*** /var/log/httpd/access_log:'; tail -n 10 /var/log/httpd/access_log;
		   echo; echo '*** /var/log/apache2/access.log:';tail -n 10 /var/log/apache2/access.log; 
		   echo; echo '*** /var/log/syslog(tail -n 10 /var/log/syslog):';tail -n 10 /var/log/syslog; 
		   echo; echo '*** Sistem Günlüğü(journalctl -xe):';journalctl -xe | tail -n 10; 
		   echo;  pause;;

		97) gedit $BASEDIR/server.sh;;
		98) break;;
		*) Pause "Sadece 1-98 arasında seçim yapınız"
	esac
done




