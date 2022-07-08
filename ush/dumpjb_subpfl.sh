. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump group: subpfl

set -x

# Check incoming args; must have 2, but 3rd is optional to run in backfill mode
test $# -lt 2 && echo "$0: <cyc> <network> (makeup)"
test $# -lt 2 && exit

export cyc=$1
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
cat /com/date/t${cyc}z
now=$(date +%Y%m%d)

export PDY=$(cat $COMROOT/date/t${cyc}z | cut -d' ' -f3 | cut -c1-8)
if [ ! -z "$3" ]
then
  export PDY=$3  # PDY setting when running in backfill mode
fi
#export PDY=20160117 # may need to hard set the date if /com/date/t00z has already been updated

# Test that the two dates are equal
# This test is a safeguard on the occasion that $COMROOT/date/t${cyc}z is delayed in being updated.
# This most particularly will affect 00Z and 12Z runs.
#if [ ${now} -ne ${PDY} ]; then
#  echo "$COMROOT/date/t${cyc}z has not yet been updated"
#  PDY=${now}
#fi

tmmark=00
CDATE=${PDY}${cyc}

workdir=/gpfs/dell2/stmp/$USER/dumpjb_subpfl_${network}.${PDY}${cyc}.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir

export TMPDIR=$workdir

export HOMEobsproc_dump=$NWROOT/obsproc_dump.v5.1.0
# !!! Make sure git work space is in correct branch !!!
# Pointing to git DB EMC_obsproc_dump: obsproc_dump.iss57275.maxout
#export HOMEobsproc_dump=${userROOT}/gitstatic/EMC_obsproc_dump.iss57275.maxout

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

export obsproc_shared_bufr_dumplist_ver=v2.3.0
export HOMEobsproc_shared_bufr_dumplist=$NWROOT/obsproc_shared/bufr_dumplist.$obsproc_shared_bufr_dumplist_ver
# !!! Make sure git work space is in correct branch !!!
# Pointing to git DB EMC_obsproc_shared_bufr_dumplist: obsproc_shared_bufr_dumplist.tkt-222.TAC2BUFR_SYNOP
#export HOMEobsproc_shared_bufr_dumplist=/gpfs/gd1/emc/meso/save/Shelley.Melchior/gitwkspc/EMC_obsproc_shared_bufr_dumplist

export DTIM_latest_subpfl=${DTIM_latest_subpfl:-"+2.99"}

echo $HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD subpfl
$HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD subpfl

exit

# copy adpsfc.ibm to name and location prep processing is expecting
filename=${network}.t${cyc}z.adpsfc.tm${tmmark}.bufr_d
tstspdir=/gpfs/dell2/ptmp/$USER/dupsyp-debug/com/gfs/prod/${network}.${PDY}/${cyc}
mkdir -p $tstspdir
cp $workdir/adpsfc.ibm ${tstspdir}/${filename}

#export tstsp=$workdir/${network}.t${cyc}z.

mv $workdir/adpsfc.out $workdir/adpsfc.${network}.out

# Check to make sure status file exists
i=1
while [ "$i" -ne 0 ]
do
  ls $COMROOT/gfs/prod/${network}.${PDY}/${cyc}/${network}.t${cyc}z.status.tm*.bufr_d
  if [ $? -eq 0 ]; then
    # Kick off jglobal_prep job
    DESC="dupsyp-debug"
    unset LSB_SUB_RES_REQ
    jtyp=$network desc=$DESC bash -l /u/$USER/bin/cycbsub \
    ${userROOT}/gitstatic/EMC_obsproc_melchior/jobs/jglobal_prep.ph3.lsf.dupsyp-debug 
    i=0
  else
    sleep 20
    i=$((i + 1))
    if [ "$i" -eq 60 ]; then break; fi
  fi
done

exit

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

