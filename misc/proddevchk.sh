# Check if this is the prod or dev machine
# Exit if prod machine
host=$(echo $SITE | cut -c1 | awk '{print tolower($0)}')
dev=$(cat /etc/dev | cut -c1)
prod=$(cat /etc/prod | cut -c1)
if test "$host" = "$prod"
then
  echo "$host is prod machine"
  echo "ABORT"
  exit
fi
echo "end proddevchk.sh"
