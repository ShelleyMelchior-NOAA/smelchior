set -x

# Set up $DATA based on this server
dir=chkbfr
this_srvr=$(hostname -s | cut -c1)
if [ "$this_srvr" = "g" ]; then     # WCOSS gyre
  DATA=/stmpp1/$USER/$dir
elif [ "$this_srvr" = "t" ]; then   # WCOSS tide
  DATA=/stmpp1/$USER/$dir
elif [ "$this_srvr" = "l" ]; then   # Cray luna
  DATA=/gpfs/hps/stmp/$USER/$dir
elif [ "$this_srvr" = "s" ]; then   # Cray surge
  DATA=/gpfs/hps/stmp/$USER/$dir
else
  echo "Unknown server!"
  exit
fi

module load prod_envir

mkdir -p $DATA
cd $DATA
err=$?
[ "$err" -eq '0' ]  && rm *

CHKX=$NWROOT/obsproc_dump.v3.2.1/exec/bufr_chkbfr
#CHKX=/gpfs/hps/emc/meso/noscrub/$USER/svn/obsproc_dump.tkt-351.crayport/exec/bufr_chkbfr


rc_chkbfr=0
echo "$NAME" > fort.30

PDY=20160620

cp -p $DCOMROOT/us007003/$PDY/b005/xx064 01_005.064
cp -p $DCOMROOT/us007003/$PDY/b005/xx065 02_005.065
cp -p $DCOMROOT/us007003/$PDY/b005/xx066 03_005.066

cat << ieof1 > chkbfr.in
01_005.064
02_005.065
03_005.066
ieof1

cat << ieof2 > fort.30
satwnd
ieof2

time -p $CHKX < chkbfr.in > chkbfr.out
RETG=$?
[ ! -s fort.60 ] && rc_chkbfr=99


echo "The return code for this program is $rc_chkbfr"

