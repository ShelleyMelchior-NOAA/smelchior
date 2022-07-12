. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump group: gsrasr gsrcsr 

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
  obsproc_dump_ver=v5.0.1
  export HOMEobsproc_dump=/gpfs/dell1/nco/ops/nwprod/obsproc_dump.${obsproc_dump_ver}
# export HOMEobsproc_shared_bufr_dumplist=/gpfs/dell1/nco/ops/nwprod/obsproc_shared/bufr_dumplist.v2.0.1
  export HOMEobsproc_shared_bufr_dumplist=/gpfs/dell2/emc/obsproc/noscrub/$USER/gitstatic/obsproc_shared/bufr_dumplist.v2.0.1-gsrasr_gsrcsr
elif [ "$server" = "l" -o "$server" = "s" ]; then
  # Cray: luna surge
  [ -d /opt/modules ] && . /opt/modules/default/init/sh > /dev/null 2>&1
  module load prod_envir
  module load prod_util
  module load cfp-intel-sandybridge/1.1.0
  comroot=/gpfs/hps/nco/ops/com
  stmp=/gpfs/hps3/stmp
  obsproc_dump_ver=v4.0.0
  export HOMEobsproc_dump=/gpfs/hps/nco/ops/nwprod/obsproc_dump.${obsproc_dump_ver}
  export HOMEobsproc_shared_bufr_dumplist=/gpfs/hps/nco/ops/nwprod/obsproc_shared/bufr_dumplist.v1.5.0
elif [ "$server" = "t" -o "$server" = "g" ]; then
  # IBM ph1/2: tide gyre
  module load prod_envir
  module load prod_util
  comroot=/com
  stmp=/stmpp1
  obsproc_dump_ver=v4.0.0
  export HOMEobsproc_dump=/gpfs/hps/nco/ops/nwprod/obsproc_dump.${obsproc_dump_ver}
  export HOMEobsproc_shared_bufr_dumplist=/gpfs/hps/nco/ops/nwprod/obsproc_shared/bufr_dumplist.v1.5.0
else
  echo "Invalid server - EXITING!"
  exit
fi

# Check incoming args; must have 3, but 4th is optional to run in backfill mode
test $# -lt 3 && echo "$0: <cyc> <network> <instrument>(makeup PDY)"
test $# -lt 3 && exit

# Assign incoming args
cyc=$1
network=$2 # gdas,gfs,rap
instrument=$3 # baseline, enterprise
pid=$$

# Assign PDY
export PDY=$(cat $comroot/date/t${cyc}z | cut -d' ' -f3 | cut -c1-8)
if [ ! -z "$4" ]
then
  export PDY=$4  # PDY setting when running in backfill mode
fi
#export PDY=20160117 # may need to hard set the date if /com/date/t00z has already been updated

tmmark=00
CDATE=${PDY}${cyc}

# Assign directories
workdir=$stmp/$USER/dumpjb_gsrcsr_${network}.${PDY}${cyc}.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir
export TMPDIR=$workdir

# Set LALO and CRAD
if [ "$network" = "gfs" -o "$network" = "gdas" ]; then
  export LALO=0
  CRAD=3.0
elif [ "$network" = "rap" ]; then
# export LALO=F/gpfs/${server}p1/nco/ops/nwprod/obsproc_dump.${obsproc_dump_ver}/fix/nam_expdomain_halfdeg_imask.gbl 
  export LALO=0     # for gsrasr and gsrcsr
  CRAD=0.5
else
  echo " network must be gdas, gfs, or rap - EXIT!"
  exit
fi

# Dump gsrasr gsrcsr tanks
if [ "$instrument" = "baseline" ]; then
  # basline
  if [ "$network" = "rap" ]; then
    export DTIM_earliest_021045="-1.00"
    export DTIM_latest_021045="+0.99"
    export DTIM_earliest_021046="-1.00"
    export DTIM_latest_021046="+0.99"
  elif [ "$network" = "gfs" -o "$network" = "gdas" ]; then
    export DTIM_earliest_021045="-3.00"
    export DTIM_latest_021045="+2.99"
    export DTIM_earliest_021046="-3.00"
    export DTIM_latest_021046="+2.99"
  else
    echo "ERROR - Network must be gdas, gfs, or rap."
    echo "EXITING"
    exit
  fi
  export TANK_021045=/gpfs/dell2/emc/obsproc/noscrub/Sudhir.Nadiga/YL2SN.dcom_goes16_asr_baseline.v2/us007003
  export TANK_021046=/gpfs/td1/emc/meso/noscrub/Sudhir.Nadiga/YL2SN.dcom_goes16_csr_baseline.v2/us007003
elif [ "$instrument" = "enterprise" ]; then
  # enterprise
  if [ "$network" = "rap" ]; then
    export DTIM_earliest_021045="-4.00"
    export DTIM_latest_021045="+3.99"
    export DTIM_earliest_021046="-4.00"
    export DTIM_latest_021046="+3.99"
  elif [ "$network" = "gfs" -o "$network" = "gdas" ]; then
    export DTIM_earliest_021045="-3.00"
    export DTIM_latest_021045="+2.99"
    export DTIM_earliest_021046="-3.00"
    export DTIM_latest_021046="+2.99"
  else
    echo "ERROR - Network must be gdas, gfs, or rap."
    echo "EXITING"
    exit
  fi
  export TANK_021045=/gpfs/td1/emc/meso/noscrub/Sudhir.Nadiga/YL2SN.dcom_goes16_asr_en/us007003
  export TANK_021046=/gpfs/td1/emc/meso/noscrub/Sudhir.Nadiga/YL2SN.dcom_goes16_csr.v2/us007003
else
  echo "ERROR - Specify instrument: baseline or enterprise"
  echo "EXITING"
  exit
fi

#export TANK=$DCOMROOT/us007003

echo $HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD gsrasr gsrcsr 
$HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD gsrasr gsrcsr


# cp gsrasr.ibm and gsrcsr.ibm to local /com location
# use filename format GSI is expecting
mkdir -p $stmp/$USER/com/prod/${2}.${PDY}
cp $workdir/gsrasr.ibm $stmp/$USER/com/prod/${2}.${PDY}/${2}.t${1}z.gsrasr.tm00.bufr_d
cp $workdir/gsrcsr.ibm $stmp/$USER/com/prod/${2}.${PDY}/${2}.t${1}z.gsrcsr.tm00.bufr_d

set +x

echo ""
ls -l $workdir/gsrasr.ibm $workdir/gsrcsr.ibm
echo ""
/u/Jeff.Whiting/bin/go_chkdat $workdir/gsrasr.ibm
/u/Jeff.Whiting/bin/go_chkdat $workdir/gsrcsr.ibm

exit

