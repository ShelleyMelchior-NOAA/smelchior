. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump group: proflr, rassda, sfcshp, adpsfc, ascatt

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

workdir=/stmpp1/$USER/dumpjb_namrr_d3_${network}.${PDY}${cyc}.${tmmark}.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir

export TMPDIR=$workdir

export HOMEobsproc_dump=/nwprod/obsproc_dump.v3.2.1

export LALO="F${HOMEobsproc_dump}/fix/nam_expdomain_halfdeg_imask.gbl"

CRAD=0.5

export obsproc_shared_bufr_dumplist_ver=v1.2.0
export HOMEobsproc_shared_bufr_dumplist=/nwprod/obsproc_shared/bufr_dumplist.v1.2.0

export DTIM_earliest_proflr="-1.50"
export DTIM_latest_proflr="+1.50"

export SKIP_002013=YES
export SKIP_000002=YES

echo $HOMEobsproc_dump/ush/dumpjb $dumptime $CRAD proflr rassda sfcshp adpsfc ascatt
$HOMEobsproc_dump/ush/dumpjb $dumptime $CRAD proflr rassda sfcshp adpsfc ascatt

# copy *.ibm to name prep processing is expecting
mv $workdir/proflr.ibm $workdir/${network}.t${cyc}z.proflr.tm${tmmark}.bufr_d
mv $workdir/rassda.ibm $workdir/${network}.t${cyc}z.rassda.tm${tmmark}.bufr_d
mv $workdir/sfcshp.ibm $workdir/${network}.t${cyc}z.sfcshp.tm${tmmark}.bufr_d
mv $workdir/adpsfc.ibm $workdir/${network}.t${cyc}z.adpsfc.tm${tmmark}.bufr_d
mv $workdir/ascatt.ibm $workdir/${network}.t${cyc}z.ascatt.tm${tmmark}.bufr_d
export tstsp=$workdir/${network}.t${cyc}z.

mv $workdir/proflr.out $workdir/proflr.${network}.out
mv $workdir/rassda.out $workdir/rassda.${network}.out
mv $workdir/sfcshp.out $workdir/sfcshp.${network}.out
mv $workdir/adpsfc.out $workdir/adpsfc.${network}.out
mv $workdir/ascatt.out $workdir/ascatt.${network}.out

exit

