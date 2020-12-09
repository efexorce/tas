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
	echo "S İ S T E M  M E N Ü S Ü "
	echo "---------------------------------"
	echo "1. SÜPER KULLANICI yetkileri al"


	echo "2. systemd-resolved Servisini aç"
	echo "3. DNS Önbelleğini Temizle(systemd-resolved açık olmalı)"

	echo "97. Edit system.sh(Bu program)"
	echo "98. Anamenüye dön"



	read -r -p "Seçiminizi yapınız [1-99] : " c
	# take action
	case $c in
		1) sudo echo "süper kullanıcı oldunuz"; pause;;
		
		2) echo; sudo systemctl enable systemd-resolved.service; pause;;
		3) echo; sudo systemd-resolve --flush-caches; pause;;

		97) gedit $BASEDIR/system.sh;;


		98) break;;
		*) Pause "Sadece 1-98 arasında seçim yapınız"
	esac
done




