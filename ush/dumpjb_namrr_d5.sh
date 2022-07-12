. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump group: aircft, aircar, goesnd

set -x

# Check incoming args
test $# -ne 3 && echo "$0: <cyc> <tmmark> <network>"
test $# -ne 3 && exit

cyc=$1
tmmark=$2
network=$3 # namrr 
pid=$$

# test if this is the prod machine
# pass in $pid
ushdir=/meso/save/$USER/svnwkspc/melchior/ush
sh $ushdir/devprodtest.sh ${pid}
returnfile=/stmpp1/$USER/devprodtest.${pid}.out
rc=$(cat $returnfile)
if [[ $rc != 0 ]]; then
  echo 'prod machine - exit'
  rm $returnfile
  exit
fi
rm $returnfile

# compare 2 different date commands - diagnostic
cat /com/date/t${cyc}z
now=$(date +%Y%m%d)

export PDY=$(cat /com/date/t${cyc}z | cut -d' ' -f3 | cut -c1-8)
#export PDY=20160117 # may need to hard set the date if /com/date/t00z has already been updated

# Test that the two dates are equal
# This test is a safeguard on the occasion that /com/date/t${cyc}z is delayed in being updated.
# This most particularly will affect 00Z and 12Z runs.
#if [ ${now} -ne ${PDY} ]; then
#  echo "/com/date/t${cyc}z has not yet been updated"
#  PDY=${now}
#fi

CDATE=${PDY}${cyc}
dumptime=$(/nwprod/util/exec/ndate -$tmmark $CDATE)

workdir=/stmpp1/$USER/dumpjb_namrr_d5_${network}.${PDY}${cyc}.${tmmark}.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir

export TMPDIR=$workdir

export HOMEobsproc_dump=/nwprod/obsproc_dump.v3.2.1

export LALO=0

CRAD=3.25

export obsproc_shared_bufr_dumplist_ver=v1.2.0
export HOMEobsproc_shared_bufr_dumplist=/nwprod/obsproc_shared/bufr_dumplist.v1.2.0

export DTIM_earliest_003002="-1.25"
export DTIM_latest_003002="-0.01"
export DTIM_earliest_003003="-0.50"
export DTIM_latest_003003="+0.50"

echo $HOMEobsproc_dump/ush/dumpjb $dumptime $CRAD aircft aircar goesnd
$HOMEobsproc_dump/ush/dumpjb $dumptime $CRAD aircft aircar goesnd

# copy *.ibm to name prep processing is expecting
mv $workdir/aircft.ibm $workdir/${network}.t${cyc}z.aircft.tm${tmmark}.bufr_d
mv $workdir/aircar.ibm $workdir/${network}.t${cyc}z.aircar.tm${tmmark}.bufr_d
mv $workdir/goesnd.ibm $workdir/${network}.t${cyc}z.goesnd.tm${tmmark}.bufr_d

export tstsp=$workdir/${network}.t${cyc}z.

mv $workdir/aircft.out $workdir/aircft.${network}.out
mv $workdir/aircar.out $workdir/aircar.${network}.out
mv $workdir/goesnd.out $workdir/goesnd.${network}.out

exit

