#!/bin/bash
# Amaç: Menü kullanarak çeşitli seçeneklerle Sistemi yönetmek
# Proje: Terminal Asistan Script (tas)
# Yazar: Mustafa ÜLKER > GPL v3.0+ Lisanslı
# ---------------------------------------------------------------------------
#  CTRL+C, CTRL+Z and quit trap kullanırlar


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
	echo "1. (SUNUCU)Servisleri Listele"
	echo "2. (SUNUCU)Servis Status"
	echo "3. (SUNUCU)Servis Restart"
	echo "4. (SUNUCU)Servis Stop"
	echo "5. (SUNUCU)Servis Start"
	echo "6. (SUNUCU)Loglara bak"

	echo "7. (SUNUCU)Dinlenen TCP Portlar"
	echo "8. (SUNUCU)Dinlenen UDP Portlar"




	echo "97. Edit server.sh(Bu program)"
	echo "98. Anamenüye dön"



	read -r -p "Seçiminizi yapınız  : " c
	# take action
	case $c in

		
		1) echo; sudo systemctl --type=service; pause;;
		2) echo; read -r -p "Hangi servisin durumuna bakılacak:" d 
			case $d in 
				$d) echo; sudo service $d status;
			esac
 			pause;;

		3) echo; read -r -p "Baştan başlatılacak servisi giriniz:" d 
			case $d in 
				$d) echo; sudo service $d restart; 
			esac
 			pause;;

		4) echo; read -r -p "Durdurulacak servisi giriniz:" d 
			case $d in 
				$d) echo; sudo service $d stop; 
			esac
 			pause;;
		5) echo; read -r -p "Başlatılacak servisi giriniz:" d 
			case $d in 
				$d) echo; sudo service $d start; 
			esac
 			pause;;
		6) echo; read -r -p "Hangi servisin loglarına bakılacak:" d 
			case $d in 
				$d) echo; sudo journalctl -u $d -f;  			pause;;

			esac
 			pause;;
		7) echo; sudo netstat -plnt; pause;;
		8) echo; sudo netstat -plnu; pause;;
		
		97) gedit $BASEDIR/server.sh;;
		98) break;;
		*) Pause "Sadece 1-98 arasında seçim yapınız";
	esac
done




