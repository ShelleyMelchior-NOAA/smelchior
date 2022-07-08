. /u/Shelley.Melchior/.bashrc

#set -x

# run go_chkdat (or binv) on all bufr_d files in a defined /com directory
# must have go_chkdat and/or binv in $PATH

# Check incoming args; must have 1
test $# -lt 1 && echo "$0: <com directory>"
test $# -lt 1 && exit

# Assign incoming args
comdir=$1
pid=$$

echo "Running binv on all bufr_d files in:"
echo $comdir

for dumpfile in $comdir/*.bufr_d; do
  if [[ $dumpfile == *status* ]]; then
    continue
  fi
  echo "----- $(basename $dumpfile)"
  go_chkdat $dumpfile
  echo ""
done

exit
