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
	clear
	echo "$(date)"
	echo "	     A N A  M E N U "
	echo "---------------------------------"
	echo "1. SÜPER KULLANICI yetkileri al"
	echo "2. Ağ menüsünü aç"
	echo "3. VPN menüsünü aç"
	echo "4. Kurulacak Programlar"
	echo "5. Kullanıcı kısayolları"
	echo "6. Sistem kısayolları"
	echo "7. SUNUCU kısayolları"

	echo "97. Edit start.sh(Bu program)"
	echo "98. Versiyon Bilgisi"
	echo "99. Çıkış"

	read -r -p "Seçiminizi yapınız [1-99] : " c
	# take action
	case $c in
		1) sudo echo "süper kullanıcı oldunuz"; pause;;
		2) echo; bash $BASEDIR/network.sh ;;
		3) echo; sh $BASEDIR/vpn.sh ;;
		4) echo; sh $BASEDIR/applications.sh ;;
		5) echo; sh $BASEDIR/shortcuts.sh ;;
		6) echo; sh $BASEDIR/system.sh ;;
		7) echo; sh $BASEDIR/server.sh ;;

		97) gedit $BASEDIR/start.sh;;
		98) versionbilgisi; pause;;
		99) break;;
		*) Pause "Sadece 1-99 arasında seçim yapınız"
	esac
done
