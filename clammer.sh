# Clamscan recursively on folder at argument 1, and save file as "clamscan_(Today's date).txt"
scan_folder=$1
date_stamp=$(date +"%d%m%y")
file_name="clamscan_$date_stamp.txt"

if [ $# -lt 1 ];
    then echo "[!] Usage: $0 + [folder to scan recursively]" && exit 1
fi

if [ -f $file_name ]; then
		echo
		echo "[!] Out_file \"$file_name\" already exists. Please rename it" && exit 1
		echo
else
		clamscan -r $1 | tee $file_name
		echo
		echo [+] Scan saved as $PWD/$file_name
		echo
fi
