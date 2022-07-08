. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump groups: proflr, vadwnd

set -x

# Determine server and make appropriate settings
server=$(echo $HOSTNAME | cut -c1)
if [ "$server" = "m" -o "$server" = "v" ]; then
  # Dell ph3: mars venus
  module load ips/18.0.1.163
  module load prod_util/1.1.0
  module load prod_envir/1.1.0
  comroot=/gpfs/dell1/nco/ops/com
  stmp=/gpfs/dell2/stmp
  export HOMEobsproc_dump=/gpfs/dell1/nco/ops/nwprod/obsproc_dump.v5.0.3
# export HOMEobsproc_shared_bufr_dumplist=/gpfs/dell1/nco/ops/nwprod/obsproc_shared/bufr_dumplist.v2.1.0
# DB: obsproc_shared_bufr_dumplist.iss59814.vadwnd
  export HOMEobsproc_shared_bufr_dumplist=/gpfs/dell2/emc/obsproc/noscrub/$USER/gitwkspc/EMC_obsproc_shared_bufr_dumplist
elif [ "$server" = "l" -o "$server" = "s" ]; then
  # Cray: luna surge
  [ -d /opt/modules ] && . /opt/modules/default/init/sh > /dev/null 2>&1
  module load prod_envir
  module load prod_util
  module load cfp-intel-sandybridge/1.1.0
  comroot=/gpfs/hps/nco/ops/com
  stmp=/gpfs/hps3/stmp
  export HOMEobsproc_dump=/gpfs/hps/nco/ops/nwprod/obsproc_dump.v5.0.3
# export HOMEobsproc_shared_bufr_dumplist=/gpfs/hps/nco/ops/nwprod/obsproc_shared/bufr_dumplist.v1.5.0
# DB: obsproc_shared_bufr_dumplist.iss59814.vadwnd
  export HOMEobsproc_shared_bufr_dumplist=/gpfs/hps3/emc/meso/noscrub/Shelley.Melchior/git/EMC_obsproc_shared_bufr_dumplist
else
  echo "Invalid server - EXITING!"
  exit
fi

# Check incoming args; must have 2, but 3rd is optional to run in backfill mode
test $# -lt 2 && echo "$0: <cyc> <network> (makeup PDY)"
test $# -lt 2 && exit

cyc=$1
network=$2 # gdas,gfs,rap,nam
pid=$$

# test if this is the prod machine
# pass in $pid
: <<'SKIP'
ushdir=/gpfs/dell2/emc/obsproc/noscrub/$USER/gitstatic/ush
sh $ushdir/devprodtest.sh ${pid}
returnfile=/gpfs/dell2/stmp/$USER/devprodtest.${pid}.out
rc=$(cat $returnfile)
if [[ $rc != 0 ]]; then
  echo 'prod machine - exit'
  rm $returnfile
  exit
fi
rm $returnfile
SKIP

# compare 2 different date commands - diagnostic
cat $comroot/date/t${cyc}z
now=$(date +%Y%m%d)

export PDY=$(cat $comroot/date/t${cyc}z | cut -d' ' -f3 | cut -c1-8)
if [ ! -z "$3" ]
then
  export PDY=$3  # PDY setting when running in backfill mode
fi
#export PDY=20160117 # may need to hard set the date if /com/date/t00z has already been updated

# Test that the two dates are equal
# This test is a safeguard on the occasion that /com/date/t${cyc}z is delayed in being updated.
# This most particularly will affect 00Z and 12Z runs.
#if [ ${now} -ne ${PDY} ]; then
#  echo "/com/date/t${cyc}z has not yet been updated"
#  PDY=${now}
#fi

tmmark=00
CDATE=${PDY}${cyc}

workdir=$stmp/$USER/dumpjb_proflrvadwnd_${network}.${PDY}${cyc}.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir

export TMPDIR=$workdir

