# USO:
# script.sh clamscan_fecha.txt
# Ejemplo:

clamscan_file=$1
grep FOUND $clamscan_file --color=always | grep -Evi 'eicar|embedded|exploitdb|httpd' | sed 's/MetasploitPayload/Payload/' && echo && echo "------" && echo && tail -f $clamscan_file
