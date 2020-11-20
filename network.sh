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
 
loginbilgisi(){
echo "
https://efexorce.medium.com/best-logon-script-338ea4227832
"
}





while :
do



	clear
	echo "$(date)"
	echo "	     A Ğ  M E N Ü S Ü "
	echo "---------------------------------"
	echo "1. SÜPER KULLANICI yetkileri al"
	echo "2. İp adresim nedir"
	echo "3. Ağı(Network) baştan başlat(netplan apply)"
	echo "4. Ağ klasörünü bağla(mount)" 
	echo "5. Ağ klasörünü bırak(umount)" 
	echo "6. Login takibini başlat"
# https://efexorce.medium.com/best-logon-script-338ea4227832
	echo "7. Login takibi önerisi"

	
	echo "97. Edit network.sh(Bu program)"
	echo "98. Anamenüye dön"


	read -r -p "Seçiminizi yapınız [1-99] : " c
	# take action
	case $c in
		1) sudo echo "süper kullanıcı oldunuz"; pause;;
		2) echo; echo "Yerel ip adresiniz(LAN):$(tput setaf 1)" ; ip address | grep inet | grep -v 127.0.0.1 | grep -v inet6 | cut -d'/' -f1 |  sed 's/inet//' |  sed 's/ //g' ; echo "$(tput sgr0)Genel ip adresiniz(WAN):$(tput setaf 3)" ;  curl -s ipinfo.io/ip  ; echo "$(tput sgr0)İnternet Servis Sağlayıcınız(ISP):$(tput setaf 2)" ; curl -s ipinfo.io/org ; echo "$(tput sgr0)" ; pause;;
		3) sudo /etc/init.d/networking restart; sudo systemctl restart network; sudo netplan apply; pause;;

	

		4) echo;

if [ -z "$domain" ]
then
echo "Lütfen domain username pass bilgilerini settings.conf dosyasına yazınız";
gedit settings.conf;
else
echo $username olarak $domain ağına bağlanıyor; 
sudo mount -t cifs -o domain=$domain,username=$username,password=$pass $remotepath $localpath ;
fi

 pause; source settings.conf;;
		5) echo;echo $username olarak $domain ağından çıkılıyor; sudo umount $localpath ; pause;;
		6) echo; 

if [ -z "$logfile" ]
then
echo "Lütfen takip edilecek logfile bilgisini giriniz";
gedit settings.conf;
else
sudo echo "Login takibini yeni açılan pencereden takip edebilirsiniz.";
nohup sudo xfce4-terminal -e "tail -f -n 1000 $logfile" ;
fi	
pause;;
		7) loginbilgisi; pause;;
		97) gedit network.sh;;

		98) break;;
		*) Pause "Sadece 1-99 arasında seçim yapınız"
	esac
done
