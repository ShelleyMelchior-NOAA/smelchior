. /u/Shelley.Melchior/.bashrc

# Run dumpjb for regional dump dataset:
# efclam

set -x

# Check incoming args; must have 2, but 3rd is optional to run in backfill mode
test $# -lt 2 && echo "$0: <cyc> <network> (makeup)"
test $# -lt 2 && exit

export cyc=$1
network=$2 # gdas,gfs,rap
pid=$$

userROOT=/gpfs/dell2/emc/obsproc/noscrub/$USER

# Only run on dev machine
#echo "begin source"
#. ${userROOT}/gitstatic/ush/devprodtest.sh $$
#echo "end source"

# source moduleload file
. $userROOT/gitstatic/fix/moduleload

# Canned com
#COMROOTcanned=/lfs/h1/ops/canned/com
# compare 2 different date commands - diagnostic
#cat ${COMROOT}/date/t${cyc}z
#cat ${COMROOTcanned}/date/t${cyc}z
#now=$(date +%Y%m%d)


#export PDY=$(cat $COMROOT/date/t${cyc}z | cut -d' ' -f3 | cut -c1-8)
if [ ! -z "$3" ]
then
  export PDY=$3  # PDY setting when running in backfill mode
fi
export PDY=20210824 # if you need to hard set the date

CDATE=${PDY}${cyc}

workdir=/gpfs/dell2/stmp/$USER/dumpjb_efclam_${network}.${PDY}${cyc}.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir

export TMPDIR=$workdir
echo "BUFR_DUMPLIST=$BUFR_DUMPLIST"
echo "DUMPJB=$DUMPJB"


# !!! Make sure git work space is in correct branch !!!
# Pointing to git DB EMC_obsproc_dump: obsproc_dump.iss86538.dupsyp-bug
export HOMEobsproc_dump=${NWROOT}/obsproc_dump.v5.2.0
export HOMEobsproc_shared_bufr_dumplist=$NWROOT/obsproc_shared/bufr_dumplist.v2.4.0

# Set LALO and CRAD
if [ "$network" = "gfs" -o "$network" = "gdas" ]; then
  export LALO=0
  CRAD=3.0
elif [ "$network" = "rap" ]; then
  export LALO=F/gpfs/gp1/nco/ops/nwprod/obsproc_dump.v3.3.0/fix/nam_expdomain_halfdeg_imask.gbl
  CRAD=0.5
else
  echo " network must be gdas, gfs, or rap - EXIT!"
  exit
fi

#export DCOMROOT=/gpfs/dell1/nco/ops/dcom/canned
export TANK=/gpfs/dell1/nco/ops/dcom/canned

echo ${HOMEobsproc_dump}/ush/dumpjb $CDATE $CRAD efclam 
${HOMEobsproc_dump}/ush/dumpjb $CDATE $CRAD efclam 

exit
