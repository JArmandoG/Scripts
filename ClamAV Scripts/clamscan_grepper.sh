# USES:
# 1.- Run a clamscan and save it to clamscan_results.txt (Redirection or Tee)
# 2.- clamscan_grepper clamscan_results.txt > Find only "FOUND" results and also show the last summary
# Example:

clamscan_file=$1
grep FOUND $clamscan_file --color=always | grep -Evi 'omit|searches' | sed 's/omit-or-delete-results//' && echo && echo "------" && echo && tail $clamscan_file
