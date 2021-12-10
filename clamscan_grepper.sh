# USO:
# script.sh clamscan_fecha.txt
# Ejemplo:

clamscan_file=$1
grep FOUND $clamscan_file --color=always | grep -Evi 'omit|searches' | sed 's/omit-or-delete-results//' && echo && echo "------" && echo && tail -f $clamscan_file
