. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump group: mtiasi 

set -x

# Check incoming args; must have 2, but 3rd is optional to run in backfill mode
test $# -lt 2 && echo "$0: <cyc> <network> (makeup) (tmhr)"
test $# -lt 2 && exit

cyc=$1
network=$2 # gdas,gfs,rap
pid=$$

userROOT=/gpfs/dell2/emc/obsproc/noscrub/$USER

# Only run on dev machine
echo "begin source"
. ${userROOT}/gitstatic/ush/devprodtest.sh $$
echo "end source"

# source moduleload file
. $userROOT/gitstatic/fix/moduleload

# compare 2 different date commands - diagnostic
cat $COMROOT/date/t${cyc}z
now=$(date +%Y%m%d)

export PDY=$(cat $COMROOT/date/t${cyc}z | cut -d' ' -f3 | cut -c1-8)
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

CDATE=${PDY}${cyc}

if [ ! -z "$4" ]
then
  tmhr=$4   # only required for nam catchup cycles
else
  tmhr=00
fi
export tmmark="tm${tmhr}"

workdir=/gpfs/dell2/stmp/$USER/dumpjb_mtiasi_${network}.${PDY}${cyc}.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir

export TMPDIR=$workdir

export HOMEobsproc_dump=$NWROOT/obsproc_dump.v5.1.0
# !!! Make sure git work space is in correct branch !!!
# Pointing to git DB EMC_obsproc_dump: obsproc_dump.tkt-222.TAC2BUFR_SYNOP
#export HOMEobsproc_dump=/gpfs/gd1/emc/meso/save/$USER/gitwkspc/EMC_obsproc_dump

# Set LALO, CRAD, and DTIM per network
if [ "$network" = "gfs" -o "$network" = "gdas" ]; then
  export LALO=0
  CRAD=3.0
  DTIM_latest_mtiasi=${DTIM_latest_mtiasi:-"+2.99"}
elif [ "$network" = "rap" -o "$network" = "rap_e" ]; then
  export LALO=F/gpfs/hps/nco/ops/nwprod/obsproc_dump.v5.1.0/fix/nam_expdomain_halfdeg_imask.gbl 
  CRAD=3.0
  DTIM_earliest_mtiasi=${DTIM_earliest_mtiasi:-"-2.00"}  # rap, rap_e
  DTIM_latest_mtiasi=${DTIM_latest_mtiasi:-"+1.99"}      # rap, rap_e
elif [ "$network" = "rap_p" ]; then
  export LALO=F/gpfs/hps/nco/ops/nwprod/obsproc_dump.v5.1.0/fix/nam_expdomain_halfdeg_imask.gbl
  CRAD=1.0
  DTIM_earliest_mtiasi=${DTIM_earliest_mtiasi:-"-1.00"}  # rap_p
  DTIM_latest_mtiasi=${DTIM_latest_mtiasi:-"+0.99"}      # rap_p
elif [ "$network" = "nam" ]; then
  export LALO=F/gpfs/hps/nco/ops/nwprod/obsproc_dump.v5.1.0/fix/nam_expdomain_halfdeg_imask.gbl 
  CRAD=0.5
  if [ "$tmhr" = "00" ]; then
    DTIM_earliest_mtiasi=${DTIM_earliest_mtiasi:-"-0.75"}  # tm00
    DTIM_latest_mtiasi=${DTIM_latest_mtiasi:-"+1.50"}      # tm00
  else
    DTIM_earliest_mtiasi=${DTIM_earliest_mtiasi:-"-1.00"}  # tm01-tm06
    DTIM_latest_mtiasi=${DTIM_latest_mtiasi:-"+0.99"}      # tm01-tm06
  fi
elif [ "$network" = "cdas" ]; then
  export LALO=0
  CRAD=3.0
  DTIM_latest_mtiasi=${DTIM_latest_mtiasi:-"+2.99"}
else
  echo " network must be gdas, gfs, rap, nam, or cdas - EXIT!"
  exit
fi

export obsproc_shared_bufr_dumplist_ver=v2.3.0
export HOMEobsproc_shared_bufr_dumplist=$NWROOT/obsproc_shared/bufr_dumplist.$obsproc_shared_bufr_dumplist_ver
# !!! Make sure git works psace is in correct branch !!!
# Pointing to git DB EMC_obsproc_shared_bufr_dumplist: obsproc_shared_bufr_dumplist.tkt-222.TAC2BUFR_SYNOP
#export HOMEobsproc_shared_bufr_dumplist=/gpfs/gd1/emc/meso/save/Shelley.Melchior/gitwkspc/EMC_obsproc_shared_bufr_dumplist

# Sudhir's tank
#export TANK_021241=/gpfs/dell2/emc/obsproc/noscrub/Sudhir.Nadiga/DCOMDIR/NON_CRON/DEV_INGEST/prod

echo $HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD mtiasi
$HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD mtiasi

exit

# copy gpsro.ibm to GDA pick up location
GDApickupdir=/gpfs/dell2/emc/obsproc/noscrub/$USER/forKH/gpsro/${network}x.$PDY/${cyc}
cp $workdir/gpsro.ibm ${GDApickupdir}/${network}.t${cyc}z.gpsro.${tmmark}.bufr_d

exit

export tstsp=$workdir/${network}.t${cyc}z.

mv $workdir/msonet.out $workdir/msonet.${network}.out

# copy msonet dump file to noscrub
noscrub=/meso/noscrub/$USER/com/${network}/prod/${network}.${PDY}
if [ ! -d $noscrub ]; then mkdir -p $noscrub; fi
cp $workdir/${network}.t${cyc}z.msonet.${tmmark}.bufr_d $noscrub/${network}.t${cyc}z.msonet.${tmmark}.bufr_d
chgrp rstprod $noscrub/${network}.t${cyc}z.msonet.${tmmark}.bufr_d
chmod 640 $noscrub/${network}.t${cyc}z.msonet.${tmmark}.bufr_d

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
statusfl=/com2/${network}/prod/${network}.${PDY}/${network}.t${cyc}z.status.${tmmark}.bufr_d
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

