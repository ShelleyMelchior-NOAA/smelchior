. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump group: crisdb atmsdb iasidb (from GTS feed) 

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
  export HOMEobsproc_shared_bufr_dumplist=/gpfs/dell1/nco/ops/nwprod/obsproc_shared/bufr_dumplist.v2.0.1
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

# Check incoming args; must have 2, but 3rd is optional to run in backfill mode
test $# -lt 2 && echo "$0: <cyc> <network> (makeup PDY)"
test $# -lt 2 && exit

# Assign incoming args
cyc=$1
network=$2 # gdas,gfs,rap
pid=$$

# Assign PDY
export PDY=$(cat $comroot/date/t${cyc}z | cut -d' ' -f3 | cut -c1-8)
if [ ! -z "$3" ]
then
  export PDY=$3  # PDY setting when running in backfill mode
fi
#export PDY=20160117 # may need to hard set the date if /com/date/t00z has already been updated

tmmark=00
CDATE=${PDY}${cyc}

# Assign directories
workdir=$stmp/$USER/dumpjb_GTSdb_${network}.${PDY}${cyc}.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir
export TMPDIR=$workdir

# Set LALO and CRAD
if [ "$network" = "gfs" -o "$network" = "gdas" ]; then
  export LALO=0
  CRAD=3.0
elif [ "$network" = "rap" ]; then
  export LALO=F/gpfs/${server}p1/nco/ops/nwprod/obsproc_dump.${obsproc_dump_ver}/fix/nam_expdomain_halfdeg_imask.gbl 
  CRAD=0.5
else
  echo " network must be gdas, gfs, or rap - EXIT!"
  exit
fi

# Dump GTS feed DB cris, atms, and iasi tanks
export DTIM_latest_crisdb="+2.99"
export DTIM_latest_atmsdb="+2.99"
export DTIM_latest_iasidb="+2.99"
export TANK_021212=/gpfs/tp1/dcomdev/us007003
export TANK_021213=/gpfs/tp1/dcomdev/us007003
export TANK_021239=/gpfs/tp1/dcomdev/us007003
#export TANK=$DCOMROOT/us007003

echo $HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD crisdb atmsdb iasidb
$HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD crisdb atmsdb iasidb


# cp *db.ibm to local /com location
# use filename format GSI is expecting
mkdir -p $stmp/$USER/com/prod/${2}.${PDY}
cp $workdir/crisdb.ibm $stmp/$USER/com/prod/${2}.${PDY}/${2}.t${1}z.crisdb.tm00.bufr_d
cp $workdir/atmsdb.ibm $stmp/$USER/com/prod/${2}.${PDY}/${2}.t${1}z.atmsdb.tm00.bufr_d
cp $workdir/iasidb.ibm $stmp/$USER/com/prod/${2}.${PDY}/${2}.t${1}z.iasidb.tm00.bufr_d

exit