# Set LALO, CRAD, DTIM
if [ "$network" = "gfs" -o "$network" = "gdas" ]; then
  export LALO=0
  CRAD=3.0
  export DTIM_earliest_proflr="-4.00"
  export DTIM_latest_proflr="+3.99"
  export DTIM_latest_vadwnd="+2.99"
elif [ "$network" = "rap" ]; then
  export LALO=F/gpfs/hps/nco/ops/nwprod/obsproc_dump.v5.0.3/fix/nam_expdomain_halfdeg_imask.gbl 
  CRAD=0.5
  export DTIM_earliest_proflr="-1.50"
  export DTIM_latest_proflr="+1.50"
  export DTIM_earliest_vadwnd="-1.00"
  export DTIM_latest_vadwnd="+1.00"
elif [ "$network" = "nam" ]; then
  export LALO=F/gpfs/dell1/nco/ops/nwprod/obsproc_dump.v5.0.3/fix/nam_expdomain_halfdeg_imask.gbl 
  CRAD=0.5
  export DTIM_earliest_proflr="-2.50"
  export DTIM_latest_proflr="+2.50"
  export DTIM_earliest_vadwnd="-0.75"
  export DTIM_latest_vadwnd="+1.50"
else
  echo " network must be gdas, gfs, rap, or nam - EXIT!"
  exit
fi

# Dump proflr & vadwnd tanks
export TANK=$DCOMROOT/prod
export TANK_002018=$DCOMROOT/dev
export TANK_002014=$DCOMROOT/dev

# RUN IT!
echo $HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD proflr vadwnd
$HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD proflr vadwnd


# cp proflr.ibm and vadwnd.ibm to /com location from which dump archive can retrieve the files
# use filename format GSI is expecting
outdir=$stmp/$USER/com_proflrvadwnd/prod/${2}.${PDY}/${1}
mkdir -p $outdir
cp $workdir/proflr.ibm ${outdir}/${2}.t${1}z.proflr.tm00.bufr_d
cp $workdir/vadwnd.ibm ${outdir}/${2}.t${1}z.vadwnd.tm00.bufr_d

exit

#---------------------------------------------------------------

# copy msonet.ibm to name prep processing is expecting
mv $workdir/msonet.ibm $workdir/${network}.t${cyc}z.msonet.tm${tmmark}.bufr_d
export tstsp=$workdir/${network}.t${cyc}z.

mv $workdir/msonet.out $workdir/msonet.${network}.out

# copy msonet dump file to noscrub
noscrub=/meso/noscrub/$USER/com/${network}/prod/${network}.${PDY}
if [ ! -d $noscrub ]; then mkdir -p $noscrub; fi
cp $workdir/${network}.t${cyc}z.msonet.tm${tmmark}.bufr_d $noscrub/${network}.t${cyc}z.msonet.tm${tmmark}.bufr_d
chgrp rstprod $noscrub/${network}.t${cyc}z.msonet.tm${tmmark}.bufr_d
chmod 640 $noscrub/${network}.t${cyc}z.msonet.tm${tmmark}.bufr_d

# Generate cycle and tmmark specific J-job
if [ $network = "rtma" ]; then
  local_template=/meso/save/$USER/svnwkspc/melchior/jobs/JRTMA_PREP.template
else
  local_template=/meso/save/$USER/svnwkspc/melchior/jobs/JURMA_PREP.template
fi
cp $local_template $workdir
cd $workdir
#  sed "s/XCCX/${cyc}/;s/XTSTSPX/${tstsp}/" $local_template > bscript
sed "s=XCCX=${cyc}=g;s=XTSTSPX=${tstsp}=;s=XPDYX=$PDY=" $local_template > bscript
# check that the dump files are all available
# once available, submit bscript; otherwise keep sleeping for 20s for 60 iterations (20 mins).
statusfl=/com2/${network}/prod/${network}.${PDY}/${network}.t${cyc}z.status.tm${tmmark}.bufr_d
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

