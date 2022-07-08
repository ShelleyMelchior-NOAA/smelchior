. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump group: msonet

set -x

userROOT=/gpfs/dell2/emc/obsproc/noscrub/$USER

# Determine server and make appropriate settings
server=$(echo $HOSTNAME | cut -c1)
if [ "$server" = "m" -o "$server" = "v" ]; then
  # Dell ph3: mars venus
  . $userROOT/gitstatic/fix/moduleload
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
else
  echo "Invalid server - EXITING!"
  exit
fi

# Check incoming args; must have 2, but 3rd is optional to run in backfill mode
test $# -lt 2 && echo "$0: <cyc> <network> (makeup PDY)"
test $# -lt 2 && exit

cyc=$1
network=$2 # gdas,gfs,rap,rtma,urma
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

workdir=$stmp/$USER/dumpjb_msonet_${network}.${PDY}${cyc}.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir

export TMPDIR=$workdir

# !!! HOMEobsproc_dump set above in server settings !!!
# !!! HOMEobsproc_shared_bufr_dumplist set above in server settings !!!

# Set LALO and CRAD
if [ "$network" = "gfs" -o "$network" = "gdas" ]; then
  export LALO=0
  CRAD=3.0
elif [ "$network" = "rap" ]; then
  export LALO=F/gpfs/dell1/nco/ops/nwprod/obsproc_dump.v5.1.0/fix/nam_expdomain_halfdeg_imask.gbl 
  CRAD=0.5
elif [ "$network" = "rtma" -o "$network" = "urma" ]; then
  export LALO=F/gpfs/dell1/nco/ops/nwprod/obsproc_dump.v5.1.0/fix/nam_expdomain_guam_halfdeg_imask.gbl 
  CRAD=0.5
else
  echo " network must be gdas, gfs, rap, rtma, or urma - EXIT!"
  exit
fi

# Use production sdmedit or sample sdmedit
#export EPRM=$DCOMROOT/prod/sdmedit #prod
export EPRM=/gpfs/dell3/emc/modeling/save/Matthew.T.Morris/scripts/cwop_aws_flagging/current_sdmedit_12Mar2021.txt
#export EPRM=/gpfs/dell2/emc/modeling/save/Matthew.T.Morris/scripts/cwop_aws_flagging/sample_updated_sdmedit_file.txt

echo $HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD msonet
$HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD msonet


# copy msonet.ibm to name prep processing is expecting
destdir=${userROOT}/forMM/msonet/com/${network}/prod/${network}.${PDY}
mkdir -p $destdir
cp $workdir/msonet.ibm ${destdir}/${network}.t${cyc}z.msonet.tm${tmmark}.bufr_d
cp $workdir/msonet.out ${destdir}/msonet.${network}.${PDY}${cyc}.out

exit

#---------------------------------------------------------------

