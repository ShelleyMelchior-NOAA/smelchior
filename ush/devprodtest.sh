# test if this is the prod machine
host=$(hostname -s | cut -c1)

# set up temp space based on machine
if [ "$host" = v -o "$host" = m ] ;    # Dell
then
  tmpdir=/gpfs/dell2/stmp/${USER}
elif [ "$host" = s -o "$host" = l ] ;  # Cray
then
  tmpdir=/gpfs/hps3/stmp/${USER}
else                                   # IBM ph2
  tmpdir=/stmpp1/${USER}
fi

#: <<"IGNORE"
testdev=$(cat /etc/dev | cut -c1)
testprod=$(cat /etc/prod | cut -c1)
if test "$host" = "$testdev"
then
  echo "$host is the dev machine."
  if [ -z $1 ]; then
    echo "0" > ${tmpdir}/devprodtest.out
  else
    echo "0" > ${tmpdir}/devprodtest.$1.out
  fi
else
  echo "$host is the prod machine."
  echo "ABORT - only run on dev machine"
  if [ -z $1 ]; then
    echo "1" > ${tmpdir}/devprodtest.out
  else
    echo "1" > ${tmpdir}/devprodtest.$1.out
  fi
  exit
fi
#IGNORE


