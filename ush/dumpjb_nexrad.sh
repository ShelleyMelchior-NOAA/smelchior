. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump group:  nexrad

set -x

# Check incoming args; must have 2, but 3rd is optional to run in backfill mode
test $# -lt 2 && echo "$0: <cyc> <network> (makeup) (tmhr)"
test $# -lt 2 && exit

cyc=$1
network=$2 # cdas
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

workdir=/gpfs/dell2/stmp/$USER/dumpjb_nexrad_${network}.${PDY}${cyc}.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir

export TMPDIR=$workdir

export HOMEobsproc_dump=$NWROOT/obsproc_dump.v5.1.0
# !!! Make sure git work space is in correct branch !!!
# Pointing to git DB EMC_obsproc_dump: obsproc_dump.tkt-222.TAC2BUFR_SYNOP
#export HOMEobsproc_dump=/gpfs/gd1/emc/meso/save/$USER/gitwkspc/EMC_obsproc_dump

export TIME_TRIM=off

# NEXRAD tanks are hourly
# Process only those hourly tanks w/i requested dump center cycle time window
export SKIP_006010=YES # radial wind  00Z
export SKIP_006011=YES # radial wind  01Z
export SKIP_006012=YES # radial wind  02Z
export SKIP_006013=YES # radial wind  03Z
export SKIP_006014=YES # radial wind  04Z
export SKIP_006015=YES # radial wind  05Z
export SKIP_006016=YES # radial wind  06Z
export SKIP_006017=YES # radial wind  07Z
export SKIP_006018=YES # radial wind  08Z
export SKIP_006019=YES # radial wind  09Z
export SKIP_006020=YES # radial wind  10Z
export SKIP_006021=YES # radial wind  11Z
export SKIP_006022=YES # radial wind  12Z
export SKIP_006023=YES # radial wind  13Z
export SKIP_006024=YES # radial wind  14Z
export SKIP_006025=YES # radial wind  15Z
export SKIP_006026=YES # radial wind  16Z
export SKIP_006027=YES # radial wind  17Z
export SKIP_006028=YES # radial wind  18Z
export SKIP_006029=YES # radial wind  19Z
export SKIP_006030=YES # radial wind  20Z
export SKIP_006031=YES # radial wind  21Z
export SKIP_006032=YES # radial wind  22Z
export SKIP_006033=YES # radial wind  23Z
export SKIP_006040=YES # reflectivity 00Z
export SKIP_006041=YES # reflectivity 01Z
export SKIP_006042=YES # reflectivity 02Z
export SKIP_006043=YES # reflectivity 03Z
export SKIP_006044=YES # reflectivity 04Z
export SKIP_006045=YES # reflectivity 05Z
export SKIP_006046=YES # reflectivity 06Z
export SKIP_006047=YES # reflectivity 07Z
export SKIP_006048=YES # reflectivity 08Z
export SKIP_006049=YES # reflectivity 09Z
export SKIP_006050=YES # reflectivity 10Z
export SKIP_006051=YES # reflectivity 11Z
export SKIP_006052=YES # reflectivity 12Z
export SKIP_006053=YES # reflectivity 13Z
export SKIP_006054=YES # reflectivity 14Z
export SKIP_006055=YES # reflectivity 15Z
export SKIP_006056=YES # reflectivity 16Z
export SKIP_006057=YES # reflectivity 17Z
export SKIP_006058=YES # reflectivity 18Z
export SKIP_006059=YES # reflectivity 19Z
export SKIP_006060=YES # reflectivity 20Z
export SKIP_006061=YES # reflectivity 21Z
export SKIP_006062=YES # reflectivity 22Z
export SKIP_006063=YES # reflectivity 23Z

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
  DTIM_latest_nexrad=${DTIM_latest_nexrad:-"+2.99"}
  if [ $cyc -eq 00 ]; then   # (22.5 - 01.5 Z)
    unset SKIP_006032 # radial wind  22Z
    unset SKIP_006033 # radial wind  23Z
    unset SKIP_006010 # radial wind  00Z
    unset SKIP_006011 # radial wind  01Z
    unset SKIP_006062 # reflectivity 22Z
    unset SKIP_006063 # reflectivity 23Z
    unset SKIP_006040 # reflectivity 00Z
    unset SKIP_006041 # reflectivity 01Z
  elif [ $cyc -eq 06 ]; then # (04.5 - 07.5 Z)
    unset SKIP_006014 # radial wind  04Z
    unset SKIP_006015 # radial wind  05Z
    unset SKIP_006016 # radial wind  06Z
    unset SKIP_006017 # radial wind  07Z
    unset SKIP_006044 # reflectivity 04Z
    unset SKIP_006045 # reflectivity 05Z
    unset SKIP_006046 # reflectivity 06Z
    unset SKIP_006047 # reflectivity 07Z
  elif [ $cyc -eq 12 ]; then # (10.5 - 13.5 Z)
    unset SKIP_006020 # radial wind  10Z
    unset SKIP_006021 # radial wind  11Z
    unset SKIP_006022 # radial wind  12Z
    unset SKIP_006023 # radial wind  13Z
    unset SKIP_006050 # reflectivity 10Z
    unset SKIP_006051 # reflectivity 11Z
    unset SKIP_006052 # reflectivity 12Z
    unset SKIP_006053 # reflectivity 13Z
  elif [ $cyc -eq 18 ]; then # (16.5 - 19.5 Z)
    unset SKIP_006026 # radial wind  16Z
    unset SKIP_006027 # radial wind  17Z
    unset SKIP_006028 # radial wind  18Z
    unset SKIP_006029 # radial wind  19Z
    unset SKIP_006056 # reflectivity 16Z
    unset SKIP_006057 # reflectivity 17Z
    unset SKIP_006058 # reflectivity 18Z
    unset SKIP_006059 # reflectivity 19Z
  fi 
else
  echo " network must be gdas, gfs, rap, nam, or cdas - EXIT!"
  exit
fi

export obsproc_shared_bufr_dumplist_ver=v2.3.0
export HOMEobsproc_shared_bufr_dumplist=$NWROOT/obsproc_shared/bufr_dumplist.$obsproc_shared_bufr_dumplist_ver
# !!! Make sure git works psace is in correct branch !!!
# Pointing to git DB EMC_obsproc_shared_bufr_dumplist: obsproc_shared_bufr_dumplist.tkt-222.TAC2BUFR_SYNOP
#export HOMEobsproc_shared_bufr_dumplist=/gpfs/gd1/emc/meso/save/Shelley.Melchior/gitwkspc/EMC_obsproc_shared_bufr_dumplist

# NCO para tank ("bad")
export TANK_006051=/gpfs/dell2/emc/obsproc/noscrub/Shelley.Melchior/nexrad/prod

echo $HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD nexrad
$HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD nexrad 

exit

