. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump group:efclam 

set -x

# Determine server and make appropriate settings
server=$(echo $HOSTNAME | cut -c1)
if [ "$server" = "m" -o "$server" = "v" ]; then
  # Dell ph3: mars venus
  module load ips/18.0.1.163
  module load prod_util/1.1.5
  module load prod_envir/1.1.0
  comroot=/gpfs/dell1/nco/ops/com
  stmp=/gpfs/dell2/stmp
  export HOMEobsproc_dump=/gpfs/dell1/nco/ops/nwprod/obsproc_dump.v5.1.0
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
elif [ "$server" = "t" -o "$server" = "g" ]; then
  # IBM ph1/2: tide gyre
  module load prod_envir
  module load prod_util
  comroot=/com
  stmp=/stmpp1
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
network=$2 # gdas,gfs,rap,nam
pid=$$

# test if this is the prod machine
# pass in $pid
gitstatic=/gpfs/dell2/emc/obsproc/noscrub/$USER/gitstatic
ushdir=${gitstatic}/ush
sh $ushdir/devprodtest.sh ${pid}
returnfile=$stmp/$USER/devprodtest.${pid}.out
rc=$(cat $returnfile)
if [[ $rc != 0 ]]; then
  echo 'prod machine - exit'
  rm $returnfile
#  exit
fi
rm $returnfile

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

workdir=$stmp/$USER/dumpjb_efclam_${network}.${PDY}${cyc}.$$
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
elif [ "$network" = "rap" -o "$network" = "nam" -o "$network" = "rtma" ]; then
  export LALO=F${HOMEobsproc_dump}/fix/nam_expdomain_halfdeg_imask.gbl 
  CRAD=0.5
else
  echo " network must be gdas, gfs, rap, or nam - EXIT!"
  exit
fi

# !!! HOMEobsproc_shared_bufr_dumplist set above in server settings !!!
#export obsproc_shared_bufr_dumplist_ver=v1.5.0
#export HOMEobsproc_shared_bufr_dumplist=$NWROOThps/obsproc_shared/bufr_dumplist.$obsproc_shared_bufr_dumplist_ver
# !!! Make sure git works space is in correct branch !!!
# Pointing to git DB EMC_obsproc_shared_bufr_dumplist: master
#export HOMEobsproc_shared_bufr_dumplist=/gpfs/gd1/emc/meso/save/Shelley.Melchior/gitwkspc/EMC_obsproc_shared_bufr_dumplist

# Dump efclam tank
# Sudhr's sample tank from UWisc updates
export TANK=/gpfs/dell2/emc/obsproc/noscrub/Sudhir.Nadiga/DCOMDIR/TEST/prod

echo $HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD efclam
$HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD efclam


# cp *efclam.ibm to use filename format RTMA is expecting
mkdir -p $stmp/$USER/com/${2}/prod/${2}.${PDY}
cp $workdir/efclam.ibm $workdir/${2}.t${1}z.efclam.tm00.bufr_d
cp $workdir/efclam.ibm $stmp/$USER/com/${2}/prod/${2}.${PDY}/${2}.t${1}z.efclam.tm00.bufr_d

exit

