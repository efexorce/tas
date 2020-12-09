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
	echo "K I S A Y O L L A R  M E N Ü S Ü "
	echo "---------------------------------"
	echo "1. SÜPER KULLANICI yetkileri al"

	echo "2. Son fotoyu gimp ile aç"

	echo "97. Edit shortcuts.sh(Bu program)"
	echo "98. Anamenüye dön"



	read -r -p "Seçiminizi yapınız [1-99] : " c
	# take action
	case $c in
		1) sudo echo "süper kullanıcı oldunuz"; pause;;
		2) gimp "`find ~/Resimler/ -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" "`" ;;


		97) gedit $BASEDIR/shortcuts.sh;;


		98) break;;
		*) Pause "Sadece 1-98 arasında seçim yapınız"
	esac
done




