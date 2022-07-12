. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump groups: 1bamua 1bmhs 

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
  export HOMEobsproc_dump=/gpfs/dell1/nco/ops/nwprod/obsproc_dump.v5.0.1
  export HOMEobsproc_shared_bufr_dumplist=/gpfs/dell1/nco/ops/nwprod/obsproc_shared/bufr_dumplist.v2.0.1
  # only run on dev machine
  pid=$$
  ushdir=/gpfs/dell2/emc/obsproc/noscrub/$USER/gitstatic/ush
  sh $ushdir/devprodtest.sh ${pid} 
  returnfile=${stmp}/$USER/devprodtest.${pid}.out
  rc=$(cat $returnfile)
  if [[ $rc != 0 ]]; then
    echo 'prod machine - exit'
    rm $returnfile
    exit
  fi
  rm $returnfile
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
if [ "$2" = "nam" ]; then
  test $# -lt 3 && echo "$0: <cyc> <network> <tmmark> (makeup PDY)"
  test $# -lt 3 && exit
fi

# Assign incoming args
cyc=$1
network=$2 # gdas,gfs,rap,nam
pid=$$

# Assign PDY
export PDY=$(cat $comroot/date/t${cyc}z | cut -d' ' -f3 | cut -c1-8)
if [ "$cyc" = "12" -o "${cyc}" = "18" -o "${cyc}" = "06" ]; then
  export PDY=$(date +%Y%m%d)  # sometimes production date file doesn't update in time for cycle run
fi
if [ "$network" != "nam" ]; then
  tmmark=00
  if [ ! -z "$3" ]; then
    export PDY=$3  # PDY setting when running in backfill mode
  fi
else  # assign tmmark for nam
  tmmark=$3
  if [ "$cyc" = "00" ]; then  # tm02-06 for 00Z run on prior day to PDY
    if [ "$tmmark" != "00" -a "$tmmark" != "01" ]; then
      PDYp1=$(sh $UTILROOT/ush/finddate.sh $PDY d+1)
      export PDY=$PDYp1
    fi
  fi
  if [ ! -z "$4" ]; then
    export PDY=$4  # PDY setting when running in backfill mode
  fi
fi

CDATE=${PDY}${cyc}

# Assign directories
workdir=$stmp/$USER/dumpjb_1bamua_1bmhs_${network}.${PDY}${cyc}_${tmmark}.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir
export TMPDIR=$workdir

# Set LALO and CRAD
if [ "$network" = "gfs" -o "$network" = "gdas" ]; then
  export LALO=0
  CRAD=3.0
  export DTIM_latest_1bamua="+2.99"
  export DTIM_latest_1bmhs="+2.99"
elif [ "$network" = "rap" ]; then # for rap or rap_e
  export LALO=F/gpfs/hps/nco/ops/nwprod/obsproc_dump.v4.0.0/fix/nam_expdomain_halfdeg_imask.gbl
  CRAD=3.0
  export DTIM_latest_1bamua="+2.99"
  export DTIM_latest_1bmhs="+2.99"
elif [ "$network" = "nam" ]; then 
  export LALO=F/gpfs/tp1/nco/ops/nwprod/obsproc_dump.v3.3.0/fix/nam_expdomain_halfdeg_imask.gbl 
  CRAD=0.5
  CDATE=$($UTILROOT/exec/ips/ndate -${tmmark} ${PDY}${cyc})
  if [ "$tmmark" = "00" ]; then
    export DTIM_earliest_1bamua="-0.75"
    export DTIM_latest_1bamua="+1.50"
    export DTIM_earliest_1bmhs="-0.75"
    export DTIM_latest_1bmhs="+1.50"
  else
    export DTIM_earliest_1bamua="-1.00"
    export DTIM_latest_1bamua="+0.99"
    export DTIM_earliest_1bmhs="-1.00"
    export DTIM_latest_1bmhs="+0.99"
  fi
else
  echo " network must be gdas, gfs, rap or nam - EXIT!"
  exit
fi

# Dump Metop-C 1bamua and 1bmhs tanks
#export TANK=$DCOMROOT/us007003
export TANK=/gpfs/dell2/emc/obsproc/noscrub/Sudhir.Nadiga/dcom_itovs/us007003


echo $HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD 1bamua 1bmhs
$HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD 1bamua 1bmhs


# cp 1b*.ibm to /com location using familiar filename format NAM is expecting 
mkdir -p $stmp/$USER/com/prod/${2}.${PDY}
cp $workdir/1bamua.ibm $stmp/$USER/com/prod/${2}.${PDY}/${2}.t${1}z.1bamua.tm${tmmark}.bufr_d
cp $workdir/1bmhs.ibm $stmp/$USER/com/prod/${2}.${PDY}/${2}.t${1}z.1bmhs.tm${tmmark}.bufr_d

exit

