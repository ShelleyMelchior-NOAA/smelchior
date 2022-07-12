. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump group: 1bamua, 1bmhs, gpsro, mtiasi, esamua, eshrs3, sevcsr, atms

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
export PDY=20160330 # may need to hard set the date if /com/date/t00z has already been updated

# Test that the two dates are equal
# This test is a safeguard on the occasion that /com/date/t${cyc}z is delayed in being updated.
# This most particularly will affect 00Z and 12Z runs.
#if [ ${now} -ne ${PDY} ]; then
#  echo "/com/date/t${cyc}z has not yet been updated"
#  PDY=${now}
#fi

CDATE=${PDY}${cyc}
dumptime=$(/nwprod/util/exec/ndate -$tmmark $CDATE)

workdir=/stmpp1/$USER/dumpjb_namrr_d1_${network}.${PDY}${cyc}.${tmmark}.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir

export TMPDIR=$workdir

export HOMEobsproc_dump=/nwprod/obsproc_dump.v3.2.1

export LALO="F${HOMEobsproc_dump}/fix/nam_expdomain_halfdeg_imask.gbl"

#CRAD=1.0
CRAD=0.5

export obsproc_shared_bufr_dumplist_ver=v1.2.0
export HOMEobsproc_shared_bufr_dumplist=/nwprod/obsproc_shared/bufr_dumplist.v1.2.0

export DTIM_earliest_1bamua="-1.00"
export DTIM_latest_1bamua="+0.99"
export DTIM_earliest_1bmhs="-1.00"
export DTIM_latest_1bmhs="+0.99"
export DTIM_earliest_atms="-1.00"
export DTIM_latest_atms="+0.99"
export DTIM_earliest_mtiasi="-1.00"
export DTIM_latest_mtiasi="+0.99"

echo $HOMEobsproc_dump/ush/dumpjb $dumptime $CRAD 1bamua 1bmhs gpsro mtiasi esamua eshrs3 sevcsr atms
$HOMEobsproc_dump/ush/dumpjb $dumptime $CRAD 1bamua 1bmhs gpsro mtiasi esamua eshrs3 sevcsr atms

# copy *.ibm to name prep processing is expecting
mv $workdir/1bamua.ibm $workdir/${network}.t${cyc}z.1bamua.tm${tmmark}.bufr_d
mv $workdir/1bmhs.ibm $workdir/${network}.t${cyc}z.1bmhs.tm${tmmark}.bufr_d
mv $workdir/gpsro.ibm $workdir/${network}.t${cyc}z.gpsro.tm${tmmark}.bufr_d
mv $workdir/mtiasi.ibm $workdir/${network}.t${cyc}z.mtiasi.tm${tmmark}.bufr_d
mv $workdir/esamua.ibm $workdir/${network}.t${cyc}z.esamua.tm${tmmark}.bufr_d
mv $workdir/eshrs3.ibm $workdir/${network}.t${cyc}z.eshrs3.tm${tmmark}.bufr_d
mv $workdir/sevcsr.ibm $workdir/${network}.t${cyc}z.sevcsr.tm${tmmark}.bufr_d
mv $workdir/atms.ibm $workdir/${network}.t${cyc}z.atms.tm${tmmark}.bufr_d
export tstsp=$workdir/${network}.t${cyc}z.

mv $workdir/1bamua.out $workdir/1bamua.${network}.out
mv $workdir/1bmhs.out $workdir/1bmhs.${network}.out
mv $workdir/gpsro.out $workdir/gpsro.${network}.out
mv $workdir/mtiasi.out $workdir/mtiasi.${network}.out
mv $workdir/esamua.out $workdir/esamua.${network}.out
mv $workdir/eshrs3.out $workdir/eshrs3.${network}.out
mv $workdir/sevcsr.out $workdir/sevcsr.${network}.out
mv $workdir/atms.out $workdir/atms.${network}.out

exit

