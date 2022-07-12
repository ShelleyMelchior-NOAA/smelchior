. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump group: gpsro

set -x

userROOT=/gpfs/dell2/emc/obsproc/noscrub/$USER

# Determine server and make appropriate settings
server=$(echo $HOSTNAME | cut -c1)
if [ "$server" = "m" -o "$server" = "v" ]; then
  # Dell ph3: mars venus
  . $userROOT/gitstatic/fix/moduleload
  comroot=/gpfs/dell1/nco/ops/com
  stmp=/gpfs/dell2/stmp
  #export HOMEobsproc_dump=/gpfs/dell1/nco/ops/nwprod/obsproc_dump.v5.1.0
  export HOMEobsproc_dump=${userROOT}/gitstatic/EMC_obsproc_dump.gpsrocomm
  export HOMEobsproc_shared_bufr_dumplist=/gpfs/dell1/nco/ops/nwprod/obsproc_shared/bufr_dumplist.v2.3.0
elif [ "$server" = "l" -o "$server" = "s" ]; then
  # Cray: luna surge
  [ -d /opt/modules ] && . /opt/modules/default/init/sh > /dev/null 2>&1
  module load prod_envir
  module load prod_util
  module load cfp-intel-sandybridge/1.1.0
  comroot=/gpfs/hps/nco/ops/com
  stmp=/gpfs/hps3/stmp
  export HOMEobsproc_dump=/gpfs/hps/nco/ops/nwprod/obsproc_dump.v4.0.0
  export HOMEobsproc_shared_bufr_dumplist=/gpfs/hps/nco/ops/nwprod/obsproc_shared/bufr_dumplist.v1.5.0
else
  echo "Invalid server - EXITING!"
  exit
fi

# Check incoming args; must have 2, but 3rd is optional to run in backfill mode
test $# -lt 2 && echo "$0: <cyc> <network> (makeup PDY)"
test $# -lt 2 && exit

cyc=$1
network=$2 # gdas,gfs,rap
pid=$$

# Only run on dev machine
echo "begin source"
. ${userROOT}/gitstatic/ush/devprodtest.sh $$
echo "end source"

# compare 2 different date commands - diagnostic
#cat $comroot/date/t${cyc}z
#now=$(date +%Y%m%d)

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

workdir=$stmp/$USER/dumpjb_gpsro_${network}.${PDY}${cyc}.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir

export TMPDIR=$workdir

# !!! HOMEobsproc_dump set above in server settings !!!
#export HOMEobsproc_dump=$NWROOThps/obsproc_dump.v4.0.0
# !!! Make sure git work space is in correct branch !!!
# Pointing to git DB EMC_obsproc_dump: master
#export HOMEobsproc_dump=/gpfs/gd1/emc/meso/save/$USER/gitwkspc/EMC_obsproc_dump
#export HOMEobsproc_dump=$NWROOTp3/obsproc_dump.v5.0.1

# Set LALO and CRAD
if [ "$network" = "gfs" -o "$network" = "gdas" ]; then
  export LALO=0
  CRAD=3.0
elif [ "$network" = "rap" ]; then
  export LALO=F/gpfs/dell1/nco/ops/nwprod/obsproc_dump.v5.0.3/fix/nam_expdomain_halfdeg_imask.gbl 
  CRAD=0.5
else
  echo " network must be gdas, gfs, or rap - EXIT!"
  exit
fi

# !!! HOMEobsproc_shared_bufr_dumplist set above in server settings !!!
#export obsproc_shared_bufr_dumplist_ver=v1.5.0
#export HOMEobsproc_shared_bufr_dumplist=$NWROOThps/obsproc_shared/bufr_dumplist.$obsproc_shared_bufr_dumplist_ver
# !!! Make sure git works psace is in correct branch !!!
# Pointing to git DB EMC_obsproc_shared_bufr_dumplist: master
#export HOMEobsproc_shared_bufr_dumplist=/gpfs/gd1/emc/meso/save/Shelley.Melchior/gitwkspc/EMC_obsproc_shared_bufr_dumplist

# Dump dev gpsro comm tank
export TANK=$DCOMROOT/dev
DTIM_latest_gpsro=${DTIM_latest_gpsro:-"+2.99"}

echo $HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD gpsro
$HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD gpsro


# copy gpsro.ibm to name GDA is expecting
destdir=${userROOT}/forDA/gpsro/com/gfs/prod/${network}.${PDY}/${cyc}/atmos
mkdir -p $destdir
cp $workdir/gpsro.ibm ${destdir}/${network}.t${cyc}z.gpsro.tm${tmmark}.bufr_d
cp $workdir/gpsro.out ${destdir}/gpsro.${network}.${PDY}${cyc}.out

# change group to rstprod
chgrp rstprod ${destdir}/${network}.t${cyc}z.gpsro.tm${tmmark}.bufr_d
chmod 640 ${destdir}/${network}.t${cyc}z.gpsro.tm${tmmark}.bufr_d

exit

#---------------------------------------------------------------

