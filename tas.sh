while :
do
	clear
	echo "1. Tarih"
	echo "2. Çıkış"
read -r -p  "1-2 arasında bir seçim yapınız: " c


	case $c in
1) echo "$(date)"; read -p "Devam Etmek için [Enter] tuşuna basınız..." key;;
2) break;;
	esac
done
