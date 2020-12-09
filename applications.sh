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
	echo "U Y G U L A M A L A R  M E N Ü S Ü "
	echo "---------------------------------"
	echo "1. SÜPER KULLANICI yetkileri al"

	echo "2. gedit kurulumunu yap"
	echo "3. curl kurulumunu yap"

	echo "4. flameshot kurulumunu yap"
	echo "5. net-tools(ifconfig) kurulumunu yap"
	echo "6. gimp kurulumunu yap"
	echo "7. openvpn kurulumunu yap"
	echo "8. dnsutils(dig) kurulumunu yap"


	echo "97. Edit applications.sh(Bu program)"
	echo "98. Anamenüye dön"



	read -r -p "Seçiminizi yapınız [1-99] : " c
	# take action
	case $c in
		1) sudo echo "süper kullanıcı oldunuz"; pause;;
		2) echo; echo y | sudo apt install gedit;;
		3) echo; echo y |  sudo apt install gedit;;

		4) echo; echo y |  sudo apt install flameshot;;
		5) echo; echo y |  sudo apt install net-tools;;
		6) echo; echo y |  sudo apt install gimp;;
		7) echo; echo y |  sudo apt install openvpn;;
		8) echo; echo y |  sudo apt-get install dnsutils;;




		97) gedit $BASEDIR/applications.sh;;


		98) break;;
		*) Pause "Sadece 1-98 arasında seçim yapınız"
	esac
done




