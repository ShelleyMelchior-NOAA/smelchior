. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump group: aircft aircar

set -x

cyc=12
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

# Check incoming args
test $# -ne 1 && echo "$0: <tmmark>"
test $# -ne 1 && exit

# compare 2 different date commands - diagnostic
cat /com/date/t${cyc}z
date +%Y%m%d

export PDY=$(cat /com/date/t${cyc}z | cut -d' ' -f3 | cut -c1-8)
#export PDY=20160809 # may need to hard set the date if /com/date/t12z has already been updated
tmmark=$1
if [ $tmmark -eq 00 ]; then
  network=nam
  CDATE=${PDY}${cyc}
else
  network=ndas
  PDY=$(sh /nwprod/util/ush/finddate.sh $PDY d+1)
  test $tmmark -eq 03 && CDATE=${PDY}09
  test $tmmark -eq 06 && CDATE=${PDY}06
  test $tmmark -eq 09 && CDATE=${PDY}03
  test $tmmark -eq 12 && CDATE=${PDY}00
fi

#workdir=/ptmpp1/$USER/dumpjb_aircraft.${PDY}${cyc}.$$  # use pid when doing testing
#workdir=/stmpp1/$USER/dumpjb_aircraft.${PDY}${cyc}
workdir=/stmpp2/$USER/dumpjb_aircraft.${PDY}${cyc}.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir

export TMPDIR=$workdir

export HOMEobsproc_dump=/nwprod/obsproc_dump.v3.3.0

#export LALO="F${HOMEobsproc_dump}/fix/nam_expdomain_halfdeg_imask.gbl"
export LALO=0

CRAD=3.25

export DUMP=/meso/save/$USER/svnwkspc/VS/obsproc_dump/ush/dumpjb
export CORX=/meso/save/$USER/svnwkspc/VS/obsproc_dump/exec/bufr_dupcor
export AIRX=/meso/save/$USER/svnwkspc/VS/obsproc_dump/exec/bufr_dupair
export EDTX=/meso/save/$USER/svnwkspc/VS/obsproc_dump/exec/bufr_edtbfr
export KEEP_NEARDUP_ACFT=YES
export obsproc_shared_bufr_dumplist_ver=v1.2.0
export HOMEobsproc_shared_bufr_dumplist=/nwprod/obsproc_shared/bufr_dumplist.v1.2.0
#export LIST=/meso/save/$USER/svnwkspc/bufr_dumplist.tkt97.dump-amdar-catchall-tanks/fix/bufr_dumplist

export DCOMROOT=/dcom
export TANK=${DCOMROOT}/us007003
#export TANK=/dcomdev/us007003

#$HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD aircft aircar
echo $DUMP $CDATE $CRAD aircft aircar
$DUMP $CDATE $CRAD aircft aircar

# copy aircar.ibm and aircft.ibm to name prep processing is expecting
# Depending on tmmark, the new name will include nam or ndas
mv $workdir/aircar.ibm $workdir/${network}.t${cyc}z.aircar.tm${tmmark}.bufr_d
mv $workdir/aircft.ibm $workdir/${network}.t${cyc}z.aircft.tm${tmmark}.bufr_d
export tstsp=$workdir/${network}.t${cyc}z.

mv $workdir/aircar.out $workdir/aircar.${network}.out
mv $workdir/aircft.out $workdir/aircft.${network}.out

# Generate cycle and tmmark specific J-job
if [ $network == nam ]; then
  local_template=/meso/save/$USER/svnwkspc/melchior/jobs/JNAM_PREP.template.ph2
  cp $local_template $workdir
  cd $workdir
  sed "s=XCCX=${cyc}=g;s=XTSTSPX=${tstsp}=;s=XPDYX=$PDY=" $local_template > bscript
elif [ $network == ndas ]; then
  local_template=/meso/save/$USER/svnwkspc/melchior/jobs/JNDAS_PREP.template
  cp $local_template $workdir
  cd $workdir
  sed "s=XCCX=${cyc}=g;s=XTMX=${tmmark}=g;s=XTSTSPX=${tstsp}=;s=XPDYX=$PDY=" $local_template > bscript
fi

# check that the dump files are all available
# once available, submit bscript; otherwise keep sleeping for 20s for 60 iterations (20  mins).
statusfl=/com/nam/prod/${network}.${PDY}/${network}.t${cyc}z.status.tm${tmmark}.bufr_d
i=1
while [ "$i" -ne 0 ]
do
  if [ -f ${statusfl} ]; then
    bsub < bscript
    i=0
  else
    echo "sleep 20"
    sleep 20
    i=$((i + 1))
    if [ "$i" -eq 60 ]; then break; fi
  fi
done

